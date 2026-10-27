import Foundation

/// Describes one generated API operation: its route and how its request and
/// response are handled. `OperationsClient.call` serializes every operation
/// the same way.
public struct OperationDescriptor: Sendable {
    /// The HTTP method, such as `GET`.
    public let method: String
    /// The route, with a `{name}` placeholder for each path parameter.
    public let path: String
    /// The names of the placeholders in `path`.
    public let pathParameters: [String]
    /// The query parameters the operation requires.
    public let requiredQuery: [String]
    /// The request body's kind: `json`, `binary`, `text` or `none`.
    public let bodyKind: String
    /// Whether the operation requires a request body.
    public let bodyRequired: Bool
    /// How the response is read: `json`, `binary` or `sse`.
    public let transport: String
}

/// A request body for a generated operation, of the kind its descriptor names.
public enum OperationBody: Sendable {
    case json(JSONValue)
    case binary(Data)
    case text(String)
}

/// Every API operation with a typed contract, generated from the API's
/// OpenAPI document, using the client's auth, retries and error mapping.
/// Query values, JSON bodies and JSON responses are `JSONValue`; binary and
/// server-sent-event responses are returned as `FunctionResponse`. An event
/// stream's body is read in full within the request timeout.
public struct OperationsClient: Sendable {
    let transport: Transport
    let auth: AuthClient

    static func queryItems(_ query: [String: JSONValue]) throws -> [URLQueryItem] {
        func scalar(_ value: JSONValue) throws -> String {
            switch value {
            case .string(let v): return v
            case .bool(let v): return v ? "true" : "false"
            case .integer(let v): return String(v)
            case .number(let v) where v.isFinite: return String(v)
            default: throw VaifError.invalidArgument("query values must be scalars, scalar arrays, or shallow objects")
            }
        }
        var result: [URLQueryItem] = []
        for key in query.keys.sorted() {
            guard let value = query[key], !value.isNull else { continue }
            switch value {
            case .object(let object):
                for sub in object.keys.sorted() {
                    if let v = object[sub], !v.isNull { result.append(URLQueryItem(name: "\(key)[\(sub)]", value: try scalar(v))) }
                }
            case .array(let values):
                for v in values where !v.isNull { result.append(URLQueryItem(name: key, value: try scalar(v))) }
            default: result.append(URLQueryItem(name: key, value: try scalar(value)))
            }
        }
        return result
    }

    public func call(_ operation: OperationDescriptor, path: [String: String] = [:], query: [String: JSONValue] = [:], body: OperationBody? = nil, headers: [String: String] = [:]) async throws -> FunctionResponse {
        // These guards apply even on a project-configured client: these two
        // exact routes always refer to VAIF Studio platform accounts.
        if operation.method == "POST", operation.path == "/auth/signup" {
            throw VaifError.consoleOnly(signup: true, ownApp: "call postProjectsByProjectIdAuthSignup")
        }
        if operation.method == "POST", operation.path == "/auth/forgot-password" {
            throw VaifError.consoleOnly(signup: false, ownApp: "call postProjectsByProjectIdAuthForgotPassword")
        }
        var url = operation.path
        for name in operation.pathParameters {
            guard let value = path[name], !value.isEmpty else { throw VaifError.invalidArgument("missing path parameter: \(name)") }
            // Dot-only values must not be normalized to parent/current paths.
            guard value != ".", value != ".." else { throw VaifError.invalidArgument("path parameter cannot be a dot segment") }
            url = url.replacingOccurrences(of: "{\(name)}", with: Transport.escape(value))
        }
        for name in operation.requiredQuery where query[name] == nil || query[name] == .null {
            throw VaifError.invalidArgument("missing query parameter: \(name)")
        }
        if operation.bodyRequired && body == nil { throw VaifError.invalidArgument("request body is required") }
        var request = HTTPRequest(method: operation.method, path: url)
        if let body {
            switch (operation.bodyKind, body) {
            case ("json", .json(let value)): request = try .json(operation.method, url, value)
            case ("binary", .binary(let data)): request.body = data; request.contentType = "application/octet-stream"
            case ("text", .text(let text)): request.body = Data(text.utf8); request.contentType = "text/plain"
            default: throw VaifError.invalidArgument("body kind does not match the operation")
            }
        }
        request.query = try Self.queryItems(query)
        request.headers = headers
        let response = try await sendAuthorized(request, transport: transport, auth: auth)
        return FunctionResponse(status: response.status, headers: response.headers, data: response.data)
    }

    public func callJSON(_ operation: OperationDescriptor, path: [String: String] = [:], query: [String: JSONValue] = [:], body: OperationBody? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        let response = try await call(operation, path: path, query: query, body: body, headers: headers)
        if response.data.isEmpty { return .null }
        do { return try response.json() }
        catch { throw VaifError(kind: .badResponse, message: "operation did not return valid JSON", status: response.status) }
    }
}
