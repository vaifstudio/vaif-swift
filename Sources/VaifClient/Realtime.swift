import Foundation

protocol RealtimeSocket: Sendable {
    func send(_ frame: JSONValue) async throws
    func receive() async throws -> JSONValue
    func close() async
}

private final class FoundationSocket: RealtimeSocket, Sendable {
    let task: URLSessionWebSocketTask
    /// Refuses a handshake redirect to another origin: the auth frame must
    /// reach the API itself.
    let redirects = RedirectGuard(allowsOtherOrigins: false)
    init(url: URL, session: URLSession) {
        var request = URLRequest(url: url)
        request.httpShouldHandleCookies = false
        task = session.webSocketTask(with: request)
        task.delegate = redirects
        // Change frames carry whole rows; Foundation's default cap is 1 MiB.
        task.maximumMessageSize = 16 * 1024 * 1024
        task.resume()
    }
    func send(_ frame: JSONValue) async throws {
        let text = try RealtimeClient.text(of: frame)
        do {
            try await task.send(.string(text))
        } catch {
            throw closed(error)
        }
    }
    private func closed(_ error: Error) -> Error {
        if error is CancellationError || error is VaifError { return error }
        if let refused = redirects.refused {
            return VaifError(kind: .request,
                             message: "refused a redirect of the realtime connection to \(Transport.origin(of: refused))",
                             code: "INSECURE_REDIRECT")
        }
        let reason = task.closeReason.map { String(decoding: $0, as: UTF8.self) }
        return RealtimeClient.closeError(code: task.closeCode.rawValue, reason: reason, underlying: error)
    }
    func receive() async throws -> JSONValue {
        let message: URLSessionWebSocketTask.Message
        do {
            message = try await task.receive()
        } catch {
            throw closed(error)
        }
        return try RealtimeClient.frame(from: message)
    }
    func close() async { task.cancel(with: .normalClosure, reason: nil) }
}

/// One database change. A DELETE has no `record`; the removed row is
/// `oldRecord`.
public struct RealtimeEvent: Sendable {
    /// INSERT, UPDATE or DELETE.
    public let operation: String
    public let schema: String?
    public let table: String?
    /// The row after an INSERT or UPDATE.
    public let record: Row?
    /// The row before an UPDATE (when the table sends it), or the removed row of a DELETE.
    public let oldRecord: Row?
    /// The server's commit timestamp (ISO 8601), when sent.
    public let timestamp: String?
    /// The frame as received.
    public let raw: JSONValue

    init(frame: JSONValue, operation: String) {
        let record = frame["record"]?.objectValue
        let old = frame["old_record"]?.objectValue
        let isDelete = operation == "DELETE"
        self.operation = operation
        self.schema = frame["schema"]?.stringValue
        self.table = frame["table"]?.stringValue
        self.record = isDelete ? nil : record
        self.oldRecord = isDelete ? (old ?? record) : old
        self.timestamp = frame["ts"]?.stringValue
        self.raw = frame
    }
}

/// A server-side row filter for `subscribe`, in the channel format the
/// realtime server reads (`field.op=value`).
public struct RealtimeFilter: Sendable, Equatable {
    public let field: String
    public let op: String
    public let values: [String]

    private init(_ field: String, _ op: String, _ values: [String]) {
        self.field = field; self.op = op; self.values = values
    }

    public static func eq(_ field: String, _ value: some JSONRepresentable) -> RealtimeFilter { .init(field, "eq", [text(value)]) }
    public static func neq(_ field: String, _ value: some JSONRepresentable) -> RealtimeFilter { .init(field, "neq", [text(value)]) }
    public static func gt(_ field: String, _ value: some JSONRepresentable) -> RealtimeFilter { .init(field, "gt", [text(value)]) }
    public static func gte(_ field: String, _ value: some JSONRepresentable) -> RealtimeFilter { .init(field, "gte", [text(value)]) }
    public static func lt(_ field: String, _ value: some JSONRepresentable) -> RealtimeFilter { .init(field, "lt", [text(value)]) }
    public static func lte(_ field: String, _ value: some JSONRepresentable) -> RealtimeFilter { .init(field, "lte", [text(value)]) }
    public static func like(_ field: String, _ pattern: String) -> RealtimeFilter { .init(field, "like", [pattern]) }
    public static func ilike(_ field: String, _ pattern: String) -> RealtimeFilter { .init(field, "ilike", [pattern]) }
    public static func `in`(_ field: String, _ values: [some JSONRepresentable]) -> RealtimeFilter { .init(field, "in", values.map(text)) }

