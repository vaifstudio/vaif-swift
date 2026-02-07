/// VAIF Auth Client
///
/// Authentication and user management for VAIF Studio projects.

import Foundation

// MARK: - Auth Types

/// User
public struct User: Codable {
    public let id: String
    public let email: String?
    public let phone: String?
    public let emailConfirmedAt: Date?
    public let phoneConfirmedAt: Date?
    public let lastSignInAt: Date?
    public let createdAt: Date
    public let updatedAt: Date?
    public let userMetadata: [String: String]?
    public let appMetadata: [String: String]?

    enum CodingKeys: String, CodingKey {
        case id, email, phone
        case emailConfirmedAt = "email_confirmed_at"
        case phoneConfirmedAt = "phone_confirmed_at"
        case lastSignInAt = "last_sign_in_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userMetadata = "user_metadata"
        case appMetadata = "app_metadata"
    }
}

/// Session
public struct Session: Codable {
    public let accessToken: String
    public let refreshToken: String
    public let expiresIn: Int
    public let expiresAt: Int
    public let tokenType: String
    public let user: User?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case expiresAt = "expires_at"
        case tokenType = "token_type"
        case user
    }
}

/// Auth error
public struct AuthError: Error, Sendable, LocalizedError {
    public let message: String
    public let status: Int?

    public var errorDescription: String? {
        "AuthError: \(message) (status: \(status.map(String.init) ?? "none"))"
    }
}

/// Auth response
public struct AuthResponse {
    public let session: Session?
    public let user: User?
    public let error: AuthError?

    public var isSuccess: Bool { error == nil }
}

/// OAuth provider
public enum OAuthProvider: String {
    case google
    case github
    case apple
    case microsoft
    case facebook
    case twitter
}

/// Auth state change event
public enum AuthChangeEvent {
    case initialSession
    case signedIn
    case signedOut
    case tokenRefreshed
    case userUpdated
    case passwordRecovery
}

/// Auth state change callback
public typealias AuthStateChangeCallback = (AuthChangeEvent, Session?) -> Void

// MARK: - Auth Client

/// Auth client for VAIF Studio.
///
/// Tokens are stored securely in the system Keychain when `persistSession` is enabled.
public final class VaifAuth {
    private let client: VaifClient
    private var currentSession: Session?
    private var currentUser: User?
    private var stateCallbacks: [UUID: AuthStateChangeCallback] = [:]
    private let keychain = KeychainStorage()

    init(client: VaifClient) {
        self.client = client
        restoreSession()
    }

    /// Restore session from Keychain on init.
    private func restoreSession() {
        guard client.config.persistSession else { return }
        guard let data = keychain.getData(KeychainStorage.sessionKey) else { return }

        do {
            let decoder = JSONDecoder()
            let session = try decoder.decode(Session.self, from: data)
            currentSession = session
            currentUser = session.user
            client.setAccessToken(session.accessToken)
        } catch {
            client.debug("Failed to restore session from Keychain: \(error)")
            keychain.delete(KeychainStorage.sessionKey)
        }
    }

    /// Get current session.
    public func getSession() -> (session: Session?, error: AuthError?) {
        return (currentSession, nil)
    }

    /// Get current user.
    public func getUser() async throws -> (user: User?, error: AuthError?) {
        guard currentSession != nil else {
            return (nil, nil)
        }

        let response: ApiResponse<User> = try await client.request(path: "/auth/user")

        if let error = response.error {
            return (nil, AuthError(message: error.message, status: response.status))
        }

        currentUser = response.data
        return (currentUser, nil)
    }

    /// Sign up with email and password.
    public func signUp(
        email: String? = nil,
        password: String? = nil,
        phone: String? = nil,
        data: [String: Any]? = nil,
        emailRedirectTo: String? = nil
    ) async throws -> AuthResponse {
        var body: [String: Any] = [:]
        if let email = email { body["email"] = email }
        if let password = password { body["password"] = password }
        if let phone = phone { body["phone"] = phone }
        if let data = data { body["data"] = data }
        if let redirect = emailRedirectTo { body["redirectTo"] = redirect }

        let response: ApiResponse<AuthResponseBody> = try await client.request(
            path: "/auth/signup",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return AuthResponse(
                session: nil,
                user: nil,
                error: AuthError(message: error.message, status: response.status)
            )
        }

        if let session = response.data?.session {
            await setSession(session)
            notifyStateChange(.signedIn, session)
        }

        return AuthResponse(
            session: response.data?.session,
            user: response.data?.user,
            error: nil
        )
    }

