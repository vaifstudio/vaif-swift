import Foundation

/// Every failure thrown by the SDK (except `CancellationError`) is a
/// `VaifError`, including a response or value that does not decode as the
/// requested type (`.badResponse`).
///
/// ```swift
/// do { _ = try await vaif.from("todos").get("id") }
/// catch let error as VaifError where error.kind == .notFound { ... }
/// ```
public struct VaifError: Error, Sendable, CustomStringConvertible, LocalizedError {
    public enum Kind: String, Sendable {
        case validation       // 400, 422
        case auth             // 401, 403
        case notFound         // 404
        case conflict         // 409
        case rateLimited      // 429
        case server           // 5xx
        case request          // any other non-2xx
        case network          // no usable response
        case timeout          // the request timed out
        case invalidArgument  // rejected before sending
        case badResponse      // 2xx we could not decode
        case storage          // the local session store (e.g. the Keychain) failed
    }

    public let kind: Kind
    /// HTTP status, or nil when no response was received.
    public let status: Int?
    /// The server's machine-readable code, e.g. `INVALID_CREDENTIALS`.
    public var code: String?
    public let message: String
    public let details: JSONValue?
    public let requestId: String?
    /// Server `Retry-After` hint on 429, in seconds.
    public let retryAfter: TimeInterval?
    /// The decoded response body (JSON, or `.string` for non-JSON bodies).
    public let body: JSONValue?
    /// The response headers; empty when no response was received. Read one
    /// with `header(_:)`, which ignores case.
    public let headers: [String: String]

    public init(
        kind: Kind,
        message: String,
        status: Int? = nil,
        code: String? = nil,
        details: JSONValue? = nil,
        requestId: String? = nil,
        retryAfter: TimeInterval? = nil,
        body: JSONValue? = nil,
        headers: [String: String] = [:]
    ) {
        self.kind = kind
        self.message = message
        self.status = status
        self.code = code
        self.details = details
        self.requestId = requestId
        self.retryAfter = retryAfter
        self.body = body
        self.headers = headers
    }

    /// The response header `name`, matched without regard to case.
    public func header(_ name: String) -> String? {
        let lower = name.lowercased()
        return headers.first { $0.key.lowercased() == lower }?.value
    }

    public var description: String {
        var text = "VaifError.\(kind.rawValue): \(message)"
        if let status { text += " (status \(status)\(code.map { ", code \($0)" } ?? ""))" }
        return text
    }

    public var errorDescription: String? { description }

    static func invalidArgument(_ message: String) -> VaifError {
        VaifError(kind: .invalidArgument, message: message)
    }

    /// The console page where a VAIF Studio account is created. The
    /// `CONSOLE_ONLY` error from `signUp` on a client without `projectId`
    /// gives this address.
    public static let consoleSignUpURL = "https://console.vaif.studio/register"

    /// The console page where a VAIF Studio account's password is reset. The
    /// `CONSOLE_ONLY` error from `requestPasswordReset` on a client without
    /// `projectId` gives this address.
    public static let consolePasswordResetURL = "https://console.vaif.studio/forgot-password"

    /// True for the error a platform client's `signUp` / `requestPasswordReset`
    /// (and the generated `postAuthSignup` / `postAuthForgotPassword`) throw
    /// before any request: VAIF Studio accounts are created and reset in the
    /// console only.
    public var isConsoleOnly: Bool { code == "CONSOLE_ONLY" }

    /// The `CONSOLE_ONLY` error. `ownApp` says what to do instead for the
    /// users of your own app.
    static func consoleOnly(signup: Bool, ownApp: String = "create the client with your projectId") -> VaifError {
        let message = signup
            ? "Create your VAIF Studio account in the console at \(consoleSignUpURL). To sign up users of your own app, \(ownApp)."
            : "Reset your VAIF Studio password in the console at \(consolePasswordResetURL). To reset passwords for users of your own app, \(ownApp)."
        return VaifError(kind: .invalidArgument, message: message, code: "CONSOLE_ONLY")
    }

