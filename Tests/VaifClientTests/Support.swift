import Foundation
@testable import VaifClient

struct Recorded: Sendable {
    let method: String
    let url: URL
    let headers: [String: String]
    let body: Data

    func header(_ name: String) -> String? {
        headers.first { $0.key.lowercased() == name.lowercased() }?.value
    }

    var path: String { url.path }

    /// Percent-encoded path, e.g. to see `a%2Fb`.
    var rawPath: String { URLComponents(url: url, resolvingAgainstBaseURL: false)?.percentEncodedPath ?? url.path }

    func query(_ name: String) -> String? {
        URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.first { $0.name == name }?.value
    }

    var json: JSONValue? { try? JSONDecoder().decode(JSONValue.self, from: body) }
}

struct Reply: Sendable {
    var status = 200
    var headers: [String: String] = [:]
    var body = Data()
    var delay: TimeInterval = 0
    var error: URLError.Code?
    /// Answer with a redirect to this URL (status 307 unless set).
    var location: String?

    static func json(_ status: Int = 200, _ value: JSONValue, headers: [String: String] = [:]) -> Reply {
        var all = headers
        all["Content-Type"] = "application/json"
        return Reply(status: status, headers: all, body: try! JSONEncoder().encode(value))
    }

    static func status(_ status: Int) -> Reply { Reply(status: status) }
    static func fail(_ code: URLError.Code) -> Reply { Reply(error: code) }
    static func redirect(_ status: Int = 307, to location: String) -> Reply {
        Reply(status: status, headers: ["Location": location], location: location)
    }
}

/// A fake HTTP host. Each stub gets a unique hostname, so tests can run in
/// parallel against one shared URLProtocol.
final class Stub: @unchecked Sendable {
    let host = "t\(UUID().uuidString.prefix(12).lowercased()).test"
    private let lock = NSLock()
    private var recorded: [Recorded] = []
    private var responder: @Sendable (Recorded, Int) -> Reply

    var baseURL: URL { URL(string: "https://\(host)")! }

    init(_ responder: @escaping @Sendable (Recorded, Int) -> Reply) {
        self.responder = responder
        MockURLProtocol.register(self)
    }

    func respond(_ request: Recorded) -> Reply {
        lock.lock()
        recorded.append(request)
        let index = recorded.count - 1
        let responder = self.responder
        lock.unlock()
        return responder(request, index)
    }

    func setResponder(_ responder: @escaping @Sendable (Recorded, Int) -> Reply) {
        lock.lock()
        self.responder = responder
        lock.unlock()
    }

    var requests: [Recorded] {
        lock.lock()
        defer { lock.unlock() }
        return recorded
    }

    var last: Recorded { requests.last! }
    var count: Int { requests.count }
}

final class MockURLProtocol: URLProtocol, @unchecked Sendable {
    private static let lock = NSLock()
    nonisolated(unsafe) private static var stubs: [String: Stub] = [:]
    private var cancelled = false

    static func register(_ stub: Stub) {
        lock.lock()
        stubs[stub.host] = stub
        lock.unlock()
    }

    static func stub(for host: String) -> Stub? {
        lock.lock()
        defer { lock.unlock() }
        return stubs[host]
    }

    static let session: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }()

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        guard let url = request.url, let stub = MockURLProtocol.stub(for: url.host ?? "") else {
            client?.urlProtocol(self, didFailWithError: URLError(.cannotFindHost))
            return
        }
        let recorded = Recorded(
            method: request.httpMethod ?? "GET",
            url: url,
            headers: request.allHTTPHeaderFields ?? [:],
            body: request.httpBody ?? Self.readStream(request.httpBodyStream)
        )
        let reply = stub.respond(recorded)
        let deliver: @Sendable () -> Void = { [weak self] in
            guard let self, !self.cancelled else { return }
            if let code = reply.error {
                self.client?.urlProtocol(self, didFailWithError: URLError(code))
                return
            }
            let response = HTTPURLResponse(url: url, statusCode: reply.status, httpVersion: "HTTP/1.1", headerFields: reply.headers)!
            if let location = reply.location, let target = URL(string: location, relativeTo: url)?.absoluteURL {
                // As the HTTP loader does: the same request, every header
                // included, at the new URL (a 303 becomes a GET without body).
                var next = self.request
                next.url = target
                if reply.status == 303 { next.httpMethod = "GET"; next.httpBody = nil }
                self.client?.urlProtocol(self, wasRedirectedTo: next, redirectResponse: response)
                // Reached when the redirect is not followed: the 3xx is the answer.
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                self.client?.urlProtocolDidFinishLoading(self)
                return
            }
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            self.client?.urlProtocol(self, didLoad: reply.body)
            self.client?.urlProtocolDidFinishLoading(self)
        }
        if reply.delay > 0 {
            DispatchQueue.global().asyncAfter(deadline: .now() + reply.delay, execute: deliver)
        } else {
            deliver()
        }
    }

    override func stopLoading() { cancelled = true }

    private static func readStream(_ stream: InputStream?) -> Data {
        guard let stream else { return Data() }
        stream.open()
        defer { stream.close() }
        var data = Data()
        var buffer = [UInt8](repeating: 0, count: 4096)
        while stream.hasBytesAvailable {
            let n = stream.read(&buffer, maxLength: buffer.count)
            if n <= 0 { break }
            data.append(buffer, count: n)
        }
        return data
    }
}

let fastRetry = RetryPolicy(maxRetries: 3, baseDelay: 0, maxDelay: 0)
let testProject = "proj_123"
let testKey = "vk_pub_test"

func makeClient(_ stub: Stub, retry: RetryPolicy = fastRetry, timeout: TimeInterval = 5,
                headers: [String: String] = [:]) throws -> VaifClient {
    try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, timeout: timeout,
                   retry: retry, headers: headers, sessionStore: MemorySessionStore(), urlSession: MockURLProtocol.session)
}

/// The VaifError thrown by `body`, or nil.
func vaifError(_ body: () async throws -> Void) async -> VaifError? {
    do {
        try await body()
        return nil
    } catch let error as VaifError {
        return error
    } catch {
        return nil
    }
}

func loginReply(_ token: String, _ refresh: String, expiresIn: Int = 900) -> Reply {
    .json(200, ["ok": true, "accessToken": .string(token), "expiresIn": .integer(expiresIn),
                "user": ["id": "u1", "email": "ada@example.com"]],
          headers: ["Set-Cookie": "project_refresh_token=\(refresh); Max-Age=2592000; Path=/projects/proj_123/auth; HttpOnly; SameSite=Lax"])
}

let emptyList: Reply = .json(200, ["data": [], "count": 0])