    /// Sign in with email/phone and password.
    public func signInWithPassword(
        email: String? = nil,
        password: String? = nil,
        phone: String? = nil
    ) async throws -> AuthResponse {
        var body: [String: Any] = [:]
        if let email = email { body["email"] = email }
        if let password = password { body["password"] = password }
        if let phone = phone { body["phone"] = phone }

        let response: ApiResponse<AuthResponseBody> = try await client.request(
            path: "/auth/token?grant_type=password",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return AuthResponse(
                session: nil,
                user: nil,
                error: AuthError(message: error.message, status: response.status)
            )
        }

        if let session = response.data?.session {
            await setSession(session)
            notifyStateChange(.signedIn, session)
        }

        return AuthResponse(
            session: response.data?.session,
            user: response.data?.user,
            error: nil
        )
    }

    /// Sign in with OAuth provider.
    public func signInWithOAuth(
        provider: OAuthProvider,
        redirectTo: String? = nil,
        scopes: [String]? = nil,
        queryParams: [String: String]? = nil
    ) -> (provider: String, url: String, error: AuthError?) {
        // Validate redirectTo to prevent open redirect attacks.
        if let redirect = redirectTo {
            guard let redirectURL = URL(string: redirect),
                  let scheme = redirectURL.scheme else {
                return (provider.rawValue, "", AuthError(message: "Invalid redirect URL", status: 400))
            }
            // Allow https:// and custom URL schemes (containing a dot, e.g. com.myapp://)
            // Block http://, javascript:, data:, etc.
            if scheme != "https" && !scheme.contains(".") {
                return (provider.rawValue, "", AuthError(
                    message: "Redirect URL must use HTTPS or a custom URL scheme",
                    status: 400
                ))
            }
        }

        var params = ["provider=\(provider.rawValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? provider.rawValue)"]
        if let redirect = redirectTo {
            params.append("redirect_to=\(redirect.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? redirect)")
        }
        if let scopes = scopes {
            let joined = scopes.joined(separator: " ")
            params.append("scopes=\(joined.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? joined)")
        }
        if let queryParams = queryParams {
            queryParams.forEach {
                let key = $0.key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? $0.key
                let value = $0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? $0.value
                params.append("\(key)=\(value)")
            }
        }

        let url = "\(client.config.apiUrl)/auth/authorize?\(params.joined(separator: "&"))"
        return (provider.rawValue, url, nil)
    }

    /// Sign in with magic link/OTP.
    public func signInWithOtp(
        email: String? = nil,
        phone: String? = nil,
        createUser: Bool = true,
        redirectTo: String? = nil
    ) async throws -> (messageId: String?, error: AuthError?) {
        var body: [String: Any] = ["create_user": createUser]
        if let email = email { body["email"] = email }
        if let phone = phone { body["phone"] = phone }
        if let redirect = redirectTo { body["redirect_to"] = redirect }

        let response: ApiResponse<[String: String]> = try await client.request(
            path: "/auth/otp",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return (nil, AuthError(message: error.message, status: response.status))
        }

        return (response.data?["messageId"], nil)
    }

    /// Verify OTP code.
    public func verifyOtp(
        token: String,
        type: String,
        email: String? = nil,
        phone: String? = nil
    ) async throws -> AuthResponse {
        var body: [String: Any] = ["token": token, "type": type]
        if let email = email { body["email"] = email }
        if let phone = phone { body["phone"] = phone }

        let response: ApiResponse<AuthResponseBody> = try await client.request(
            path: "/auth/verify",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return AuthResponse(
                session: nil,
                user: nil,
                error: AuthError(message: error.message, status: response.status)
            )
        }

        if let session = response.data?.session {
            await setSession(session)
            notifyStateChange(.signedIn, session)
        }

        return AuthResponse(
            session: response.data?.session,
            user: response.data?.user,
            error: nil
        )
    }

    /// Sign out.
    public func signOut(scope: String = "local") async throws -> AuthError? {
        if scope != "local" {
            let _: ApiResponse<EmptyResponse> = try await client.request(
                path: "/auth/logout",
                method: "POST",
                body: AnyCodable(["scope": scope])
            )
        }

        await clearSession()
        notifyStateChange(.signedOut, nil)
        return nil
    }

