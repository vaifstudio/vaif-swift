import Foundation
import Network
import Testing
@testable import VaifClient

actor FakeSocket: RealtimeSocket {
    var incoming: [JSONValue]
    var sent: [JSONValue] = []
    var closed = false
    init(_ incoming: [JSONValue]) { self.incoming = incoming }
    func send(_ frame: JSONValue) async throws { sent.append(frame) }
    func receive() async throws -> JSONValue {
        if !incoming.isEmpty { return incoming.removeFirst() }
        while !closed { try await Task.sleep(nanoseconds: 10_000_000) }
        throw CancellationError()
    }
    func close() async { closed = true }
}

/// A socket that never sends anything. Closing it fails a pending receive at
/// once and then takes 100 ms to return, like a WebSocket close handshake.
actor SlowClosingSocket: RealtimeSocket {
    private var waiter: CheckedContinuation<JSONValue, Error>?
    private(set) var closed = false
    func send(_ frame: JSONValue) async throws {}
    func receive() async throws -> JSONValue {
        if closed { throw URLError(.networkConnectionLost) }
        return try await withCheckedThrowingContinuation { waiter = $0 }
    }
    func close() async {
        closed = true
        waiter?.resume(throwing: URLError(.networkConnectionLost))
        waiter = nil
        try? await Task.sleep(nanoseconds: 100_000_000)
    }
}

@Suite struct RealtimeTests {
    @Test func handshakeThenSubscribeReceiveAndUnsubscribe() async throws {
        let stub = Stub { _, _ in .status(500) }
        let auth = try makeClient(stub).auth
        try await auth.setSession(accessToken: "user", refreshToken: nil)
        let socket = FakeSocket([
            ["type": "welcome"],
            ["type": "subscribed", "channel": "table:todos"],
            ["type": "db_change", "channel": "table:todos", "table": "todos", "op": "INSERT", "record": ["id": "1"]],
        ])
        let realtime = RealtimeClient(transport: try makeClient(stub).transport, auth: auth, connect: { url in
            #expect(url.path == "/realtime/ws" && url.scheme == "wss")
            #expect(url.query == nil)
            return socket
        })
        let subscription = try await realtime.subscribe(table: "todos")
        var iterator = subscription.events.makeAsyncIterator()
        let event = try await iterator.next()
        #expect(event?.operation == "INSERT" && event?.record?["id"] == "1")
        let sent = await socket.sent
        #expect(sent.first == ["type": "auth", "apiKey": .string(testKey), "accessToken": "user"])
        #expect(sent.dropFirst().first == ["type": "subscribe", "channel": "table:todos"])
        await subscription.unsubscribe()
        #expect(await socket.closed)
    }

    @Test func authErrorClosesWithoutSubscribing() async throws {
        let stub = Stub { _, _ in .status(500) }
        let client = try makeClient(stub)
        let socket = FakeSocket([["type": "error", "code": "TOKEN_INVALID", "message": "Invalid token"]])
        let realtime = RealtimeClient(transport: client.transport, auth: client.auth, connect: { _ in socket })
        #expect(await vaifError { _ = try await realtime.subscribe(table: "todos") }?.code == "TOKEN_INVALID")
        #expect(await socket.sent.count == 1)
        #expect(await socket.closed)
    }

    @Test func filtersAndColumnsBuildTheJSChannelWithEncodedValues() async throws {
        let stub = Stub { _, _ in .status(500) }
        let client = try makeClient(stub)
        let channel = "table:todos?owner_id.eq=a%26b%3Dc%2B%3F&priority.gte=2&status.in=open%2Cblocked&columns=id,title"
        let socket = FakeSocket([["type": "welcome"], ["type": "subscribed", "channel": .string(channel)]])
        let realtime = RealtimeClient(transport: client.transport, auth: client.auth, connect: { _ in socket })
        let subscription = try await realtime.subscribe(table: "todos",
            filters: [.eq("owner_id", "a&b=c+?"), .gte("priority", 2), .in("status", ["open", "blocked"])], columns: ["id", "title"])
        #expect(await socket.sent.last == ["type": "subscribe", "channel": .string(channel)])
        await subscription.unsubscribe()
        for bad in [RealtimeFilter.eq("bad field", 1), .in("tag", ["a,b"]), .in("tag", [String]())] {
            #expect(await vaifError { _ = try await realtime.subscribe(table: "todos", filters: [bad]) }?.kind == .invalidArgument)
        }
    }

