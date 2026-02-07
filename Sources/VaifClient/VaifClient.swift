/// VAIF Studio Swift SDK
///
/// Official client library for VAIF Studio - the AI-powered backend platform.
///
/// ```swift
/// let vaif = VaifClient(
///     projectId: "your-project-id",
///     apiKey: "your-api-key"
/// )
///
/// // Database operations
/// let users = try await vaif.db.from("users").select().eq("active", true).execute()
///
/// // Storage
/// let result = try await vaif.storage.from("avatars").upload(path: "user.png", data: imageData)
///
/// // Functions
/// let result = try await vaif.functions.invoke("send-email", body: ["to": "user@example.com"])
/// ```

import Foundation

// MARK: - Configuration

/// VAIF client configuration
public struct VaifConfig {
    public let projectId: String
    public let apiKey: String
    public let apiUrl: String
    public let realtimeUrl: String
    public let timeout: TimeInterval
    public let headers: [String: String]
    public let debug: Bool
    public let autoRefreshToken: Bool
    public let persistSession: Bool

    public init(
        projectId: String,
        apiKey: String,
        apiUrl: String = "https://api.vaif.studio",
        realtimeUrl: String = "wss://realtime.vaif.studio",
        timeout: TimeInterval = 30,
        headers: [String: String] = [:],
        debug: Bool = false,
        autoRefreshToken: Bool = true,
        persistSession: Bool = true
    ) {
        self.projectId = projectId
        self.apiKey = apiKey
        self.apiUrl = apiUrl
        self.realtimeUrl = realtimeUrl
        self.timeout = timeout
        self.headers = headers
        self.debug = debug
        self.autoRefreshToken = autoRefreshToken
        self.persistSession = persistSession
    }
}

// MARK: - API Response Types

/// API error
public struct ApiError: Error, Codable, Sendable, LocalizedError {
    public let message: String
    public let code: String?
    public let status: Int?
    public let details: String?
    public let requestId: String?

    public init(
        message: String,
        code: String? = nil,
        status: Int? = nil,
        details: String? = nil,
        requestId: String? = nil
    ) {
        self.message = message
        self.code = code
        self.status = status
        self.details = details
        self.requestId = requestId
    }

    public var errorDescription: String? {
        "ApiError: \(message) (code: \(code ?? "none"), status: \(status.map(String.init) ?? "none"))"
    }
}

/// API response wrapper
public struct ApiResponse<T> {
    public let data: T?
    public let error: ApiError?
    public let status: Int
    public let headers: [String: String]

    public var isSuccess: Bool {
        error == nil && status >= 200 && status < 300
    }
}

// MARK: - Main Client

/// VAIF Studio Client
///
/// Provides access to all VAIF services:
/// - Database (db)
/// - Realtime subscriptions (realtime)
/// - Storage (storage)
/// - Edge Functions (functions)
/// - Authentication (auth)
/// - AI Generation (ai)
public final class VaifClient {
    public let config: VaifConfig
    private var accessToken: String?
    private let session: URLSession

    /// Retry configuration for transient errors.
    public let retryConfig: RetryConfig

    /// Database client for CRUD operations
    public lazy var db: VaifDatabase = VaifDatabase(client: self)

    /// Realtime client for subscriptions
    public lazy var realtime: VaifRealtime = VaifRealtime(client: self)

    /// Storage client for file operations
    public lazy var storage: VaifStorage = VaifStorage(client: self)

    /// Functions client for edge function invocation
    public lazy var functions: VaifFunctions = VaifFunctions(client: self)

    /// Auth client for authentication
    public lazy var auth: VaifAuth = VaifAuth(client: self)

    /// AI client for generation features
    public lazy var ai: VaifAI = VaifAI(client: self)

    /// Type generator for generating Swift types from database schema
    public lazy var typegen: VaifTypeGen = VaifTypeGen(client: self)

