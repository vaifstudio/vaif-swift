import Foundation
import Testing
@testable import VaifClient

@Suite struct AuthTests {
    @Test func signInStoresSessionAndRefreshCookie() async throws {
        let stub = Stub { _, _ in loginReply("at_1", "rt_1") }
        let client = try makeClient(stub)
        let changes = await client.auth.sessionChanges()
        let result = try await client.auth.signIn(email: "ada@example.com", password: "pw")
        guard case let .session(session) = result else { Issue.record("expected a session"); return }
        #expect(stub.last.json == ["email": "ada@example.com", "password": "pw"])
        #expect(session.accessToken == "at_1")
        #expect(session.refreshToken == "rt_1")
        #expect(session.user?.email == "ada@example.com")
        #expect((890...900).contains(session.expiresAt.timeIntervalSinceNow))
        var iterator = changes.makeAsyncIterator()
        let first = await iterator.next()
        #expect(first?.event == .signedIn)

        stub.setResponder { _, _ in emptyList }
        _ = try await client.from("todos").list()
        #expect(stub.last.header("Authorization") == "Bearer at_1")
    }

    @Test func mfaFlowAndBadCredentials() async throws {
        let stub = Stub { request, _ in
            if request.path.hasSuffix("/login") {
                if request.header("X-Test") == "bad" {
                    return .json(401, ["error": "INVALID_CREDENTIALS", "message": "Invalid email or password"])
                }
                return .json(200, ["ok": true, "mfaRequired": true, "challengeToken": "ch_1"])
            }
            return loginReply("at_mfa", "rt_mfa")
        }
        let client = try makeClient(stub)
        let result = try await client.auth.signIn(email: "ada@example.com", password: "pw")
        #expect(result == .mfaRequired(challengeToken: "ch_1"))
        #expect(await client.auth.session == nil)
        let session = try await client.auth.verifyMFA(challengeToken: "ch_1", code: "123456")
        #expect(session.accessToken == "at_mfa")
        #expect(stub.last.json == ["challengeToken": "ch_1", "code": "123456"])

        let bad = try makeClient(stub, headers: ["X-Test": "bad"])
        let error = await vaifError { _ = try await bad.auth.signIn(email: "ada@example.com", password: "no") }
        #expect(error?.code == "INVALID_CREDENTIALS" && error?.kind == .auth)
        #expect(await bad.auth.session == nil)
    }

    @Test func signUpSessionAndPendingVerification() async throws {
        let stub = Stub { _, i in
            i == 0 ? loginReply("at_new", "rt_new")
                : .json(201, ["ok": true, "pendingVerification": true, "message": "Check your email"])
        }
        let client = try makeClient(stub)
        let created = try await client.auth.signUp(email: "new@example.com", password: "pw", metadata: ["plan": "free"])
        #expect(created.session?.accessToken == "at_new")
        #expect(stub.last.json?["metadata"] == ["plan": "free"])
        let pending = try await makeClient(stub).auth.signUp(email: "taken@example.com", password: "pw")
        #expect(pending.session == nil && pending.pendingVerification && pending.message == "Check your email")
    }

    @Test func refreshIsSingleFlightAndRotates() async throws {
        let stub = Stub { _, _ in
            var reply = loginReply("at_2", "rt_2")
            reply.delay = 0.05
            return reply
        }
        let client = try makeClient(stub)
        try await client.auth.setSession(accessToken: "at_1", refreshToken: "rt_1", expiresAt: Date().addingTimeInterval(3600))
        let tokens = try await withThrowingTaskGroup(of: String.self) { group in
            for _ in 0..<25 { group.addTask { try await client.auth.refreshSession().accessToken } }
            return try await group.reduce(into: [String]()) { $0.append($1) }
        }
        #expect(stub.count == 1)
        #expect(Set(tokens) == ["at_2"])
        #expect(stub.last.header("Cookie") == "project_refresh_token=rt_1")
        try await client.auth.refreshSession()
        #expect(stub.last.header("Cookie") == "project_refresh_token=rt_2")
    }