    @Test func deleteEventsCarryTheRemovedRowAsOldRecord() async throws {
        let stub = Stub { _, _ in .status(500) }
        let client = try makeClient(stub)
        let socket = FakeSocket([
            ["type": "welcome"],
            ["type": "subscribed", "channel": "table:todos"],
            ["type": "db_change", "channels": ["table:other"], "table": "todos", "op": "INSERT", "record": ["id": "skip"]],
            ["type": "pong"],
            ["type": "db_change", "channels": ["table:todos"], "schema": "public", "table": "todos", "op": "UPDATE",
             "record": ["id": "1", "v": 2], "old_record": ["id": "1", "v": 1], "ts": "2026-10-26T00:00:00Z"],
            ["type": "db_change", "table": "todos", "op": "DELETE", "record": ["id": "1"]],
        ])
        let realtime = RealtimeClient(transport: client.transport, auth: client.auth, connect: { _ in socket })
        let subscription = try await realtime.subscribe(table: "todos")
        var iterator = subscription.events.makeAsyncIterator()
        let update = try await iterator.next()
        #expect(update?.operation == "UPDATE" && update?.record?["v"] == 2 && update?.oldRecord?["v"] == 1)
        #expect(update?.schema == "public" && update?.timestamp == "2026-10-26T00:00:00Z")
        let delete = try await iterator.next()
        #expect(delete?.operation == "DELETE" && delete?.record == nil && delete?.oldRecord?["id"] == "1")
        await subscription.unsubscribe()
    }

    @Test func errorFramesAreTyped() throws {
        #expect(throws: VaifError.self) { try RealtimeClient.checkError(["type": "error", "error": "InvalidChannel", "message": "bad"]) }
        func error(_ frame: JSONValue) -> VaifError? {
            do { try RealtimeClient.checkError(frame); return nil } catch { return error as? VaifError }
        }
        #expect(error(["type": "error", "error": "InvalidChannel"])?.code == "INVALID_CHANNEL")
        #expect(error(["type": "error", "error": "InvalidChannel"])?.kind == .validation)
        #expect(error(["type": "error", "error": "RateLimited"])?.kind == .rateLimited)
        #expect(error(["type": "error", "code": "TOKEN_INVALID", "closeCode": 4001])?.kind == .auth)
        #expect(error(["type": "error", "error": "AuthRefreshFailed"])?.kind == .auth)
        #expect(error(["type": "error", "error": "InvalidMessage"])?.kind == .request)
        #expect(error(["type": "welcome"]) == nil)
    }

    @Test func socketClosesAreTypedByTheAPICloseCodes() {
        let cause = URLError(.networkConnectionLost)
        #expect(RealtimeClient.closeError(code: 4001, reason: "Invalid API key", underlying: cause).kind == .auth)
        #expect(RealtimeClient.closeError(code: 4002, reason: nil, underlying: cause).code == "TOKEN_EXPIRED")
        #expect(RealtimeClient.closeError(code: 4003, reason: nil, underlying: cause).kind == .auth)
        #expect(RealtimeClient.closeError(code: 4029, reason: nil, underlying: cause).kind == .rateLimited)
        #expect(RealtimeClient.closeError(code: 4004, reason: nil, underlying: cause).kind == .notFound)
        let dropped = RealtimeClient.closeError(code: 1006, reason: nil, underlying: cause)
        #expect(dropped.kind == .network && dropped.code == "REALTIME_CLOSED" && dropped.message.contains("1006"))
        #expect(RealtimeClient.closeError(code: 4001, reason: "Invalid API key", underlying: cause).message.contains("Invalid API key"))
    }

    @Test func aTimeoutIsReportedEvenWhenClosingTheSocketFailsTheReceive() async throws {
        // A real WebSocket fails its pending receive as soon as it is closed,
        // while the close itself takes longer. The timeout must still win.
        let stub = Stub { _, _ in .status(500) }
        let client = try makeClient(stub)
        let socket = SlowClosingSocket()
        let realtime = RealtimeClient(transport: client.transport, auth: client.auth, connect: { _ in socket })
        let error = await vaifError { _ = try await realtime.subscribe(table: "todos", timeout: 0.05) }
        #expect(error?.kind == .timeout)
        #expect(error?.message == "realtime receive timed out")
        #expect(await socket.closed)
    }