    private static func text(_ value: some JSONRepresentable) -> String {
        switch value.jsonValue {
        case .string(let text): return text
        case .bool(let flag): return flag ? "true" : "false"
        case .integer(let number): return String(number)
        case .number(let number): return String(number)
        case .null: return "null"
        case let other:
            let data = (try? JSONEncoder().encode(other)) ?? Data()
            return String(decoding: data, as: UTF8.self)
        }
    }

    func validate() throws {
        guard Query.isIdentifier(field) else { throw VaifError.invalidArgument("filter field must be a SQL identifier, got \"\(field)\"") }
        guard !values.isEmpty else { throw VaifError.invalidArgument("in(\"\(field)\") needs at least one value") }
        if op == "in", values.contains(where: { $0.contains(",") }) {
            throw VaifError.invalidArgument("in(\"\(field)\") values cannot contain commas (the channel separates them with commas)")
        }
    }

    var channelPart: String {
        "\(field).\(op)=\(Transport.escape(values.joined(separator: ",")))"
    }
}

/// One socket per subscription. Always unsubscribe when finished. On a
/// disconnect the stream throws; explicitly subscribe again to reconnect.
public struct RealtimeSubscription: Sendable {
    public let events: AsyncThrowingStream<RealtimeEvent, Error>
    private let socket: any RealtimeSocket
    private let receiver: Task<Void, Never>
    private let heartbeat: Task<Void, Never>
    private let finish: @Sendable () -> Void

    init(events: AsyncThrowingStream<RealtimeEvent, Error>, socket: any RealtimeSocket,
         receiver: Task<Void, Never>, heartbeat: Task<Void, Never>, finish: @escaping @Sendable () -> Void) {
        self.events = events; self.socket = socket; self.receiver = receiver; self.heartbeat = heartbeat; self.finish = finish
    }

    public func unsubscribe() async {
        receiver.cancel(); heartbeat.cancel(); finish()
        await socket.close()
    }
}

/// Database change subscriptions over Foundation's WebSocket transport.
/// Credentials are sent in the first auth frame, never in the URL.
public struct RealtimeClient: Sendable {
    let transport: Transport
    let auth: AuthClient
    let connect: @Sendable (URL) throws -> any RealtimeSocket

    init(transport: Transport, auth: AuthClient, connect: (@Sendable (URL) throws -> any RealtimeSocket)? = nil) {
        self.transport = transport; self.auth = auth
        self.connect = connect ?? { FoundationSocket(url: $0, session: transport.session) }
    }

    /// The next frame, or a `.timeout` error after `timeout` seconds. The
    /// socket is closed only after the timeout has been taken as the result:
    /// closing it fails the pending receive, and that error must not be
    /// reported in place of the timeout.
    private static func receive(_ socket: any RealtimeSocket, timeout: TimeInterval) async throws -> JSONValue {
        try await withTaskCancellationHandler {
            try await withThrowingTaskGroup(of: JSONValue.self) { group in
                group.addTask { try await socket.receive() }
                group.addTask {
                    try await Task.sleep(nanoseconds: Transport.nanos(timeout))
                    throw VaifError(kind: .timeout, message: "realtime receive timed out")
                }
                defer { group.cancelAll() }
                do {
                    return try await group.next()!
                } catch let error as VaifError where error.kind == .timeout {
                    // Unblocks the receive child, which the group waits for.
                    await socket.close()
                    throw error
                }
            }
        } onCancel: { Task { await socket.close() } }
    }

