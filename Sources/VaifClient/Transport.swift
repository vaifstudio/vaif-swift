import Foundation

struct HTTPRequest: Sendable {
    var method: String
    /// API path (e.g. `/v1/data/...`), or a full URL when `absolute` is true.
    var path: String
    var query: [URLQueryItem] = []
    var body: Data?
    var contentType: String?
    var headers: [String: String] = [:]
    var bearer: String?
    /// Overrides the method-based replay decision.
    var idempotent: Bool?
    var timeout: TimeInterval?
    /// A presigned object-store URL: no API credentials are attached.
    var absolute = false

    static func json(_ method: String, _ path: String, _ value: some Encodable) throws -> HTTPRequest {
        let data: Data
        do {
            data = try JSONEncoder().encode(value)
        } catch {
            throw VaifError.invalidArgument("could not encode the request body: \(VaifError.describe(error))")
        }
        return HTTPRequest(method: method, path: path, body: data, contentType: "application/json")
    }
}

struct HTTPResponse: Sendable {
    let status: Int
    let headers: [String: String]
    let data: Data
    let url: URL

    func header(_ name: String) -> String? {
        let lower = name.lowercased()
        return headers.first { $0.key.lowercased() == lower }?.value
    }

    func decode<T: Decodable>(_ type: T.Type) throws -> T {
        guard !data.isEmpty else {
            throw VaifError(kind: .badResponse, message: "empty response body", status: status)
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw VaifError(kind: .badResponse, message: "the response did not match the expected shape", status: status)
        }
    }
}

private struct AttemptTimedOut: Error {}

final class Transport: Sendable {
    static let apiKeyHeader = "x-vaif-key"

    let baseURL: URL
    let apiKey: String
    let session: URLSession
    let timeout: TimeInterval
    let retry: RetryPolicy
    let headers: [String: String]

