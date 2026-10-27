import Foundation

/// Invoke the project's deployed functions (`POST /functions/:name/invoke`).
public struct FunctionsClient: Sendable {
    let transport: Transport
    let auth: AuthClient

    private static let methods: Set<String> = ["GET", "POST", "PUT", "PATCH", "DELETE"]

    /// Invoke `name` (or id) and return its HTTP response.
    ///
    /// `method`, `path`, `query` and `headers` are what the function sees. A
    /// non-2xx response throws a `VaifError` whose `body` holds the function's
    /// response. Invocations are not retried unless `idempotent` is true.
    public func invoke(
        _ name: String,
        body: JSONValue? = nil,
        method: String = "POST",
        path: String = "/",
        query: [String: String] = [:],
        headers: [String: String] = [:],
        timeout: TimeInterval? = nil,
        idempotent: Bool = false
    ) async throws -> FunctionResponse {
        guard !name.isEmpty else { throw VaifError.invalidArgument("function name must not be empty") }
        let verb = method.uppercased()
        guard Self.methods.contains(verb) else {
            throw VaifError.invalidArgument("method must be GET, POST, PUT, PATCH or DELETE")
        }
        guard path.hasPrefix("/") else { throw VaifError.invalidArgument("path must start with '/'") }
        // Always the envelope form: a raw body with "method" or "path" keys
        // would otherwise be misread by the API as an envelope.
        var envelope: [String: JSONValue] = ["method": .string(verb), "path": .string(path)]
        if !query.isEmpty { envelope["query"] = .object(query.mapValues(JSONValue.string)) }
        if !headers.isEmpty { envelope["headers"] = .object(headers.mapValues(JSONValue.string)) }
        if let body { envelope["body"] = body }
        var request = try HTTPRequest.json("POST", "/functions/\(Transport.escape(name))/invoke", envelope)
        request.timeout = timeout
        request.idempotent = idempotent
        let response = try await sendAuthorized(request, transport: transport, auth: auth)
        return FunctionResponse(status: response.status, headers: response.headers, data: response.data)
    }

    /// Invoke with an `Encodable` body. A body that cannot be encoded as
    /// JSON throws `invalidArgument` before anything is sent.
    public func invoke(_ name: String, encoding body: some Encodable, method: String = "POST", path: String = "/") async throws -> FunctionResponse {
        let value: JSONValue
        do {
            value = try JSONDecoder().decode(JSONValue.self, from: JSONEncoder().encode(body))
        } catch {
            throw VaifError.invalidArgument("could not encode the request body: \(VaifError.describe(error))")
        }
        return try await invoke(name, body: value, method: method, path: path)
    }
}