    /// Reset password via email.
    public func resetPasswordForEmail(
        email: String,
        redirectTo: String? = nil,
        captchaToken: String? = nil
    ) async throws -> AuthError? {
        var body: [String: Any] = ["email": email]
        if let redirect = redirectTo { body["redirect_to"] = redirect }
        if let captcha = captchaToken { body["captcha_token"] = captcha }

        let response: ApiResponse<EmptyResponse> = try await client.request(
            path: "/auth/recover",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return AuthError(message: error.message, status: response.status)
        }

        return nil
    }

    /// Update user.
    public func updateUser(
        email: String? = nil,
        password: String? = nil,
        phone: String? = nil,
        data: [String: Any]? = nil,
        nonce: String? = nil
    ) async throws -> (user: User?, error: AuthError?) {
        var body: [String: Any] = [:]
        if let email = email { body["email"] = email }
        if let password = password { body["password"] = password }
        if let phone = phone { body["phone"] = phone }
        if let data = data { body["data"] = data }
        if let nonce = nonce { body["nonce"] = nonce }

        let response: ApiResponse<User> = try await client.request(
            path: "/auth/user",
            method: "PUT",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return (nil, AuthError(message: error.message, status: response.status))
        }

        currentUser = response.data
        notifyStateChange(.userUpdated, currentSession)

        return (currentUser, nil)
    }

    /// Refresh session.
    public func refreshSession() async throws -> AuthResponse {
        guard let refreshToken = currentSession?.refreshToken else {
            return AuthResponse(
                session: nil,
                user: nil,
                error: AuthError(message: "No refresh token available", status: 401)
            )
        }

        let response: ApiResponse<AuthResponseBody> = try await client.request(
            path: "/auth/token?grant_type=refresh_token",
            method: "POST",
            body: AnyCodable(["refresh_token": refreshToken])
        )

        if let error = response.error {
            await clearSession()
            notifyStateChange(.tokenRefreshed, nil)
            return AuthResponse(
                session: nil,
                user: nil,
                error: AuthError(message: error.message, status: response.status)
            )
        }

        if let session = response.data?.session {
            await setSession(session)
            notifyStateChange(.tokenRefreshed, session)
        }

        return AuthResponse(
            session: response.data?.session,
            user: response.data?.user,
            error: nil
        )
    }

    /// Subscribe to auth state changes.
    @discardableResult
    public func onAuthStateChange(
        _ callback: @escaping AuthStateChangeCallback
    ) -> () -> Void {
        let id = UUID()
        stateCallbacks[id] = callback

        // Immediately call with current state
        if let session = currentSession {
            callback(.initialSession, session)
        }

        return { [weak self] in
            self?.stateCallbacks.removeValue(forKey: id)
        }
    }

    /// Exchange authorization code for session (PKCE).
    public func exchangeCodeForSession(_ code: String) async throws -> AuthResponse {
        let response: ApiResponse<AuthResponseBody> = try await client.request(
            path: "/auth/token?grant_type=authorization_code",
            method: "POST",
            body: AnyCodable(["code": code])
        )

        if let error = response.error {
            return AuthResponse(
                session: nil,
                user: nil,
                error: AuthError(message: error.message, status: response.status)
            )
        }

        if let session = response.data?.session {
            await setSession(session)
            notifyStateChange(.signedIn, session)
        }

        return AuthResponse(
            session: response.data?.session,
            user: response.data?.user,
            error: nil
        )
    }

    // MARK: - Private Methods

    private func setSession(_ session: Session) async {
        currentSession = session
        currentUser = session.user
        client.setAccessToken(session.accessToken)

        // Persist to Keychain
        if client.config.persistSession {
            if let data = try? JSONEncoder().encode(session) {
                keychain.setData(data, forKey: KeychainStorage.sessionKey)
            }
            keychain.set(session.accessToken, forKey: KeychainStorage.accessTokenKey)
            keychain.set(session.refreshToken, forKey: KeychainStorage.refreshTokenKey)
        }
    }

    private func clearSession() async {
        currentSession = nil
        currentUser = nil
        client.setAccessToken(nil)

        // Clear Keychain
        keychain.delete(KeychainStorage.sessionKey)
        keychain.delete(KeychainStorage.accessTokenKey)
        keychain.delete(KeychainStorage.refreshTokenKey)
    }

    private func notifyStateChange(_ event: AuthChangeEvent, _ session: Session?) {
        for callback in stateCallbacks.values {
            callback(event, session)
        }
    }
}

// MARK: - Helper Types

struct AuthResponseBody: Codable {
    let session: Session?
    let user: User?
}