    init(baseURL: URL, apiKey: String, session: URLSession, timeout: TimeInterval, retry: RetryPolicy, headers: [String: String]) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.session = session
        self.timeout = timeout
        self.retry = retry
        self.headers = headers
    }

    /// The only hosts the SDK reaches without TLS (http, and ws for realtime).
    static let cleartextHosts: Set<String> = ["localhost", "127.0.0.1", "::1"]

    /// True when `url`'s host may be reached without TLS.
    static func allowsCleartext(_ url: URL) -> Bool {
        url.host.map(cleartextHosts.contains) ?? false
    }

    /// True for https, and for http to the hosts in `cleartextHosts`.
    static func isSecure(_ url: URL) -> Bool {
        switch url.scheme?.lowercased() {
        case "https": return true
        case "http": return allowsCleartext(url)
        default: return false
        }
    }

    /// `scheme://host[:port]`, lowercase, without the scheme's default port.
    static func origin(of url: URL) -> String {
        let scheme = (url.scheme ?? "").lowercased()
        var host = (url.host ?? "").lowercased()
        if host.contains(":"), !host.hasPrefix("[") { host = "[\(host)]" } // an IPv6 literal
        var origin = "\(scheme)://\(host)"
        if let port = url.port, !(scheme == "https" && port == 443), !(scheme == "http" && port == 80) {
            origin += ":\(port)"
        }
        return origin
    }

    static func normalize(baseURL: URL) throws -> URL {
        guard let scheme = baseURL.scheme?.lowercased(), let host = baseURL.host, !host.isEmpty,
              scheme == "http" || scheme == "https"
        else { throw VaifError.invalidArgument("baseURL must be an absolute http(s) URL") }
        if scheme == "http", !allowsCleartext(baseURL) {
            throw VaifError.invalidArgument("baseURL must use https (http is accepted only for localhost, 127.0.0.1 and ::1)")
        }
        var text = baseURL.absoluteString
        while text.hasSuffix("/") { text.removeLast() }
        guard let url = URL(string: text) else { throw VaifError.invalidArgument("invalid baseURL") }
        return url
    }

    /// RFC 3986 unreserved characters; everything else in a query component is escaped.
    private static let unreserved = CharacterSet(
        charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
    )

    static func escape(_ text: String) -> String {
        text.addingPercentEncoding(withAllowedCharacters: unreserved) ?? text
    }

    private func url(for request: HTTPRequest) throws -> URL {
        var raw = request.absolute ? request.path : baseURL.absoluteString + request.path
        if !request.query.isEmpty {
            let query = request.query
                .map { "\(Transport.escape($0.name))=\(Transport.escape($0.value ?? ""))" }
                .joined(separator: "&")
            raw += (raw.contains("?") ? "&" : "?") + query
        }
        guard let url = URL(string: raw), url.host != nil else {
            throw VaifError.invalidArgument("invalid request URL")
        }
        return url
    }

    private func urlRequest(for request: HTTPRequest, url: URL, timeout: TimeInterval) -> URLRequest {
        var r = URLRequest(url: url)
        r.httpMethod = request.method
        r.httpBody = request.body
        r.timeoutInterval = timeout
        // The SDK reads and sends the refresh cookie itself; never let a shared
        // cookie jar attach or store cookies.
        r.httpShouldHandleCookies = false
        if request.absolute {
            if let contentType = request.contentType { r.setValue(contentType, forHTTPHeaderField: "Content-Type") }
            return r
        }
        for (key, value) in headers { r.setValue(value, forHTTPHeaderField: key) }
        r.setValue("application/json", forHTTPHeaderField: "Accept")
        r.setValue("v1", forHTTPHeaderField: "Accept-Versions")
        r.setValue("vaif-swift/\(VaifClient.version)", forHTTPHeaderField: "User-Agent")
        for (key, value) in request.headers { r.setValue(value, forHTTPHeaderField: key) }
        if let contentType = request.contentType { r.setValue(contentType, forHTTPHeaderField: "Content-Type") }
        r.setValue(apiKey, forHTTPHeaderField: Transport.apiKeyHeader)
        if let bearer = request.bearer { r.setValue("Bearer \(bearer)", forHTTPHeaderField: "Authorization") }
        return r
    }

    /// Send with a hard per-attempt timeout and bounded retries; returns a 2xx response.
    func send(_ request: HTTPRequest) async throws -> HTTPResponse {
        let url = try url(for: request)
        let attemptTimeout = request.timeout ?? timeout
        let urlRequest = urlRequest(for: request, url: url, timeout: attemptTimeout)
        let replaySafe = request.idempotent ?? ["GET", "HEAD", "OPTIONS"].contains(request.method)
        var attempt = 0
        while true {
            try Task.checkCancellation()
            let canRetry = attempt < retry.maxRetries
            let outcome: (Data, HTTPURLResponse)
            do {
                outcome = try await perform(urlRequest, timeout: attemptTimeout)
            } catch is CancellationError {
                throw CancellationError()
            } catch {
                if Task.isCancelled { throw CancellationError() }
                let neverSent = Transport.isConnectFailure(error)
                if canRetry, retry.retryOnNetworkError, replaySafe || neverSent {
                    try await Task.sleep(nanoseconds: Transport.nanos(retry.delay(forAttempt: attempt)))
                    attempt += 1
                    continue
                }
                throw Transport.networkError(error, timeout: attemptTimeout)
            }
            let (data, http) = outcome
            var headerFields: [String: String] = [:]
            for (key, value) in http.allHeaderFields {
                if let key = key as? String { headerFields[key] = "\(value)" }
            }
            if (200..<300).contains(http.statusCode) {
                return HTTPResponse(status: http.statusCode, headers: headerFields, data: data, url: url)
            }
            let error = VaifError.from(status: http.statusCode, headers: headerFields, data: data)
            if canRetry, replaySafe, retry.retryOn.contains(http.statusCode) {
                try await Task.sleep(nanoseconds: Transport.nanos(retry.delay(forAttempt: attempt, retryAfter: error.retryAfter)))
                attempt += 1
                continue
            }
            throw error
        }
    }

    private func perform(_ request: URLRequest, timeout: TimeInterval) async throws -> (Data, HTTPURLResponse) {
        let session = self.session
        return try await withThrowingTaskGroup(of: (Data, HTTPURLResponse)?.self) { group in
            group.addTask {
                let redirects = RedirectGuard()
                let (data, response) = try await session.data(for: request, delegate: redirects)
                guard let http = response as? HTTPURLResponse else {
                    throw VaifError(kind: .badResponse, message: "not an HTTP response")
                }
                if let refused = redirects.refused {
                    throw VaifError(
                        kind: .request,
                        message: "refused a redirect to \(Transport.origin(of: refused)): another origin is followed only for a GET or HEAD request to https (http only for localhost, 127.0.0.1 and ::1)",
                        status: http.statusCode,
                        code: "INSECURE_REDIRECT"
                    )
                }
                return (data, http)
            }
            group.addTask {
                try await Task.sleep(nanoseconds: Transport.nanos(timeout))
                return nil
            }
            defer { group.cancelAll() }
            guard let first = try await group.next(), let result = first else {
                throw AttemptTimedOut()
            }
            return result
        }
    }

    /// `seconds` as nanoseconds for `Task.sleep`: at most 10^9 seconds, and
    /// 0 for a negative or NaN value, so the conversion never traps.
    static func nanos(_ seconds: TimeInterval) -> UInt64 {
        guard seconds > 0 else { return 0 }
        return UInt64(min(seconds, 1_000_000_000) * 1_000_000_000)
    }

    /// Failures that happen before a request can reach the server.
    static func isConnectFailure(_ error: Error) -> Bool {
        guard let urlError = error as? URLError else { return false }
        switch urlError.code {
        case .cannotConnectToHost, .cannotFindHost, .dnsLookupFailed, .notConnectedToInternet:
            return true
        default:
            return false
        }
    }

    static func networkError(_ error: Error, timeout: TimeInterval) -> VaifError {
        if let vaif = error as? VaifError { return vaif }
        if error is AttemptTimedOut || (error as? URLError)?.code == .timedOut {
            return VaifError(kind: .timeout, message: "request timed out after \(timeout)s")
        }
        return VaifError(kind: .network, message: "could not reach the VAIF API: \(error.localizedDescription)")
    }
}