    /// A frame as the text message sent to the server.
    static func text(of frame: JSONValue) throws -> String {
        do {
            return String(decoding: try JSONEncoder().encode(frame), as: UTF8.self)
        } catch {
            throw VaifError.invalidArgument("could not encode a realtime frame: \(VaifError.describe(error))")
        }
    }

    /// A received WebSocket message as a JSON frame.
    static func frame(from message: URLSessionWebSocketTask.Message) throws -> JSONValue {
        let bytes: Data
        switch message {
        case .string(let text): bytes = Data(text.utf8)
        case .data(let data): bytes = data
        @unknown default:
            throw VaifError(kind: .badResponse, message: "the realtime server sent an unknown kind of message", code: "REALTIME_BAD_FRAME")
        }
        do {
            return try JSONDecoder().decode(JSONValue.self, from: bytes)
        } catch {
            throw VaifError(kind: .badResponse, message: "the realtime server sent a frame that is not JSON", code: "REALTIME_BAD_FRAME")
        }
    }

    /// An `error` frame as a typed error: a bad channel is `.validation`
    /// (`INVALID_CHANNEL`), a rate limit `.rateLimited`, a refused or expired
    /// credential (the frames that precede a close) `.auth`.
    static func checkError(_ frame: JSONValue) throws {
        guard frame["type"] == "error" else { return }
        let name = frame["error"]?.stringValue
        let message = frame["message"]?.stringValue ?? "Realtime refused the request"
        switch name {
        case "InvalidChannel":
            throw VaifError(kind: .validation, message: message, code: "INVALID_CHANNEL")
        case "RateLimited":
            throw VaifError(kind: .rateLimited, message: message, code: frame["code"]?.stringValue ?? "RATE_LIMITED")
        default:
            let code = frame["code"]?.stringValue ?? name ?? "REALTIME_ERROR"
            let isAuth = frame["closeCode"] != nil || name == "AuthRefreshFailed"
            throw VaifError(kind: isAuth ? .auth : .request, message: message, code: code)
        }
    }

    /// A closed socket as a typed error, by the API's realtime close codes.
    static func closeError(code: Int, reason: String?, underlying: Error) -> VaifError {
        let detail = (reason?.isEmpty == false ? reason! : underlying.localizedDescription)
        let message = "the realtime socket closed (\(code)): \(detail)"
        switch code {
        case 4000: return VaifError(kind: .validation, message: message, code: "REALTIME_BAD_REQUEST")
        case 4001: return VaifError(kind: .auth, message: message, code: "REALTIME_UNAUTHORIZED")
        case 4002: return VaifError(kind: .auth, message: message, code: "TOKEN_EXPIRED")
        case 4003: return VaifError(kind: .auth, message: message, code: "REALTIME_FORBIDDEN")
        case 4004: return VaifError(kind: .notFound, message: message, code: "REALTIME_NOT_FOUND")
        case 4029: return VaifError(kind: .rateLimited, message: message, code: "REALTIME_RATE_LIMITED")
        default: return VaifError(kind: .network, message: message, code: "REALTIME_CLOSED")
        }
    }