    @Test func stalledHandshakeTimesOutAndCloses() async throws {
        let stub = Stub { _, _ in .status(500) }
        let client = try makeClient(stub)
        let socket = FakeSocket([])
        let realtime = RealtimeClient(transport: client.transport, auth: client.auth, connect: { _ in socket })
        #expect(await vaifError { _ = try await realtime.subscribe(table: "todos", timeout: 0.02) }?.kind == .timeout)
        #expect(await socket.closed)
    }
}

/// Thrown by the test `connect` closure in place of opening a socket.
private struct Dialed: Error { let url: URL }

/// The socket URL `subscribe` dials for a transport on `base`. The transport
/// is built directly, skipping `VaifClient`'s own baseURL check, so this
/// shows what realtime does by itself. Throws whatever `subscribe` throws
/// before dialing.
private func realtimeDial(_ base: String) async throws -> String? {
    let transport = Transport(baseURL: URL(string: base)!, apiKey: testKey, session: MockURLProtocol.session,
                              timeout: 5, retry: fastRetry, headers: [:])
    let auth = try AuthClient(transport: transport, projectId: testProject,
                          session: Session(accessToken: "at_secret", expiresAt: Date().addingTimeInterval(3600)))
    let realtime = RealtimeClient(transport: transport, auth: auth, connect: { url in throw Dialed(url: url) })
    do {
        _ = try await realtime.subscribe(table: "todos")
    } catch let dialed as Dialed {
        return dialed.url.absoluteString
    }
    return nil
}

/// Realtime dials wss for https in any case, ws only for localhost,
/// 127.0.0.1 and ::1, and fails closed with INVALID_REALTIME_URL otherwise.
@Suite struct RealtimeURLTests {
    @Test func httpsInAnyCaseBecomesWss() async throws {
        #expect(try await realtimeDial("HTTPS://api.example.com") == "wss://api.example.com/realtime/ws")
        #expect(try await realtimeDial("https://api.example.com") == "wss://api.example.com/realtime/ws")
        #expect(try await realtimeDial("Https://api.example.com/base") == "wss://api.example.com/base/realtime/ws")
    }

    @Test func httpBecomesWsOnlyForTheLocalHosts() async throws {
        #expect(try await realtimeDial("http://localhost:3147") == "ws://localhost:3147/realtime/ws")
        #expect(try await realtimeDial("HTTP://127.0.0.1:3147") == "ws://127.0.0.1:3147/realtime/ws")
        #expect(try await realtimeDial("http://[::1]:3147") == "ws://[::1]:3147/realtime/ws")
    }

    @Test func anythingElseThrowsBeforeDialing() async throws {
        for base in ["http://api.example.com", "HTTP://api.example.com", "ftp://x", "ws://api.example.com", "wss://api.example.com"] {
            let error = await vaifError { _ = try await realtimeDial(base) }
            #expect(error?.kind == .invalidArgument, "\(base)")
            #expect(error?.code == "INVALID_REALTIME_URL", "\(base)")
        }
    }

    @Test func aClientOnAnUppercaseHttpsBaseURLStillUsesWss() async throws {
        // VaifClient accepts the scheme in any case; the socket must still be encrypted.
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: URL(string: "HTTPS://api.example.com")!,
                                    sessionStore: MemorySessionStore(), urlSession: MockURLProtocol.session)
        let realtime = RealtimeClient(transport: client.transport, auth: client.auth, connect: { url in throw Dialed(url: url) })
        var dialed: String?
        do { _ = try await realtime.subscribe(table: "todos") } catch let error as Dialed { dialed = error.url.absoluteString }
        #expect(dialed == "wss://api.example.com/realtime/ws")
    }
}