/// Decides how a request follows a redirect. Within the request's origin the
/// redirect is followed as it is. To another origin it is followed only when
/// it sends no body (a GET or HEAD) and goes to https (http only to the
/// loopback hosts), and then with only the `Accept`, `Content-Type` and
/// `User-Agent` headers: the API key, the access token, cookies and the
/// client's own headers never leave the API's origin. Any other redirect is
/// refused, and `Transport` reports it as `INSECURE_REDIRECT`.
///
/// A realtime socket uses `RedirectGuard(allowsOtherOrigins: false)`: its
/// credentials travel in the first frame, after the handshake, so its
/// handshake never follows a redirect to another origin.
final class RedirectGuard: NSObject, URLSessionTaskDelegate, @unchecked Sendable {
    private static let portableHeaders: Set<String> = ["accept", "content-type", "user-agent"]
    private let allowsOtherOrigins: Bool
    private let lock = NSLock()
    private var refusedURL: URL?

    init(allowsOtherOrigins: Bool = true) {
        self.allowsOtherOrigins = allowsOtherOrigins
    }

    /// The target of the redirect that was refused, if any.
    var refused: URL? {
        lock.lock(); defer { lock.unlock() }
        return refusedURL
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse,
                    newRequest request: URLRequest, completionHandler: @escaping @Sendable (URLRequest?) -> Void) {
        let from = response.url ?? task.currentRequest?.url
        let next = from.flatMap { Self.follow(request, from: $0, allowsOtherOrigins: allowsOtherOrigins) }
        if next == nil {
            lock.lock(); refusedURL = request.url; lock.unlock()
        }
        completionHandler(next)
    }

    /// The request to send for a redirect from `source`, or nil to refuse it.
    static func follow(_ proposed: URLRequest, from source: URL, allowsOtherOrigins: Bool = true) -> URLRequest? {
        guard let target = proposed.url else { return nil }
        if Transport.origin(of: target) == Transport.origin(of: source) { return proposed }
        guard allowsOtherOrigins else { return nil }
        let method = proposed.httpMethod?.uppercased() ?? "GET"
        guard Transport.isSecure(target), method == "GET" || method == "HEAD",
              proposed.httpBody == nil, proposed.httpBodyStream == nil else { return nil }
        var stripped = proposed
        for name in (proposed.allHTTPHeaderFields ?? [:]).keys where !portableHeaders.contains(name.lowercased()) {
            stripped.setValue(nil, forHTTPHeaderField: name)
        }
        return stripped
    }
}