    /// The socket URL for `baseURL` (scheme in any case): https becomes wss,
    /// http becomes ws only for the hosts `Transport` allows over http, and
    /// anything else throws `INVALID_REALTIME_URL` before any credential is
    /// read, so the auth frame never travels unencrypted.
    static func socketURL(for baseURL: URL) throws -> URL {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            throw VaifError.invalidArgument("invalid realtime URL")
        }
        switch components.scheme?.lowercased() {
        case "https":
            components.scheme = "wss"
        case "http" where Transport.allowsCleartext(baseURL):
            components.scheme = "ws"
        default:
            throw VaifError(kind: .invalidArgument,
                            message: "realtime needs an https baseURL (http only for localhost, 127.0.0.1 or ::1)",
                            code: "INVALID_REALTIME_URL")
        }
        components.path += "/realtime/ws"
        components.query = nil; components.fragment = nil
        guard let url = components.url else { throw VaifError.invalidArgument("invalid realtime URL") }
        return url
    }

    /// The server channel for a table subscription:
    /// `table:<table>[?<field>.<op>=<value>&…&columns=a,b]`.
    static func channel(table: String, filters: [RealtimeFilter], columns: [String]) -> String {
        var parts = filters.map(\.channelPart)
        if !columns.isEmpty { parts.append("columns=" + columns.joined(separator: ",")) }
        return parts.isEmpty ? "table:\(table)" : "table:\(table)?" + parts.joined(separator: "&")
    }

    /// Subscribe to INSERT, UPDATE and DELETE on `table`; returns once the
    /// server acknowledges. The server applies `filters` (ANDed) and sends only
    /// `columns` when given. Row-level security decides which rows you see.
    ///
    /// ```swift
    /// let sub = try await vaif.realtime.subscribe(table: "todos", filters: [.eq("owner_id", userId)])
    /// ```
    public func subscribe(table: String, filters: [RealtimeFilter] = [], columns: [String] = [], timeout: TimeInterval = 10) async throws -> RealtimeSubscription {
        guard Query.isIdentifier(table), columns.allSatisfy(Query.isIdentifier), timeout.isFinite, timeout > 0 else {
            throw VaifError.invalidArgument("subscribe requires valid table/columns and a positive finite timeout")
        }
        for filter in filters { try filter.validate() }
        let channel = Self.channel(table: table, filters: filters, columns: columns)
        let url = try Self.socketURL(for: transport.baseURL)
        let token = try await auth.bearer()
        let socket = try connect(url)
        do {
            var frame: Row = ["type": "auth", "apiKey": .string(transport.apiKey)]
            if let token { frame["accessToken"] = .string(token) }
            try await socket.send(.object(frame))
            let deadline = Date().addingTimeInterval(timeout)
            var welcome = false
            while true {
                let remaining = deadline.timeIntervalSinceNow
                guard remaining > 0 else { throw VaifError(kind: .timeout, message: "realtime handshake timed out") }
                let next = try await Self.receive(socket, timeout: remaining)
                try Self.checkError(next)
                if next["type"] == "welcome", !welcome {
                    welcome = true
                    try await socket.send(["type": "subscribe", "channel": .string(channel)])
                }
                if welcome, next["type"] == "subscribed", next["channel"] == .string(channel) { break }
            }
        } catch {
            await socket.close()
            throw error
        }
        let (events, continuation) = AsyncThrowingStream<RealtimeEvent, Error>.makeStream(bufferingPolicy: .bufferingOldest(256))
        let receiver = Task {
            do {
                while !Task.isCancelled {
                    let frame = try await Self.receive(socket, timeout: 60)
                    try Self.checkError(frame)
                    guard frame["type"] == "db_change", let operation = frame["op"]?.stringValue else { continue }
                    // One socket per subscription, but a tagged frame names its channels.
                    if let tagged = frame["channels"]?.arrayValue, !tagged.contains(.string(channel)) { continue }
                    let event = RealtimeEvent(frame: frame, operation: operation)
                    if case .dropped = continuation.yield(event) {
                        throw VaifError(kind: .network, message: "realtime consumer exceeded the 256-event buffer", code: "REALTIME_OVERFLOW")
                    }
                }
                continuation.finish()
            } catch is CancellationError { continuation.finish() }
            catch { continuation.finish(throwing: error) }
            await socket.close()
        }
        let heartbeat = Task {
            var previous = token
            do {
                while !Task.isCancelled {
                    try await Task.sleep(nanoseconds: 20_000_000_000)
                    let current = try await auth.bearer()
                    if current != previous {
                        guard let current else { throw VaifError(kind: .auth, message: "realtime session signed out", code: "NOT_SIGNED_IN") }
                        try await socket.send(["type": "auth", "accessToken": .string(current)])
                        previous = current
                    }
                    try await socket.send(["type": "ping"])
                }
            } catch is CancellationError { }
            catch { continuation.finish(throwing: error); await socket.close() }
        }
        continuation.onTermination = { _ in
            receiver.cancel(); heartbeat.cancel()
            Task { await socket.close() }
        }
        return RealtimeSubscription(events: events, socket: socket, receiver: receiver, heartbeat: heartbeat, finish: { continuation.finish() })
    }
}
