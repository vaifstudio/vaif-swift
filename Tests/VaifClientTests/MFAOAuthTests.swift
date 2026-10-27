import Foundation
import Testing
@testable import VaifClient

@Suite struct MFAOAuthTests {
    @Test func mfaEnrollmentAndRecoveryUseAuthorizedRoutes() async throws {
        let stub = Stub { request, _ in
            if request.path.hasSuffix("enroll-start") {
                return .json(200, ["enrollToken": "en", "secret": "secret", "otpauthUri": "otpauth://totp/test", "expiresInSeconds": 600])
            }
            return .json(200, ["ok": true, "backupCodes": ["backup"]])
        }
        let client = try makeClient(stub)
        #expect(await vaifError { _ = try await client.auth.enrollMFA() }?.code == "NOT_SIGNED_IN")
        #expect(stub.count == 0)
        try await client.auth.setSession(accessToken: "user", refreshToken: nil)
        #expect(try await client.auth.enrollMFA().enrollToken == "en")
        #expect(stub.last.method == "POST" && stub.last.path == "/projects/proj_123/auth/mfa/enroll-start")
        #expect(stub.last.header("Authorization") == "Bearer user")
        #expect(try await client.auth.confirmMFA(enrollToken: "en", code: "123456") == ["backup"])
        #expect(stub.last.path == "/projects/proj_123/auth/mfa/enroll-confirm")
        #expect(stub.last.json == ["enrollToken": "en", "code": "123456"])
        #expect(try await client.auth.regenerateMFACodes(code: "123456") == ["backup"])
        #expect(stub.last.path == "/projects/proj_123/auth/mfa/regenerate-codes")
        try await client.auth.disableMFA(code: "654321")
        #expect(stub.last.path == "/projects/proj_123/auth/mfa/disable" && stub.last.json == ["code": "654321"])
    }

    @Test func oauthUsesS256AndExchangesCodeWithoutBearer() async throws {
        let stub = Stub { request, _ in
            request.path.hasSuffix("/start") ? .json(200, ["ok": true, "url": "https://accounts.example/consent", "expiresIn": 600]) : loginReply("oauth", "refresh")
        }
        let client = try makeClient(stub)
        // RFC 7636 appendix B test vector.
        let verifier = "dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk"
        let start = try await client.auth.getOAuthSignInURL(provider: "google", redirectURL: "myapp://callback", codeVerifier: verifier, state: "state")
        #expect(start.codeVerifier == verifier && start.state == "state" && start.url == "https://accounts.example/consent")
        #expect(stub.last.path == "/projects/proj_123/auth/oauth/google/start")
        #expect(stub.last.json == ["redirectUrl": "myapp://callback", "codeChallenge": "E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM",
                                   "codeChallengeMethod": "S256", "state": "state"])
        try await client.auth.setSession(accessToken: "old", refreshToken: nil)
        let result = try await client.auth.exchangeOAuthCode(code: "one-time", codeVerifier: verifier)
        guard case .session(let session) = result else { Issue.record("expected session"); return }
        #expect(session.accessToken == "oauth" && session.refreshToken == "refresh")
        #expect(await client.auth.session?.accessToken == "oauth")
        #expect(stub.last.path == "/projects/proj_123/auth/oauth/token")
        #expect(stub.last.json == ["code": "one-time", "codeVerifier": .string(verifier)])
        #expect(stub.last.header("Authorization") == nil)
        #expect(stub.count == 2)
    }

    @Test func oauthGeneratesFreshVerifierAndStateAndRejectsBadInput() async throws {
        let stub = Stub { _, _ in .json(200, ["ok": true, "url": "https://accounts.example/consent"]) }
        let client = try makeClient(stub)
        let a = try await client.auth.getOAuthSignInURL(provider: "github", redirectURL: "myapp://cb")
        let b = try await client.auth.getOAuthSignInURL(provider: "github", redirectURL: "myapp://cb")
        #expect(a.codeVerifier.count == 43 && a.state.count == 43)
        #expect(a.codeVerifier != b.codeVerifier && a.state != b.state && a.codeVerifier != a.state)
        #expect(stub.count == 2)
        for bad in [("google", "myapp://cb", "short"), ("google", "not a url", nil), ("myspace", "myapp://cb", nil)] as [(String, String, String?)] {
            #expect(await vaifError { _ = try await client.auth.getOAuthSignInURL(provider: bad.0, redirectURL: bad.1, codeVerifier: bad.2) }?.kind == .invalidArgument)
        }
        #expect(await vaifError { _ = try await client.auth.exchangeOAuthCode(code: "", codeVerifier: a.codeVerifier) }?.kind == .invalidArgument)
        #expect(stub.count == 2)
    }

    @Test func oauthExchangeCanRequireMFA() async throws {
        let stub = Stub { _, _ in .json(200, ["ok": true, "mfaRequired": true, "challengeToken": "ch"]) }
        let client = try makeClient(stub)
        let result = try await client.auth.exchangeOAuthCode(code: "c", codeVerifier: String(repeating: "v", count: 43))
        #expect(result == .mfaRequired(challengeToken: "ch"))
        #expect(await client.auth.session == nil)
    }
}