    /// Create a VAIF client instance.
    ///
    /// - Parameters:
    ///   - projectId: Your VAIF project ID
    ///   - apiKey: Your VAIF API key
    ///   - apiUrl: API base URL (optional)
    ///   - realtimeUrl: WebSocket URL (optional)
    ///   - timeout: Request timeout in seconds
    ///   - headers: Custom headers
    ///   - debug: Enable debug logging
    ///   - autoRefreshToken: Auto-refresh auth tokens
    ///   - persistSession: Persist session to Keychain
    ///   - retryConfig: Retry configuration for transient errors
    public init(
        projectId: String,
        apiKey: String,
        apiUrl: String = "https://api.vaif.studio",
        realtimeUrl: String = "wss://realtime.vaif.studio",
        timeout: TimeInterval = 30,
        headers: [String: String] = [:],
        debug: Bool = false,
        autoRefreshToken: Bool = true,
        persistSession: Bool = true,
        retryConfig: RetryConfig = RetryConfig()
    ) {
        self.config = VaifConfig(
            projectId: projectId,
            apiKey: apiKey,
            apiUrl: apiUrl,
            realtimeUrl: realtimeUrl,
            timeout: timeout,
            headers: headers,
            debug: debug,
            autoRefreshToken: autoRefreshToken,
            persistSession: persistSession
        )
        self.retryConfig = retryConfig

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForResource = timeout * 3
        self.session = URLSession(configuration: configuration)
    }

    /// Set access token for authenticated requests.
    public func setAccessToken(_ token: String?) {
        self.accessToken = token
    }

    /// Get current access token.
    public func getAccessToken() -> String? {
        return accessToken
    }

    /// Make an authenticated API request.
    public func request<T: Decodable>(
        path: String,
        method: String = "GET",
        body: Encodable? = nil,
        params: [String: String]? = nil,
        headers: [String: String]? = nil
    ) async throws -> ApiResponse<T> {
        // Build URL
        var urlComponents = URLComponents(string: "\(config.apiUrl)\(path)")!
        if let params = params {
            urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let url = urlComponents.url else {
            throw ApiError(message: "Invalid URL", code: "INVALID_URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method

        // Build headers
        var requestHeaders = [
            "Content-Type": "application/json",
            "X-Project-ID": config.projectId,
            "apikey": config.apiKey
        ]
        requestHeaders.merge(config.headers) { _, new in new }
        if let headers = headers {
            requestHeaders.merge(headers) { _, new in new }
        }
        if let token = accessToken {
            requestHeaders["Authorization"] = "Bearer \(token)"
        }

        for (key, value) in requestHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }

        // Add body
        if let body = body {
            request.httpBody = try JSONEncoder().encode(AnyEncodable(body))
        }

        if config.debug {
            print("[VAIF] \(method) \(url)")
        }

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw ApiError(message: "Invalid response", code: "INVALID_RESPONSE")
            }

            let responseHeaders = Dictionary(
                uniqueKeysWithValues: httpResponse.allHeaderFields.compactMap {
                    guard let key = $0.key as? String, let value = $0.value as? String else { return nil }
                    return (key, value)
                }
            )

            if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return ApiResponse(
                    data: decodedData,
                    error: nil,
                    status: httpResponse.statusCode,
                    headers: responseHeaders
                )
            } else {
                let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data)
                return ApiResponse(
                    data: nil,
                    error: ApiError(
                        message: errorResponse?.message ?? "Request failed",
                        code: errorResponse?.code,
                        status: httpResponse.statusCode,
                        requestId: responseHeaders["x-request-id"]
                    ),
                    status: httpResponse.statusCode,
                    headers: responseHeaders
                )
            }
        } catch let error as ApiError {
            throw error
        } catch {
            throw ApiError(
                message: error.localizedDescription,
                code: "NETWORK_ERROR"
            )
        }
    }

    /// Log debug messages.
    func debug(_ message: String) {
        if config.debug {
            print("[VAIF] \(message)")
        }
    }
}

// MARK: - Helper Types

struct ErrorResponse: Decodable {
    let message: String?
    let code: String?
    let details: String?
}

struct AnyEncodable: Encodable {
    private let encode: (Encoder) throws -> Void

    init<T: Encodable>(_ wrapped: T) {
        self.encode = wrapped.encode
    }

    func encode(to encoder: Encoder) throws {
        try encode(encoder)
    }
}

// Empty response for void operations
public struct EmptyResponse: Decodable {}