/// Realtime failures surface as `VaifError`, never a raw transport or
/// decoding error.
@Suite struct RealtimeFrameTests {
    @Test func aFrameThatIsNotJSONIsAVaifError() throws {
        #expect(try RealtimeClient.frame(from: .string(#"{"type":"pong"}"#)) == ["type": "pong"])
        #expect(try RealtimeClient.frame(from: .data(Data(#"{"type":"welcome"}"#.utf8))) == ["type": "welcome"])
        for message in [URLSessionWebSocketTask.Message.string("<html>bad gateway</html>"), .data(Data([0xff, 0x00, 0x01]))] {
            do {
                _ = try RealtimeClient.frame(from: message)
                Issue.record("expected an error")
            } catch let error as VaifError {
                #expect(error.kind == .badResponse)
                #expect(error.code == "REALTIME_BAD_FRAME")
            } catch {
                Issue.record("expected a VaifError, got \(type(of: error))")
            }
        }
    }

    @Test func aFrameThatCannotBeEncodedIsAVaifError() throws {
        #expect(try RealtimeClient.text(of: ["type": "ping"]) == #"{"type":"ping"}"#)
        do {
            _ = try RealtimeClient.text(of: ["type": "auth", "n": .number(.infinity)])
            Issue.record("expected an error")
        } catch let error as VaifError {
            #expect(error.kind == .invalidArgument)
        } catch {
            Issue.record("expected a VaifError, got \(type(of: error))")
        }
    }
}

/// A one-shot HTTP responder on 127.0.0.1, for the WebSocket handshake test.
final class LoopbackHTTP: @unchecked Sendable {
    private let listener: NWListener
    private let lock = NSLock()
    private var lines: [String] = []

    init(answer: @escaping @Sendable (_ requestLine: String) -> String) throws {
        let parameters = NWParameters.tcp
        parameters.requiredLocalEndpoint = .hostPort(host: "127.0.0.1", port: .any)
        listener = try NWListener(using: parameters)
        listener.newConnectionHandler = { [weak self] connection in
            // A constant, because the receive completion is @Sendable and may
            // not capture the `weak var` itself.
            let owner = self
            connection.start(queue: .global())
            connection.receive(minimumIncompleteLength: 1, maximumLength: 65_536) { data, _, _, _ in
                let line = String(decoding: data ?? Data(), as: UTF8.self).components(separatedBy: "\r\n").first ?? ""
                owner?.record(line)
                connection.send(content: Data(answer(line).utf8), completion: .contentProcessed { _ in connection.cancel() })
            }
        }
        let ready = DispatchSemaphore(value: 0)
        listener.stateUpdateHandler = { if case .ready = $0 { ready.signal() } }
        listener.start(queue: .global())
        _ = ready.wait(timeout: .now() + 5)
    }

    deinit { listener.cancel() }

    var port: UInt16 { listener.port?.rawValue ?? 0 }

    private func record(_ line: String) { lock.lock(); lines.append(line); lock.unlock() }

    /// The request lines received, such as `GET /realtime/ws HTTP/1.1`.
    var requests: [String] { lock.lock(); defer { lock.unlock() }; return lines }
}

/// Realtime credentials travel in the first frame, so the socket must never
/// follow a handshake redirect to another origin.
@Suite struct RealtimeRedirectTests {
    @Test func aHandshakeRedirectToAnotherOriginIsRefused() async throws {
        let elsewhere = try LoopbackHTTP { _ in "HTTP/1.1 404 Not Found\r\nContent-Length: 0\r\nConnection: close\r\n\r\n" }
        let target = "http://localhost:\(elsewhere.port)/realtime/ws"
        let api = try LoopbackHTTP { _ in "HTTP/1.1 307 Temporary Redirect\r\nLocation: \(target)\r\nContent-Length: 0\r\nConnection: close\r\n\r\n" }
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: URL(string: "http://127.0.0.1:\(api.port)")!,
                                    sessionStore: MemorySessionStore(), urlSession: URLSession(configuration: .ephemeral))
        let error = await vaifError { _ = try await client.realtime.subscribe(table: "todos", timeout: 5) }
        #expect(api.requests == ["GET /realtime/ws HTTP/1.1"])
        // Without this check, the handshake would follow the redirect, and the
        // auth frame with the API key would go to that origin.
        #expect(elsewhere.requests.isEmpty)
        #expect(error?.code == "INSECURE_REDIRECT")
    }
}