    static func projectIdRequired(_ what: String) -> VaifError {
        VaifError(kind: .invalidArgument, message: "\(what) requires projectId on the client.", code: "PROJECT_ID_REQUIRED")
    }

    /// A value that did not decode as `type`, as a `.badResponse` error.
    static func decoding(_ error: Error, as type: Any.Type, status: Int? = nil) -> VaifError {
        if let vaif = error as? VaifError { return vaif }
        return VaifError(kind: .badResponse, message: "the value does not decode as \(type): \(describe(error))", status: status)
    }

    /// A short description of a coding error: what was expected, and where.
    static func describe(_ error: Error) -> String {
        func path(_ keys: [any CodingKey]) -> String {
            keys.map { $0.intValue.map(String.init) ?? $0.stringValue }.joined(separator: ".")
        }
        func at(_ keys: [any CodingKey]) -> String { keys.isEmpty ? "" : " at \(path(keys))" }
        switch error {
        case DecodingError.typeMismatch(let type, let context):
            return "expected \(type)\(at(context.codingPath))"
        case DecodingError.valueNotFound(let type, let context):
            return "missing \(type) value\(at(context.codingPath))"
        case DecodingError.keyNotFound(let key, let context):
            return "missing key \(path(context.codingPath + [key]))"
        case DecodingError.dataCorrupted(let context):
            return context.debugDescription + at(context.codingPath)
        case EncodingError.invalidValue(_, let context):
            return context.debugDescription + at(context.codingPath)
        default:
            return error.localizedDescription
        }
    }

    /// A session store failure, always of kind `.storage`.
    static func storage(_ error: Error) -> VaifError {
        if let vaif = error as? VaifError, vaif.kind == .storage { return vaif }
        return VaifError(kind: .storage, message: "the session store failed: \(error.localizedDescription)", code: "SESSION_STORE_FAILED")
    }

    static func kind(forStatus status: Int) -> Kind {
        switch status {
        case 400, 422: return .validation
        case 401, 403: return .auth
        case 404: return .notFound
        case 409: return .conflict
        case 429: return .rateLimited
        case 500...: return .server
        default: return .request
        }
    }

    static func from(status: Int, headers: [String: String], data: Data) -> VaifError {
        var body: JSONValue?
        if !data.isEmpty {
            if let json = try? JSONDecoder().decode(JSONValue.self, from: data) {
                body = json
            } else {
                body = .string(String(decoding: data.prefix(500), as: UTF8.self))
            }
        }
        var message: String?
        var code: String?
        var details: JSONValue?
        var requestId: String?
        if case let .object(object)? = body {
            let errorField = object["error"]?.stringValue
            message = object["message"]?.stringValue ?? errorField
            code = object["code"]?.stringValue ?? errorField
            details = object["details"]
            requestId = object["requestId"]?.stringValue
        } else if case let .string(text)? = body, !text.isEmpty {
            message = text
        }
        if message?.isEmpty ?? true {
            message = HTTPURLResponse.localizedString(forStatusCode: status)
        }
        let lower = Dictionary(headers.map { ($0.key.lowercased(), $0.value) }, uniquingKeysWith: { a, _ in a })
        return VaifError(
            kind: kind(forStatus: status),
            message: message ?? "HTTP \(status)",
            status: status,
            code: code,
            details: details,
            requestId: requestId ?? lower["x-request-id"],
            retryAfter: status == 429 ? parseRetryAfter(lower["retry-after"]) : nil,
            body: body,
            headers: headers
        )
    }

    static func parseRetryAfter(_ value: String?) -> TimeInterval? {
        guard let value = value?.trimmingCharacters(in: .whitespaces), !value.isEmpty else { return nil }
        if let seconds = TimeInterval(value), seconds > 0 { return seconds }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "GMT")
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        if let date = formatter.date(from: value) {
            let delta = date.timeIntervalSinceNow
            return delta > 0 ? delta : nil
        }
        return nil
    }
}
