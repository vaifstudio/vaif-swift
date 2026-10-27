import Foundation
import CryptoKit

/// Signs a project's end users in and out (`/projects/:projectId/auth`) and
/// keeps their session fresh.
///
/// The session is kept in the client's session store (the Keychain by
/// default on Apple platforms; see `VaifClient(sessionStore:)`), which
/// receives every change and restores the session at start-up.
public actor AuthClient {
    static let refreshCookie = "project_refresh_token"
    static let platformRefreshCookie = "refresh_token"
    /// Refresh this many seconds before the access token expires.
    static let refreshLeeway: TimeInterval = 30

    private let transport: Transport
    private let projectId: String?
    private var current: Session?
    private var refreshTask: Task<Session, Error>?
    private var observers: [UUID: AsyncStream<AuthStateChange>.Continuation] = [:]
    /// Where the session is kept between launches; nil keeps it in memory only.
    nonisolated let store: (any SessionStore)?
    /// The last failure to load, save or clear the session in the
    /// `sessionStore`; nil after a successful write.
    ///
    /// A session that cannot be saved stays in memory, and the stored one is
    /// deleted so the next launch cannot restore an older session in its
    /// place. Calls that sign in throw a `.storage` error only when the store
    /// still holds a different session after that (the delete failed too),
    /// and `signOut` throws when the stored session could not be deleted.
    /// Refreshes never throw because of the store.
    public private(set) var sessionStoreError: VaifError?

    /// Throws a `.storage` error when `session` cannot be saved and the
    /// store still holds a different session, as `setSession` does.
    init(transport: Transport, projectId: String?, session: Session?, store: (any SessionStore)? = nil) throws {
        self.transport = transport
        self.projectId = projectId
        self.store = store
        var initial = session
        var storeError: VaifError?
        if let store {
            if let session {
                let outcome = Self.write(session, to: store)
                if let stale = outcome.staleSession { throw stale }
                storeError = outcome.failure
            } else {
                do { initial = try store.load() } catch { storeError = VaifError.storage(error) }
            }
        }
        self.current = initial
        self.sessionStoreError = storeError
    }

    /// `project_refresh_token` for app users, `refresh_token` for platform accounts.
    private var refreshCookieName: String { projectId == nil ? Self.platformRefreshCookie : Self.refreshCookie }

    /// The current session, or nil when signed out.
    public var session: Session? { current }

    /// A stream of session changes (signed in, token refreshed, signed out).
    public func sessionChanges() -> AsyncStream<AuthStateChange> {
        let (stream, continuation) = AsyncStream.makeStream(of: AuthStateChange.self)
        let id = UUID()
        observers[id] = continuation
        continuation.onTermination = { [weak self] _ in
            Task { await self?.removeObserver(id) }
        }
        return stream
    }

    private func removeObserver(_ id: UUID) { observers[id] = nil }

    /// Restore a persisted session.
    ///
    /// Throws a `.storage` error when the session cannot be saved and the
    /// store still holds a different one (see `sessionStoreError`); the
    /// session is in effect either way.
    public func setSession(_ session: Session) throws {
        try signedIn(session)
    }

    /// Restore a session from its parts. Unknown expiry is treated as one hour
    /// away; the SDK then relies on 401-triggered refresh.
    @discardableResult
    public func setSession(accessToken: String, refreshToken: String?, expiresAt: Date? = nil) throws -> Session {
        guard !accessToken.isEmpty else { throw VaifError.invalidArgument("accessToken must not be empty") }
        let session = Session(accessToken: accessToken, refreshToken: refreshToken,
                              expiresAt: expiresAt ?? Date().addingTimeInterval(3600))
        try signedIn(session)
        return session
    }

    /// Makes `session` current and tells observers, then throws when the
    /// store still holds an older session that the next launch would restore.
    private func signedIn(_ session: Session) throws {
        if let stale = update(session, .signedIn) { throw stale }
    }

    /// Sets the session, writes it to the store and tells observers. Returns
    /// an error only when the store still holds a session other than
    /// `session` (any session, after a sign-out); every store failure is also
    /// kept in `sessionStoreError`.
    @discardableResult
    private func update(_ session: Session?, _ event: AuthStateChange.Event) -> VaifError? {
        current = session
        let stale = persist(session)
        let change = AuthStateChange(event: event, session: session)
        for observer in observers.values { observer.yield(change) }
        return stale
    }

    private func persist(_ session: Session?) -> VaifError? {
        guard let store else { return nil }
        let outcome = Self.write(session, to: store)
        sessionStoreError = outcome.failure
        return outcome.staleSession
    }

    /// What one write to the session store left behind.
    struct StoreWrite {
        /// The failure to keep in `sessionStoreError`; nil when the write succeeded.
        var failure: VaifError?
        /// Set when the store still holds a session other than the one written
        /// (any session, for a clear), which the next launch would restore.
        var staleSession: VaifError?
    }

    /// Saves `session`, or clears the store for nil. When the save fails, the
    /// store is cleared too, so an older session cannot be restored in place of
    /// this one. A failed clear is retried once; if it still fails, the store
    /// is read to see whether a different session is left in it.
    static func write(_ session: Session?, to store: any SessionStore) -> StoreWrite {
        var saveFailure: VaifError?
        if let session {
            do {
                try store.save(session)
                return StoreWrite()
            } catch {
                saveFailure = VaifError.storage(error)
            }
        }
        do {
            do { try store.clear() } catch { try store.clear() }
            return StoreWrite(failure: saveFailure)
        } catch {
            let clearFailure = VaifError.storage(error)
            guard holdsOtherSession(store, than: session) else {
                return StoreWrite(failure: saveFailure ?? clearFailure)
            }
            guard let saveFailure else { return StoreWrite(failure: clearFailure, staleSession: clearFailure) }
            let failure = VaifError(
                kind: .storage,
                message: "\(saveFailure.message); the earlier stored session could not be deleted: \(clearFailure.message)",
                code: clearFailure.code
            )
            return StoreWrite(failure: failure, staleSession: failure)
        }
    }

    /// After a failed clear: whether the store still holds a session other
    /// than `session`. A store that cannot be read is assumed to.
    private static func holdsOtherSession(_ store: any SessionStore, than session: Session?) -> Bool {
        do {
            guard let stored = try store.load() else { return false }
            return stored != session
        } catch {
            return true
        }
    }

    private func path(_ suffix: String) -> String {
        let prefix = projectId.map { "/projects/\(Transport.escape($0))/auth" } ?? "/auth"
        return "\(prefix)/\(suffix)"
    }

    // MARK: - Requests

    /// Create an account with email and password.
    public func signUp(email: String, password: String, metadata: [String: JSONValue]? = nil, phone: String? = nil) async throws -> SignUpResult {
        if projectId == nil { throw VaifError.consoleOnly(signup: true) }
        var body: [String: JSONValue] = ["email": .string(email), "password": .string(password)]
        if let metadata { body["metadata"] = .object(metadata) }
        if let phone { body["phone"] = .string(phone) }
        let response = try await transport.send(try .json("POST", path("signup"), body))
        let payload = try response.decode(TokenPayload.self)
        if payload.accessToken != nil {
            let session = try payload.session(refreshToken: refreshToken(from: response, payload: payload), status: response.status)
            try signedIn(session)
            return SignUpResult(session: session, user: session.user, pendingVerification: false, message: nil)
        }
        return SignUpResult(session: nil, user: payload.user,
                            pendingVerification: payload.pendingVerification ?? true, message: payload.message)
    }

    /// Sign in with email and password. When the user has MFA enrolled the
    /// result is `.mfaRequired`; finish with `verifyMFA(challengeToken:code:)`.
    public func signIn(email: String, password: String) async throws -> SignInResult {
        let body: [String: JSONValue] = ["email": .string(email), "password": .string(password)]
        let response = try await transport.send(try .json("POST", path("login"), body))
        let payload = try response.decode(TokenPayload.self)
        if payload.mfaRequired == true {
            return .mfaRequired(challengeToken: payload.challengeToken ?? "")
        }
        let session = try payload.session(refreshToken: refreshToken(from: response, payload: payload), status: response.status)
        try signedIn(session)
        return .session(session)
    }

    /// Complete an MFA sign-in with a TOTP or backup code.
    @discardableResult
    public func verifyMFA(challengeToken: String, code: String) async throws -> Session {
        let body: [String: JSONValue] = ["challengeToken": .string(challengeToken), "code": .string(code)]
        let response = try await transport.send(try .json("POST", path("mfa/verify"), body))
        let payload = try response.decode(TokenPayload.self)
        let session = try payload.session(refreshToken: refreshToken(from: response, payload: payload), status: response.status)
        try signedIn(session)
        return session
    }

    /// Exchange the refresh token for a new access token. Concurrent callers
    /// share one in-flight refresh, so a burst of requests with an expired
    /// token makes exactly one network call.
    @discardableResult
    public func refreshSession() async throws -> Session {
        if let refreshTask { return try await refreshTask.value }
        let snapshot = current
        let task = Task<Session, Error> {
            defer { self.refreshTask = nil }
            return try await self.performRefresh(from: snapshot)
        }
        refreshTask = task
        return try await task.value
    }

    private func performRefresh(from snapshot: Session?) async throws -> Session {
        guard let snapshot, let refreshToken = snapshot.refreshToken, !refreshToken.isEmpty else {
            throw VaifError(kind: .auth, message: "no refresh token available; sign in again", code: "NO_REFRESH_TOKEN")
        }
        var request = HTTPRequest(method: "POST", path: path("refresh"))
        request.headers["Cookie"] = "\(refreshCookieName)=\(Transport.escape(refreshToken))"
        let response: HTTPResponse
        do {
            response = try await transport.send(request)
        } catch let error as VaifError where error.kind == .auth {
            // Revoked or expired refresh token: the session is over.
            if current == snapshot { update(nil, .signedOut) }
            throw error
        }
        // The actor ran other calls during the request. If the session was
        // signed out or replaced meanwhile, this result must not bring the
        // old one back (into memory or the store).
        guard current == snapshot else {
            if let current { return current }
            throw VaifError(kind: .auth, message: "signed out while the session was being refreshed", code: "NOT_SIGNED_IN")
        }
        let payload = try response.decode(TokenPayload.self)
        let rotated = self.refreshToken(from: response, payload: payload) ?? refreshToken
        var session = try payload.session(refreshToken: rotated, status: response.status)
        if session.user == nil, let user = snapshot.user {
            session = Session(accessToken: session.accessToken, refreshToken: session.refreshToken,
                              expiresAt: session.expiresAt, user: user)
        }
        update(session, .tokenRefreshed)
        return session
    }

    /// Clear the session locally, then revoke it on the server. Memory is
    /// cleared and observers get `.signedOut` whatever happens next; returns
    /// only once the server call has finished.
    ///
    /// Throws a `.storage` error when the `sessionStore` could not delete the
    /// session (tried twice) and still holds it: it would be restored at the
    /// next launch, so call `signOut()` again, which retries the delete.
    /// Otherwise throws the server's error when revoking failed; a 401
    /// (already expired) is not an error.
    ///
    /// The request carries the refresh token as well as the access token, so
    /// the server revokes the session even when the access token has expired.
    public func signOut() async throws {
        guard let session = current else {
            // Nothing in memory, but an earlier sign-out may have left the
            // session in the store.
            if let failure = persist(nil) { throw failure }
            return
        }
        let storeFailure = update(nil, .signedOut)
        var request = try HTTPRequest.json("POST", path("logout"), session.refreshToken.map { ["refreshToken": $0] } ?? [:])
        request.bearer = session.accessToken
        if let refresh = session.refreshToken {
            request.headers["Cookie"] = "\(refreshCookieName)=\(Transport.escape(refresh))"
        }
        do {
            _ = try await transport.send(request)
        } catch let error as VaifError where error.status == 401 {
            // Already expired or revoked.
        } catch {
            guard let storeFailure else { throw error }
            // The stored session is the bigger problem; keep both in the message.
            throw VaifError(kind: .storage, message: "\(storeFailure.message); the server sign-out also failed: \(error)",
                            code: storeFailure.code)
        }
        if let storeFailure { throw storeFailure }
    }

    private struct UserPayload: Decodable { let user: User? }

    /// The signed-in user's profile. Throws `.auth` with code `NOT_SIGNED_IN`
    /// when there is no session.
    public func getUser() async throws -> User {
        let request = HTTPRequest(method: "GET", path: path("me"))
        let response = try await sendAuthorized(request, transport: transport, auth: self, requireSession: true)
        guard let user = try response.decode(UserPayload.self).user else {
            throw VaifError(kind: .badResponse, message: "the response did not include a user", status: response.status)
        }
        return user
    }

    /// Email a password-reset link. Succeeds whether or not the address exists.
    public func requestPasswordReset(email: String) async throws {
        if projectId == nil { throw VaifError.consoleOnly(signup: false) }
        _ = try await transport.send(try .json("POST", path("forgot-password"), ["email": JSONValue.string(email)]))
    }

    /// Set a new password with the token from the reset email.
    public func resetPassword(token: String, newPassword: String) async throws {
        let body: [String: JSONValue] = ["token": .string(token), "password": .string(newPassword)]
        _ = try await transport.send(try .json("POST", path("reset-password"), body))
    }

    /// Begin TOTP enrollment; show the returned secret once to the user.
    public func enrollMFA() async throws -> MFAEnrollment {
        let response = try await sendAuthorized(HTTPRequest(method: "POST", path: path("mfa/enroll-start")), transport: transport, auth: self, requireSession: true)
        return try response.decode(MFAEnrollment.self)
    }

    private struct BackupPayload: Decodable { let backupCodes: [String] }

    public func confirmMFA(enrollToken: String, code: String) async throws -> [String] {
        let request = try HTTPRequest.json("POST", path("mfa/enroll-confirm"), ["enrollToken": enrollToken, "code": code])
        return try await sendAuthorized(request, transport: transport, auth: self, requireSession: true).decode(BackupPayload.self).backupCodes
    }

    public func disableMFA(code: String) async throws {
        let request = try HTTPRequest.json("POST", path("mfa/disable"), ["code": code])
        _ = try await sendAuthorized(request, transport: transport, auth: self, requireSession: true)
    }

    public func regenerateMFACodes(code: String) async throws -> [String] {
        let request = try HTTPRequest.json("POST", path("mfa/regenerate-codes"), ["code": code])
        return try await sendAuthorized(request, transport: transport, auth: self, requireSession: true).decode(BackupPayload.self).backupCodes
    }

    private static func validateVerifier(_ verifier: String) throws {
        guard (43...128).contains(verifier.utf8.count), verifier.unicodeScalars.allSatisfy({
            $0.isASCII && (CharacterSet.alphanumerics.contains($0) || "-._~".unicodeScalars.contains($0))
        }) else { throw VaifError.invalidArgument("codeVerifier must be 43-128 characters of A-Z, a-z, 0-9, '-', '.', '_' or '~'") }
    }

    private static func urlSafe(_ data: Data) -> String {
        data.base64EncodedString().replacingOccurrences(of: "+", with: "-").replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: "=", with: "")
    }

    /// Obtain a provider consent URL. Retain state and verifier securely for
    /// the callback; open the URL using your app's authentication browser.
    public func getOAuthSignInURL(provider: String, redirectURL: String, codeVerifier: String? = nil, state: String? = nil) async throws -> OAuthSignIn {
        guard projectId != nil else {
            throw VaifError(kind: .invalidArgument, message: "App-user OAuth requires projectId", code: "PROJECT_ID_REQUIRED")
        }
        guard ["google", "github"].contains(provider), let redirect = URL(string: redirectURL), redirect.scheme != nil else {
            throw VaifError.invalidArgument("OAuth requires google or github and an absolute redirectURL on the project's redirect allowlist")
        }
        // SymmetricKey uses the system's cryptographically secure random source.
        let verifier = codeVerifier ?? Self.urlSafe(SymmetricKey(size: .bits256).withUnsafeBytes { Data($0) })
        try Self.validateVerifier(verifier)
        let state = state ?? Self.urlSafe(SymmetricKey(size: .bits256).withUnsafeBytes { Data($0) })
        guard !state.isEmpty else { throw VaifError.invalidArgument("state must not be empty") }
        let challenge = Self.urlSafe(Data(SHA256.hash(data: Data(verifier.utf8))))
        let body = ["redirectUrl": redirectURL, "codeChallenge": challenge, "codeChallengeMethod": "S256", "state": state]
        let response = try await transport.send(try .json("POST", path("oauth/\(Transport.escape(provider))/start"), body))
        struct Payload: Decodable { let url: String; let expiresIn: Int? }
        let payload = try response.decode(Payload.self)
        return OAuthSignIn(url: payload.url, state: state, codeVerifier: verifier, expiresIn: payload.expiresIn)
    }

    /// Exchange a one-time OAuth code. The app must verify the callback's
    /// state against the state returned by getOAuthSignInURL before calling.
    public func exchangeOAuthCode(code: String, codeVerifier: String) async throws -> SignInResult {
        guard projectId != nil else {
            throw VaifError(kind: .invalidArgument, message: "App-user OAuth requires projectId", code: "PROJECT_ID_REQUIRED")
        }
        guard !code.isEmpty else { throw VaifError.invalidArgument("code must not be empty") }
        try Self.validateVerifier(codeVerifier)
        let response = try await transport.send(try .json("POST", path("oauth/token"), ["code": code, "codeVerifier": codeVerifier]))
        let payload = try response.decode(TokenPayload.self)
        if payload.mfaRequired == true {
            return .mfaRequired(challengeToken: payload.challengeToken ?? "")
        }
        let session = try payload.session(refreshToken: refreshToken(from: response, payload: payload), status: response.status)
        try signedIn(session)
        return .session(session)
    }

    // MARK: - Internal

    /// Access token for an outgoing request, refreshed first if it is about to expire.
    func bearer() async throws -> String? {
        guard let session = current else { return nil }
        if session.refreshToken != nil, session.expires(within: Self.refreshLeeway) {
            return try await refreshSession().accessToken
        }
        return session.accessToken
    }

    /// The token to retry with after `stale` got a 401, or nil if none.
    func tokenAfterUnauthorized(stale: String) async throws -> String? {
        guard let session = current, session.refreshToken != nil else { return nil }
        if session.accessToken != stale { return session.accessToken } // already refreshed
        return try await refreshSession().accessToken
    }

    /// The rotating refresh token: from `Set-Cookie` (the API's default, an
    /// HttpOnly cookie a native client reads here and sends back), or from the
    /// body when the API answers in body mode.
    private func refreshToken(from response: HTTPResponse, payload: TokenPayload) -> String? {
        if let cookie = Self.refreshToken(from: response, name: refreshCookieName) { return cookie }
        if let body = payload.refreshToken, !body.isEmpty { return body }
        return nil
    }

    static func refreshToken(from response: HTTPResponse, name: String = refreshCookie) -> String? {
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: response.headers, for: response.url)
        if let cookie = cookies.first(where: { $0.name == name }), !cookie.value.isEmpty {
            return cookie.value.removingPercentEncoding ?? cookie.value
        }
        return nil
    }
}

/// Wire shape shared by signup, login, MFA verify and refresh.
struct TokenPayload: Decodable {
    let accessToken: String?
    let expiresIn: Double?
    let user: User?
    let mfaRequired: Bool?
    let challengeToken: String?
    let refreshToken: String?
    let pendingVerification: Bool?
    let message: String?

    func session(refreshToken: String?, status: Int) throws -> Session {
        guard let accessToken, !accessToken.isEmpty else {
            throw VaifError(kind: .badResponse, message: "the response did not include an access token", status: status)
        }
        let lifetime = (expiresIn ?? 0) > 0 ? expiresIn! : 900
        return Session(accessToken: accessToken, refreshToken: refreshToken,
                       expiresAt: Date().addingTimeInterval(lifetime), user: user)
    }
}
