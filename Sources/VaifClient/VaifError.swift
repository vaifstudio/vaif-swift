/// VAIF Error Types
///
/// Unified error enum conforming to LocalizedError for all VAIF SDK operations.

import Foundation

/// Unified error type for all VAIF SDK operations.
public enum VaifError: LocalizedError, Sendable {
    /// Network-level errors (DNS, connection refused, SSL).
    case network(underlying: Error)

    /// Request timeout.
    case timeout(duration: TimeInterval)

    /// Authentication errors (401, 403, token expired).
    case auth(message: String, status: Int?)

    /// Database query errors (constraint violations, invalid queries).
    case database(message: String, code: String?)

    /// Storage errors (upload failures, quota exceeded).
    case storage(message: String, statusCode: String)

    /// Edge function invocation errors.
    case function(message: String, name: String?, status: Int?)

    /// AI generation errors (quota exceeded, model unavailable).
    case ai(message: String, code: String?, creditsRemaining: Int?)

    /// Realtime/WebSocket errors.
    case realtime(message: String, channel: String?)

    /// Server returned an error response.
    case server(message: String, code: String?, status: Int, requestId: String?)

    /// Invalid URL or request configuration.
    case invalidRequest(message: String)

    /// Response could not be decoded.
    case decoding(message: String, underlying: Error?)

    /// Rate limited (429).
    case rateLimited(retryAfter: TimeInterval?)

    public var errorDescription: String? {
        switch self {
        case .network(let error):
            return "Network error: \(error.localizedDescription)"
        case .timeout(let duration):
            return "Request timed out after \(Int(duration))s"
        case .auth(let message, _):
            return "Authentication error: \(message)"
        case .database(let message, let code):
            return "Database error\(code.map { " [\($0)]" } ?? ""): \(message)"
        case .storage(let message, _):
            return "Storage error: \(message)"
        case .function(let message, let name, _):
            return "Function error\(name.map { " (\($0))" } ?? ""): \(message)"
        case .ai(let message, _, _):
            return "AI error: \(message)"
        case .realtime(let message, let channel):
            return "Realtime error\(channel.map { " [\($0)]" } ?? ""): \(message)"
        case .server(let message, _, let status, _):
            return "Server error (\(status)): \(message)"
        case .invalidRequest(let message):
            return "Invalid request: \(message)"
        case .decoding(let message, _):
            return "Decoding error: \(message)"
        case .rateLimited(let retryAfter):
            return "Rate limited\(retryAfter.map { ", retry after \(Int($0))s" } ?? "")"
        }
    }

    /// Whether this error is likely transient and retryable.
    public var isRetryable: Bool {
        switch self {
        case .network: return true
        case .timeout: return true
        case .rateLimited: return true
        case .server(_, _, let status, _):
            return [408, 429, 500, 502, 503, 504].contains(status)
        default: return false
        }
    }

    /// HTTP status code, if applicable.
    public var statusCode: Int? {
        switch self {
        case .auth(_, let status): return status
        case .function(_, _, let status): return status
        case .server(_, _, let status, _): return status
        case .rateLimited: return 429
        default: return nil
        }
    }

    /// Create from an ApiError.
    static func from(_ error: ApiError, status: Int) -> VaifError {
        switch status {
        case 401, 403:
            return .auth(message: error.message, status: status)
        case 429:
            return .rateLimited(retryAfter: nil)
        case 500...599:
            return .server(
                message: error.message,
                code: error.code,
                status: status,
                requestId: error.requestId
            )
        default:
            return .server(
                message: error.message,
                code: error.code,
                status: status,
                requestId: error.requestId
            )
        }
    }
}
