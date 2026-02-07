/// VAIF Functions Client
///
/// Invoke edge functions deployed on VAIF Studio.

import Foundation

// MARK: - Function Types

/// Function error
public struct FunctionError: Error, Sendable, LocalizedError {
    public let message: String
    public let status: Int?
    public let name: String?

    public var errorDescription: String? {
        "FunctionError\(name.map { " (\($0))" } ?? ""): \(message)"
    }
}

/// Function response
public struct FunctionResponse<T> {
    public let data: T?
    public let error: FunctionError?

    public var isSuccess: Bool { error == nil }
}

/// Function invoke options
public struct FunctionInvokeOptions {
    public let method: String
    public let headers: [String: String]
    public let timeout: TimeInterval?

    public init(
        method: String = "POST",
        headers: [String: String] = [:],
        timeout: TimeInterval? = nil
    ) {
        self.method = method
        self.headers = headers
        self.timeout = timeout
    }
}

// MARK: - Functions Client

/// Functions client for VAIF Studio.
public final class VaifFunctions {
    private let client: VaifClient

    init(client: VaifClient) {
        self.client = client
    }

    /// Invoke an edge function.
    ///
    /// ```swift
    /// let result = try await vaif.functions.invoke(
    ///     "send-email",
    ///     body: ["to": "user@example.com", "subject": "Hello"]
    /// )
    /// ```
    public func invoke<T: Decodable>(
        _ functionName: String,
        body: Any? = nil,
        options: FunctionInvokeOptions = FunctionInvokeOptions()
    ) async throws -> FunctionResponse<T> {
        let safeName = functionName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? functionName
        let url = URL(string: "\(client.config.apiUrl)/functions/\(safeName)")!

        var request = URLRequest(url: url)
        request.httpMethod = options.method

        // Set headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(client.config.projectId, forHTTPHeaderField: "X-Project-ID")
        request.setValue(client.config.apiKey, forHTTPHeaderField: "apikey")

        for (key, value) in options.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        if let token = client.getAccessToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        // Set body
        if let body = body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }

        // Set timeout
        if let timeout = options.timeout {
            request.timeoutInterval = timeout
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                return FunctionResponse(
                    data: nil,
                    error: FunctionError(
                        message: "Invalid response",
                        status: 0,
                        name: functionName
                    )
                )
            }

            if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return FunctionResponse(data: decoded, error: nil)
            } else {
                let errorBody = try? JSONDecoder().decode([String: String].self, from: data)
                return FunctionResponse(
                    data: nil,
                    error: FunctionError(
                        message: errorBody?["message"] ?? "Function invocation failed: \(httpResponse.statusCode)",
                        status: httpResponse.statusCode,
                        name: functionName
                    )
                )
            }
        } catch {
            return FunctionResponse(
                data: nil,
                error: FunctionError(
                    message: error.localizedDescription,
                    status: 0,
                    name: functionName
                )
            )
        }
    }

    /// Invoke a function and return raw data.
    public func invokeRaw(
        _ functionName: String,
        body: Any? = nil,
        options: FunctionInvokeOptions = FunctionInvokeOptions()
    ) async throws -> (data: Data?, error: FunctionError?) {
        let safeName = functionName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? functionName
        let url = URL(string: "\(client.config.apiUrl)/functions/\(safeName)")!

        var request = URLRequest(url: url)
        request.httpMethod = options.method

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(client.config.projectId, forHTTPHeaderField: "X-Project-ID")
        request.setValue(client.config.apiKey, forHTTPHeaderField: "apikey")

        for (key, value) in options.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        if let token = client.getAccessToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let body = body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }

        if let timeout = options.timeout {
            request.timeoutInterval = timeout
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return (nil, FunctionError(message: "Invalid response", status: 0, name: functionName))
        }

        if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
            return (data, nil)
        } else {
            return (nil, FunctionError(
                message: "Function invocation failed: \(httpResponse.statusCode)",
                status: httpResponse.statusCode,
                name: functionName
            ))
        }
    }

    /// Create function URL for direct invocation.
    public func createUrl(_ functionName: String) -> String {
        let safeName = functionName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? functionName
        return "\(client.config.apiUrl)/functions/\(safeName)"
    }

    /// Get list of deployed functions.
    public func list() async throws -> (data: [[String: Any]]?, error: FunctionError?) {
        let response: ApiResponse<[[String: Any]]> = try await client.request(path: "/functions")

        if let error = response.error {
            return (nil, FunctionError(
                message: error.message,
                status: response.status,
                name: "list"
            ))
        }

        return (response.data, nil)
    }

    /// Get function details.
    public func get(_ functionName: String) async throws -> (data: [String: Any]?, error: FunctionError?) {
        let safeName = functionName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? functionName
        let response: ApiResponse<[String: Any]> = try await client.request(
            path: "/functions/\(safeName)"
        )

        if let error = response.error {
            return (nil, FunctionError(
                message: error.message,
                status: response.status,
                name: functionName
            ))
        }

        return (response.data, nil)
    }
}
