import Foundation

/// Client for one VAIF Studio project. Safe to share across tasks.
///
/// ```swift
/// let vaif = try VaifClient(projectId: "YOUR_PROJECT_ID", apiKey: "vk_pub_...")
/// _ = try await vaif.auth.signIn(email: "ada@example.com", password: "a strong password")
/// let todos = try await vaif.from("todos").eq("done", false).order("created_at", ascending: false).limit(20).list()
/// ```
public final class VaifClient: Sendable {
    public static let version = "1.0.0"
    public static let defaultBaseURL = URL(string: "https://api.vaif.studio")!

    /// The project's id; nil for a platform-account client (see `init`).
    public let projectId: String?
    /// End-user sign-in, sign-out and session refresh.
    public let auth: AuthClient
    /// Object upload, download and signed URLs.
    public let storage: StorageClient
    /// Function invocation.
    public let functions: FunctionsClient
    /// Every API operation with a typed contract, generated from the spec.
    public let operations: OperationsClient
    /// Database change subscriptions over WebSocket.
    public let realtime: RealtimeClient

    let transport: Transport

    /// - Parameters:
    ///   - projectId: The project's id. Leave it out only for a VAIF Studio
    ///     platform-account client: its `signUp` and `requestPasswordReset`
    ///     throw `CONSOLE_ONLY` (accounts are created and reset in the console)
    ///     and data queries throw `PROJECT_ID_REQUIRED`.
    ///   - apiKey: A project API key, sent as `x-vaif-key`. Use `vk_pub_` keys
    ///     in apps; `vk_srv_` keys bypass row-level security.
    ///   - baseURL: API origin; https required except for localhost.
    ///   - timeout: Hard limit per HTTP attempt, in seconds.
    ///   - retry: Retry policy for transient failures.
    ///   - headers: Extra headers sent with every API request.
    ///   - session: Restore a persisted end-user session. It is saved to the
    ///     session store; the initializer throws a `.storage` error when it
    ///     cannot be saved and an older stored session cannot be deleted.
    ///   - sessionStore: Where the end-user session is kept between launches.
    ///     nil (the default) uses `KeychainSessionStore(projectId:baseURL:)`;
    ///     pass `MemorySessionStore()` to keep the session in memory only. The
    ///     stored session is restored at start-up unless `session` is given
    ///     (which is saved). Every client for the same project and API shares
    ///     the stored session: in a server, or any process that acts for more
    ///     than one user, pass `MemorySessionStore()` to each client.
    ///   - urlSession: The `URLSession` to use (cookies are never handled by it).
    public init(
        projectId: String? = nil,
        apiKey: String,
        baseURL: URL = VaifClient.defaultBaseURL,
        timeout: TimeInterval = 30,
        retry: RetryPolicy = .default,
        headers: [String: String] = [:],
        session: Session? = nil,
        sessionStore: (any SessionStore)? = nil,
        urlSession: URLSession = .shared
    ) throws {
        if let projectId, projectId.trimmingCharacters(in: .whitespaces).isEmpty {
            throw VaifError.invalidArgument("projectId must not be empty")
        }
        guard !apiKey.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw VaifError.invalidArgument("apiKey must not be empty")
        }
        guard timeout.isFinite, timeout > 0 else {
            throw VaifError.invalidArgument("timeout must be a positive, finite number of seconds")
        }
        let normalizedBaseURL = try Transport.normalize(baseURL: baseURL)
        if let keychain = sessionStore as? KeychainSessionStore, let bound = keychain.owner {
            let owner = SessionOwner(baseURL: normalizedBaseURL, projectId: projectId)
            guard bound == owner else {
                throw VaifError.invalidArgument(
                    "sessionStore is a KeychainSessionStore for \(bound.origin) and \(bound.projectId.map { "project \($0)" } ?? "the platform account"), " +
                    "but this client is for \(owner.origin) and \(projectId.map { "project \($0)" } ?? "the platform account")"
                )
            }
        }
        let transport = Transport(
            baseURL: normalizedBaseURL,
            apiKey: apiKey,
            session: urlSession,
            timeout: timeout,
            retry: retry,
            headers: headers
        )
        self.projectId = projectId
        self.transport = transport
        let auth = try AuthClient(transport: transport, projectId: projectId, session: session,
                              store: sessionStore ?? DefaultSessionStore.make(projectId: projectId, baseURL: normalizedBaseURL))
        self.auth = auth
        self.storage = StorageClient(transport: transport, auth: auth, projectId: projectId)
        self.functions = FunctionsClient(transport: transport, auth: auth)
        self.operations = OperationsClient(transport: transport, auth: auth)
        self.realtime = RealtimeClient(transport: transport, auth: auth)
    }

    public var baseURL: URL { transport.baseURL }

    /// Start an immutable query against `table`.
    public func from(_ table: String) -> Query {
        Query(transport: transport, auth: auth, projectId: projectId, table: table)
    }
}

/// Set by the API on every response a function produced, and on no other.
let functionRunIdHeader = "X-Vaif-Run-Id"

/// Sends a request as the signed-in user, if any. A 401 on a request that
/// carried a session token triggers one refresh and one retry: the API
/// rejected the token before running the handler, so the replay is safe.
/// A function's own 401, which the invoke route relays after the function
/// has run (it carries `X-Vaif-Run-Id`), is thrown as it is.
func sendAuthorized(_ request: HTTPRequest, transport: Transport, auth: AuthClient, requireSession: Bool = false) async throws -> HTTPResponse {
    var request = request
    let bearer = try await auth.bearer()
    if requireSession, bearer == nil {
        throw VaifError(kind: .auth, message: "not signed in", code: "NOT_SIGNED_IN")
    }
    request.bearer = bearer
    do {
        return try await transport.send(request)
    } catch let error as VaifError where error.status == 401 && bearer != nil && error.header(functionRunIdHeader) == nil {
        guard let fresh = try await auth.tokenAfterUnauthorized(stale: bearer!) else { throw error }
        request.bearer = fresh
        return try await transport.send(request)
    }
}