    @Test func expiringSessionRefreshesBeforeRequests() async throws {
        let stub = Stub { request, _ in
            request.path.hasSuffix("/auth/refresh") ? loginReply("at_fresh", "rt_fresh") : emptyList
        }
        let client = try makeClient(stub)
        try await client.auth.setSession(accessToken: "at_old", refreshToken: "rt_old", expiresAt: Date().addingTimeInterval(5))
        try await withThrowingTaskGroup(of: Void.self) { group in
            for _ in 0..<5 { group.addTask { _ = try await client.from("todos").list() } }
            try await group.waitForAll()
        }
        #expect(stub.requests.filter { $0.path.hasSuffix("/auth/refresh") }.count == 1)
        #expect(stub.requests.filter { $0.path.hasSuffix("/todos") }.allSatisfy { $0.header("Authorization") == "Bearer at_fresh" })
    }

    @Test func unauthorizedTriggersOneRefreshAndOneRetry() async throws {
        let stub = Stub { request, _ in
            if request.path.hasSuffix("/auth/refresh") { return loginReply("at_new", "rt_2") }
            if request.header("Authorization") == "Bearer at_revoked" {
                return .json(401, ["error": "UNAUTHORIZED", "message": "Invalid or expired token"])
            }
            return .json(200, ["user": ["id": "u1"]])
        }
        let client = try makeClient(stub)
        try await client.auth.setSession(accessToken: "at_revoked", refreshToken: "rt_1")
        let user = try await client.auth.getUser()
        #expect(user.id == "u1")
        let auths = stub.requests.filter { $0.path.hasSuffix("/auth/me") }.map { $0.header("Authorization") }
        #expect(auths == ["Bearer at_revoked", "Bearer at_new"])
    }

    @Test func failedRefreshSignsOut() async throws {
        let stub = Stub { _, _ in .json(401, ["error": "UNAUTHORIZED", "message": "Invalid or expired refresh token"]) }
        let client = try makeClient(stub)
        try await client.auth.setSession(accessToken: "at", refreshToken: "rt_dead", expiresAt: Date().addingTimeInterval(-1))
        let changes = await client.auth.sessionChanges()
        let error = await vaifError { _ = try await client.from("todos").list() }
        #expect(error?.kind == .auth)
        #expect(await client.auth.session == nil)
        var iterator = changes.makeAsyncIterator()
        #expect(await iterator.next()?.event == .signedOut)
    }

    @Test func refreshWithoutTokenAndGetUserWithoutSession() async throws {
        let stub = Stub { _, _ in emptyList }
        let client = try makeClient(stub)
        #expect(await vaifError { _ = try await client.auth.getUser() }?.code == "NOT_SIGNED_IN")
        try await client.auth.setSession(accessToken: "at_only", refreshToken: nil)
        #expect(await vaifError { try await client.auth.refreshSession() }?.code == "NO_REFRESH_TOKEN")
        #expect(stub.count == 0)
    }

    @Test func signOutRevokesAndClearsEvenWhenExpired() async throws {
        let stub = Stub { _, i in i == 0 ? .json(200, ["ok": true]) : .json(401, ["error": "UNAUTHORIZED"]) }
        let client = try makeClient(stub)
        try await client.auth.setSession(accessToken: "at_1", refreshToken: "rt_1")
        try await client.auth.signOut()
        #expect(stub.last.header("Authorization") == "Bearer at_1")
        #expect(await client.auth.session == nil)
        try await client.auth.setSession(accessToken: "at_2", refreshToken: "rt_2")
        try await client.auth.signOut()
        #expect(await client.auth.session == nil)
        try await client.auth.signOut()
        #expect(stub.count == 2)
    }

    /// Sign-out revokes on the server with the refresh token, which the API
    /// uses when the access token has already expired, and does not refresh
    /// first.
    @Test func signOutWithAnExpiredAccessTokenRevokesWithTheRefreshToken() async throws {
        let stub = Stub { _, _ in .json(200, ["ok": true]) }
        let client = try makeClient(stub)
        try await client.auth.setSession(accessToken: "at_expired", refreshToken: "rt_live", expiresAt: Date().addingTimeInterval(-60))
        try await client.auth.signOut()
        #expect(stub.requests.map(\.path) == ["/projects/proj_123/auth/logout"])
        let logout = stub.last
        #expect(logout.json == ["refreshToken": "rt_live"])
        #expect(logout.header("Cookie") == "project_refresh_token=rt_live")
        #expect(await client.auth.session == nil)
    }

    @Test func sessionIsCodable() throws {
        let session = Session(accessToken: "at", refreshToken: "rt", expiresAt: Date(timeIntervalSince1970: 1_900_000_000))
        let decoded = try JSONDecoder().decode(Session.self, from: JSONEncoder().encode(session))
        #expect(decoded == session)
    }
}
