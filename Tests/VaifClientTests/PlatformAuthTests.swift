import Foundation
import Testing
@testable import VaifClient

/// A client without a projectId talks to the platform routes (`/auth/...`),
/// whose refresh cookie is `refresh_token`, not `project_refresh_token`.
@Suite struct PlatformAuthTests {
    @Test func platformSignupAndResetFailBeforeAnyRequestWithTheJSMessages() async throws {
        let stub = Stub { _, _ in .status(500) }
        let client = try platformClient(stub)
        let signup = await vaifError { _ = try await client.auth.signUp(email: "a@b.c", password: "pw") }
        let reset = await vaifError { try await client.auth.requestPasswordReset(email: "a@b.c") }
        #expect(signup?.code == "CONSOLE_ONLY" && signup?.isConsoleOnly == true && signup?.status == nil)
        #expect(signup?.message == "Create your VAIF Studio account in the console at https://console.vaif.studio/register. To sign up users of your own app, create the client with your projectId.")
        #expect(reset?.code == "CONSOLE_ONLY" && reset?.isConsoleOnly == true)
        #expect(reset?.message == "Reset your VAIF Studio password in the console at https://console.vaif.studio/forgot-password. To reset passwords for users of your own app, create the client with your projectId.")
        #expect(stub.count == 0)
    }

    @Test func projectClientSignupAndResetStillReachTheProjectRoutes() async throws {
        let stub = Stub { _, _ in .json(200, ["ok": true, "pendingVerification": true]) }
        let client = try makeClient(stub)
        _ = try await client.auth.signUp(email: "a@b.c", password: "pw")
        #expect(stub.last.path == "/projects/proj_123/auth/signup")
        try await client.auth.requestPasswordReset(email: "a@b.c")
        #expect(stub.last.path == "/projects/proj_123/auth/forgot-password")
    }

    @Test func platformClientRefusesAppUserOnlyCallsBeforeSending() async throws {
        let stub = Stub { _, _ in .status(500) }
        let client = try platformClient(stub)
        let oauth = await vaifError { _ = try await client.auth.getOAuthSignInURL(provider: "google", redirectURL: "myapp://cb") }
        let exchange = await vaifError { _ = try await client.auth.exchangeOAuthCode(code: "c", codeVerifier: String(repeating: "a", count: 43)) }
        let query = await vaifError { _ = try await client.from("todos").list() }
        #expect(oauth?.code == "PROJECT_ID_REQUIRED" && exchange?.code == "PROJECT_ID_REQUIRED" && query?.code == "PROJECT_ID_REQUIRED")
        #expect(stub.count == 0)
    }

    private func platformClient(_ stub: Stub) throws -> VaifClient {
        try VaifClient(apiKey: testKey, baseURL: stub.baseURL, retry: fastRetry, sessionStore: MemorySessionStore(),
                       urlSession: MockURLProtocol.session)
    }

    private static func platformLogin(_ token: String, _ refresh: String) -> Reply {
        .json(200, ["ok": true, "accessToken": .string(token), "expiresIn": 900, "user": ["id": "dev1"]],
              headers: ["Set-Cookie": "refresh_token=\(refresh); Path=/auth; HttpOnly; SameSite=Strict"])
    }

    @Test func platformSignInReadsAndSendsTheRefreshTokenCookie() async throws {
        let stub = Stub { request, _ in
            request.path == "/auth/refresh" ? Self.platformLogin("at_2", "rt_2") : Self.platformLogin("at_1", "rt_1")
        }
        let client = try platformClient(stub)
        guard case .session(let session) = try await client.auth.signIn(email: "dev@example.com", password: "pw") else {
            Issue.record("expected a session"); return
        }
        #expect(stub.last.path == "/auth/login")
        #expect(session.refreshToken == "rt_1")
        let refreshed = try await client.auth.refreshSession()
        #expect(stub.last.path == "/auth/refresh")
        #expect(stub.last.header("Cookie") == "refresh_token=rt_1")
        #expect(refreshed.refreshToken == "rt_2")
    }

    @Test func platformMFAVerifyReadsTheRefreshTokenCookie() async throws {
        let stub = Stub { _, _ in Self.platformLogin("at_m", "rt_m") }
        let session = try await platformClient(stub).auth.verifyMFA(challengeToken: "ch", code: "123456")
        #expect(stub.last.path == "/auth/mfa/verify")
        #expect(session.refreshToken == "rt_m")
    }

    @Test func refreshTokenInTheBodyIsAcceptedWhenNoCookieIsSet() async throws {
        let stub = Stub { _, _ in .json(200, ["accessToken": "at_b", "expiresIn": 900, "refreshToken": "rt_body"]) }
        guard case .session(let session) = try await makeClient(stub).auth.signIn(email: "a@b.c", password: "pw") else {
            Issue.record("expected a session"); return
        }
        #expect(session.refreshToken == "rt_body")
    }
}
