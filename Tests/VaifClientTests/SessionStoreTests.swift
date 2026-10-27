import Foundation
import Security
import Testing
@testable import VaifClient

/// A store whose writes can be made to fail.
final class FlakyStore: SessionStore, @unchecked Sendable {
    let inner = MemorySessionStore()
    var failWrites = false
    func load() throws -> Session? { try inner.load() }
    func save(_ session: Session) throws {
        if failWrites { throw VaifError(kind: .storage, message: "disk full", code: "TEST_FULL") }
        try inner.save(session)
    }
    func clear() throws {
        if failWrites { throw VaifError(kind: .storage, message: "disk full", code: "TEST_FULL") }
        try inner.clear()
    }
}

/// A store whose `clear()` fails a set number of times (`.max` = always) and
/// whose `save` can be made to fail, counting the calls it receives.
final class ScriptedStore: SessionStore, @unchecked Sendable {
    let inner: MemorySessionStore
    private let lock = NSLock()
    private var clearFailuresLeft: Int
    private var failSaves: Bool
    private var clears = 0

    init(_ session: Session? = nil, clearFailures: Int = 0, failSaves: Bool = false) {
        inner = MemorySessionStore(session)
        clearFailuresLeft = clearFailures
        self.failSaves = failSaves
    }

    var clearCalls: Int { lock.lock(); defer { lock.unlock() }; return clears }

    func setClearFailures(_ count: Int) { lock.lock(); clearFailuresLeft = count; lock.unlock() }

    func setFailSaves(_ fail: Bool) { lock.lock(); failSaves = fail; lock.unlock() }

    func load() throws -> Session? { try inner.load() }

    func save(_ session: Session) throws {
        lock.lock(); let fail = failSaves; lock.unlock()
        if fail { throw VaifError(kind: .storage, message: "save refused", code: "TEST_SAVE") }
        try inner.save(session)
    }

    func clear() throws {
        lock.lock()
        clears += 1
        let fail = clearFailuresLeft > 0
        if fail, clearFailuresLeft != .max { clearFailuresLeft -= 1 }
        lock.unlock()
        if fail { throw VaifError(kind: .storage, message: "delete refused", code: "TEST_CLEAR") }
        try inner.clear()
    }
}

/// A login stub that also answers `/logout`, recording what it was sent.
private func signOutStub() -> Stub {
    Stub { request, _ in
        if request.path.hasSuffix("/logout") { return .json(200, ["ok": true]) }
        return loginReply("at_1", "rt_1")
    }
}

/// Sign-out throws while the stored session could not be deleted, so it
/// cannot come back at the next launch.
@Suite struct SignOutStoreTests {
    @Test func signOutThrowsWhenTheStoreKeepsTheSession() async throws {
        let store = ScriptedStore(clearFailures: .max)
        let stub = signOutStub()
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, retry: fastRetry,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        _ = try await client.auth.signIn(email: "a@b.c", password: "pw")
        let changes = await client.auth.sessionChanges()

        // Without this check, this would return normally while the session stayed stored.
        let error = await vaifError { try await client.auth.signOut() }
        #expect(error?.kind == .storage)
        #expect(error?.code == "TEST_CLEAR")
        #expect(store.clearCalls == 2) // the first try and one retry
        #expect(await client.auth.sessionStoreError?.code == "TEST_CLEAR")

        // Memory is cleared and observers hear about it anyway.
        #expect(await client.auth.session == nil)
        var iterator = changes.makeAsyncIterator()
        #expect(await iterator.next() == AuthStateChange(event: .signedOut, session: nil))

        // The server is still asked to revoke the session, so the stored copy is dead.
        let logout = stub.requests.filter { $0.path == "/projects/proj_123/auth/logout" }
        #expect(logout.count == 1)
        #expect(logout.first?.header("Authorization") == "Bearer at_1")

        // This is why sign-out must not report success: the next launch restores it.
        let relaunched = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL,
                                        sessionStore: store, urlSession: MockURLProtocol.session)
        #expect(await relaunched.auth.session?.accessToken == "at_1")

        // Signing out again retries the clear, without another server call.
        let again = await vaifError { try await client.auth.signOut() }
        #expect(again?.code == "TEST_CLEAR")
        store.setClearFailures(0)
        try await client.auth.signOut()
        #expect(try store.load() == nil)
        #expect(await client.auth.sessionStoreError == nil)
        #expect(stub.requests.filter { $0.path == "/projects/proj_123/auth/logout" }.count == 1)
        let fresh = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL,
                                   sessionStore: store, urlSession: MockURLProtocol.session)
        #expect(await fresh.auth.session == nil)
    }

    @Test func aClearThatFailsOnceIsRetriedAndTheSessionIsGone() async throws {
        let store = ScriptedStore(clearFailures: 1)
        let stub = signOutStub()
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, retry: fastRetry,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        _ = try await client.auth.signIn(email: "a@b.c", password: "pw")
        #expect(try store.load()?.accessToken == "at_1")

        try await client.auth.signOut()
        #expect(store.clearCalls == 2)
        #expect(try store.load() == nil)
        #expect(await client.auth.sessionStoreError == nil)
        let relaunched = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL,
                                        sessionStore: store, urlSession: MockURLProtocol.session)
        #expect(await relaunched.auth.session == nil)
    }

    @Test func bothFailuresAreReportedWhenTheStoreAndTheServerFail() async throws {
        let store = ScriptedStore(clearFailures: .max)
        let stub = Stub { request, _ in
            if request.path.hasSuffix("/logout") { return .json(503, ["error": "UNAVAILABLE", "message": "try later"]) }
            return loginReply("at_1", "rt_1")
        }
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, retry: fastRetry,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        _ = try await client.auth.signIn(email: "a@b.c", password: "pw")
        let error = await vaifError { try await client.auth.signOut() }
        #expect(error?.kind == .storage)
        #expect(error?.code == "TEST_CLEAR")
        #expect(error?.message == "delete refused; the server sign-out also failed: VaifError.server: try later (status 503, code UNAVAILABLE)")
        #expect(await client.auth.session == nil)
    }

    @Test func aServerFailureAloneIsThrownAfterTheLocalClear() async throws {
        let store = ScriptedStore()
        let stub = Stub { request, _ in
            if request.path.hasSuffix("/logout") { return .json(503, ["error": "UNAVAILABLE", "message": "try later"]) }
            return loginReply("at_1", "rt_1")
        }
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, retry: fastRetry,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        _ = try await client.auth.signIn(email: "a@b.c", password: "pw")
        let error = await vaifError { try await client.auth.signOut() }
        #expect(error?.kind == .server)
        #expect(error?.status == 503)
        #expect(await client.auth.session == nil)
        #expect(try store.load() == nil)
    }

    @Test func anEarlierSaveFailureDoesNotMakeSignOutThrow() async throws {
        // A session left by an earlier launch; saving the new one then fails.
        let stale = Session(accessToken: "at_0", refreshToken: "rt_0", expiresAt: Date().addingTimeInterval(3600))
        let store = ScriptedStore(stale, failSaves: true)
        let stub = signOutStub()
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, retry: fastRetry,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        _ = try await client.auth.signIn(email: "a@b.c", password: "pw")
        #expect(await client.auth.sessionStoreError?.code == "TEST_SAVE")
        #expect(try store.load() == nil) // deleted when the save failed (FailedSaveTests)

        try await client.auth.signOut()
        #expect(await client.auth.sessionStoreError == nil)
        #expect(try store.load() == nil)
        let relaunched = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL,
                                        sessionStore: store, urlSession: MockURLProtocol.session)
        #expect(await relaunched.auth.session == nil)
    }

    @Test func aStoreErrorOfAnotherKindIsStillThrownAsStorage() async throws {
        final class OddStore: SessionStore, @unchecked Sendable {
            let inner = MemorySessionStore()
            func load() throws -> Session? { try inner.load() }
            func save(_ session: Session) throws { try inner.save(session) }
            func clear() throws { throw VaifError(kind: .network, message: "keychain daemon unreachable", code: "ODD") }
        }
        let stub = signOutStub()
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, retry: fastRetry,
                                    sessionStore: OddStore(), urlSession: MockURLProtocol.session)
        _ = try await client.auth.signIn(email: "a@b.c", password: "pw")
        let error = await vaifError { try await client.auth.signOut() }
        #expect(error?.kind == .storage)
        #expect(error?.code == "SESSION_STORE_FAILED")
    }
}

/// A new session that cannot be saved must not leave an older one in the
/// store, where the next launch would restore it.
@Suite struct FailedSaveTests {
    /// A session left in the store by an earlier launch.
    private static let stale = Session(accessToken: "at_0", refreshToken: "rt_0", expiresAt: Date().addingTimeInterval(3600))

    private static func refreshStub() -> Stub {
        Stub { request, _ in
            if request.path.hasSuffix("/refresh") { return loginReply("at_2", "rt_2") }
            if request.path.hasSuffix("/logout") { return .json(200, ["ok": true]) }
            return loginReply("at_1", "rt_1")
        }
    }

    @Test func aSignInWhoseSaveFailsDeletesTheOlderStoredSession() async throws {
        let store = ScriptedStore(Self.stale, failSaves: true)
        let stub = signOutStub()
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, retry: fastRetry,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        #expect(await client.auth.session?.accessToken == "at_0")

        // Sign-in still succeeds; the new session lives in memory only.
        let result = try await client.auth.signIn(email: "a@b.c", password: "pw")
        guard case .session(let session) = result else { Issue.record("expected a session"); return }
        #expect(session.accessToken == "at_1")
        #expect(await client.auth.session?.accessToken == "at_1")
        #expect(await client.auth.sessionStoreError?.code == "TEST_SAVE")

        // Without this check, at_0 would stay stored and the next launch would sign in as it.
        #expect(try store.load() == nil)
        #expect(store.clearCalls == 1)
        let relaunched = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL,
                                        sessionStore: store, urlSession: MockURLProtocol.session)
        #expect(await relaunched.auth.session == nil)
    }

    @Test func aSignInWhoseSaveAndDeleteFailThrowsStorage() async throws {
        let store = ScriptedStore(Self.stale, clearFailures: .max, failSaves: true)
        let stub = signOutStub()
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, retry: fastRetry,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        let changes = await client.auth.sessionChanges()

        let error = await vaifError { _ = try await client.auth.signIn(email: "a@b.c", password: "pw") }
        #expect(error?.kind == .storage)
        #expect(error?.code == "TEST_CLEAR")
        #expect(error?.message == "save refused; the earlier stored session could not be deleted: delete refused")
        #expect(store.clearCalls == 2) // the first try and one retry
        #expect(await client.auth.sessionStoreError?.code == "TEST_CLEAR")

        // As with signOut, memory and observers follow the server whatever the store does.
        #expect(await client.auth.session?.accessToken == "at_1")
        var iterator = changes.makeAsyncIterator()
        #expect(await iterator.next()?.event == .signedIn)

        // The older session is still stored; that is what the error reports.
        #expect(try store.load()?.accessToken == "at_0")
        store.setClearFailures(0)
        try await client.auth.signOut()
        #expect(try store.load() == nil)
    }

    @Test func setSessionThrowsWhenTheOlderSessionStaysStored() async throws {
        let store = ScriptedStore(Self.stale, clearFailures: .max, failSaves: true)
        let stub = signOutStub()
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, retry: fastRetry,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        let replacement = Session(accessToken: "at_9", refreshToken: "rt_9", expiresAt: Date().addingTimeInterval(3600))
        let error = await vaifError { try await client.auth.setSession(replacement) }
        #expect(error?.code == "TEST_CLEAR")
        let byParts = await vaifError { try await client.auth.setSession(accessToken: "at_8", refreshToken: nil) }
        #expect(byParts?.code == "TEST_CLEAR")
        #expect(await client.auth.session?.accessToken == "at_8")
    }

    @Test func aFailedSaveIntoAnEmptyStoreDoesNotThrow() async throws {
        // Nothing is stored, so nothing old can come back even though the delete fails.
        let store = ScriptedStore(clearFailures: .max, failSaves: true)
        let stub = signOutStub()
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, retry: fastRetry,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        _ = try await client.auth.signIn(email: "a@b.c", password: "pw")
        #expect(await client.auth.session?.accessToken == "at_1")
        #expect(await client.auth.sessionStoreError?.code == "TEST_SAVE")
        #expect(store.clearCalls == 2) // the delete was tried, and retried, before the store was read
        #expect(try store.load() == nil)
    }

    @Test func aRefreshWhoseSaveFailsDeletesThePreviousTokens() async throws {
        let store = ScriptedStore()
        let stub = Self.refreshStub()
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, retry: fastRetry,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        _ = try await client.auth.signIn(email: "a@b.c", password: "pw")
        #expect(try store.load()?.refreshToken == "rt_1")

        store.setFailSaves(true)
        let refreshed = try await client.auth.refreshSession()
        #expect(refreshed.accessToken == "at_2")
        #expect(await client.auth.sessionStoreError?.code == "TEST_SAVE")
        // rt_1 has been rotated out; restoring it at the next launch would fail or trip reuse detection.
        #expect(try store.load() == nil)
    }

    @Test func aRefreshNeverThrowsForTheStore() async throws {
        let store = ScriptedStore()
        let stub = Self.refreshStub()
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, retry: fastRetry,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        _ = try await client.auth.signIn(email: "a@b.c", password: "pw")
        store.setFailSaves(true)
        store.setClearFailures(.max)

        // A refresh runs inside ordinary requests, so the store failure is recorded, not thrown.
        let refreshed = try await client.auth.refreshSession()
        #expect(refreshed.accessToken == "at_2")
        #expect(await client.auth.sessionStoreError?.code == "TEST_CLEAR")
        #expect(try store.load()?.accessToken == "at_1")
    }

    @Test func anExplicitSessionThatCannotBeSavedDeletesTheStoredOne() async throws {
        let store = ScriptedStore(Self.stale, failSaves: true)
        let stub = signOutStub()
        let explicit = Session(accessToken: "at_explicit", expiresAt: Date().addingTimeInterval(3600))
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, session: explicit,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        #expect(await client.auth.session?.accessToken == "at_explicit")
        #expect(await client.auth.sessionStoreError?.code == "TEST_SAVE")
        #expect(try store.load() == nil)
    }

    /// `VaifClient(session:)`, like `setSession`, throws when the older
    /// stored session cannot be deleted.
    @Test func anExplicitSessionThatLeavesTheOlderOneStoredMakesTheClientThrow() async throws {
        let store = ScriptedStore(Self.stale, clearFailures: .max, failSaves: true)
        let stub = signOutStub()
        let explicit = Session(accessToken: "at_explicit", expiresAt: Date().addingTimeInterval(3600))
        // Without this check, the client would be created and the next launch would restore at_0.
        let error = await vaifError {
            _ = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, session: explicit,
                               sessionStore: store, urlSession: MockURLProtocol.session)
        }
        #expect(error?.kind == .storage)
        #expect(error?.code == "TEST_CLEAR")
        #expect(error?.message == "save refused; the earlier stored session could not be deleted: delete refused")
        #expect(store.clearCalls == 2)
        #expect(try store.load()?.accessToken == "at_0")
    }
}

/// A refresh that finishes after sign-out, or after another session replaced
/// the one it started from, never restores or overwrites the current session.
@Suite struct RefreshDuringSignOutTests {
    @Test func aRefreshThatLandsAfterSignOutDoesNotRestoreTheSession() async throws {
        let store = ScriptedStore()
        let stub = Stub { request, _ in
            if request.path.hasSuffix("/refresh") {
                var reply = loginReply("at_2", "rt_2")
                reply.delay = 0.3
                return reply
            }
            if request.path.hasSuffix("/logout") { return .json(200, ["ok": true]) }
            return loginReply("at_1", "rt_1")
        }
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, retry: fastRetry,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        _ = try await client.auth.signIn(email: "a@b.c", password: "pw")
        let refresh = Task { try await client.auth.refreshSession() }
        while !stub.requests.contains(where: { $0.path.hasSuffix("/refresh") }) {
            try await Task.sleep(nanoseconds: 5_000_000)
        }
        try await client.auth.signOut()

        let error = await vaifError { _ = try await refresh.value }
        #expect(error?.kind == .auth)
        #expect(error?.code == "NOT_SIGNED_IN")
        #expect(await client.auth.session == nil)
        #expect(try store.load() == nil)
        let relaunched = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL,
                                        sessionStore: store, urlSession: MockURLProtocol.session)
        #expect(await relaunched.auth.session == nil)
    }

    @Test func aSessionSetDuringARefreshIsNotOverwritten() async throws {
        let store = ScriptedStore()
        let stub = Stub { request, _ in
            if request.path.hasSuffix("/refresh") {
                var reply = loginReply("at_2", "rt_2")
                reply.delay = 0.3
                return reply
            }
            return loginReply("at_1", "rt_1")
        }
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, retry: fastRetry,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        _ = try await client.auth.signIn(email: "a@b.c", password: "pw")
        let refresh = Task { try await client.auth.refreshSession() }
        while !stub.requests.contains(where: { $0.path.hasSuffix("/refresh") }) {
            try await Task.sleep(nanoseconds: 5_000_000)
        }
        try await client.auth.setSession(accessToken: "at_other", refreshToken: "rt_other")

        #expect(try await refresh.value.accessToken == "at_other")
        #expect(await client.auth.session?.accessToken == "at_other")
        #expect(try store.load()?.accessToken == "at_other")
    }
}

@Suite struct SessionStoreTests {
    @Test func signInSavesRefreshUpdatesAndSignOutClears() async throws {
        let store = MemorySessionStore()
        let stub = Stub { request, _ in
            if request.path.hasSuffix("/refresh") { return loginReply("at_2", "rt_2") }
            if request.path.hasSuffix("/logout") { return .json(200, ["ok": true]) }
            return loginReply("at_1", "rt_1")
        }
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, retry: fastRetry,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        #expect(await client.auth.session == nil)
        _ = try await client.auth.signIn(email: "a@b.c", password: "pw")
        #expect(try store.load()?.accessToken == "at_1" && store.load()?.refreshToken == "rt_1")
        _ = try await client.auth.refreshSession()
        #expect(try store.load()?.accessToken == "at_2" && store.load()?.refreshToken == "rt_2")
        try await client.auth.signOut()
        #expect(try store.load() == nil)
        #expect(await client.auth.sessionStoreError == nil)
    }

    @Test func aNewClientRestoresTheStoredSessionAndUsesIt() async throws {
        let saved = Session(accessToken: "stored", refreshToken: "rt", expiresAt: Date().addingTimeInterval(3600), user: User(id: "u1"))
        let store = MemorySessionStore(saved)
        let stub = Stub { _, _ in emptyList }
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        #expect(await client.auth.session?.accessToken == "stored")
        _ = try await client.from("todos").list()
        #expect(stub.last.header("Authorization") == "Bearer stored")
        // An explicit session wins and is written to the store.
        let explicit = Session(accessToken: "explicit", expiresAt: Date().addingTimeInterval(3600))
        _ = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL, session: explicit,
                           sessionStore: store, urlSession: MockURLProtocol.session)
        #expect(try store.load()?.accessToken == "explicit")
    }

    @Test func aFailingStoreNeverFailsSignInButReportsTheError() async throws {
        let store = FlakyStore()
        store.failWrites = true
        let stub = Stub { _, _ in loginReply("at_1", "rt_1") }
        let client = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL,
                                    sessionStore: store, urlSession: MockURLProtocol.session)
        _ = try await client.auth.signIn(email: "a@b.c", password: "pw")
        #expect(await client.auth.session?.accessToken == "at_1")
        #expect(await client.auth.sessionStoreError?.code == "TEST_FULL")
        store.failWrites = false
        try await client.auth.setSession(accessToken: "at_2", refreshToken: nil)
        #expect(await client.auth.sessionStoreError == nil)
        #expect(try store.load()?.accessToken == "at_2")
    }

    @Test func storedSessionsRoundTripIncludingUserAndExpiry() throws {
        let expiry = Date(timeIntervalSince1970: 1_800_000_000)
        let session = Session(accessToken: "a", refreshToken: "r", expiresAt: expiry, user: User(id: "u", email: "e@x.y", metadata: ["k": 1]))
        let decoded = try SessionCoding.decode(SessionCoding.encode(session))
        #expect(decoded == session)
        let json = try JSONDecoder().decode(JSONValue.self, from: SessionCoding.encode(session))
        #expect(json["expiresAt"] == 1_800_000_000)
    }
}

/// Which store a client gets when the app passes none.
@Suite struct DefaultSessionStoreTests {
    @Test func withoutASessionStoreTheKeychainIsUsed() throws {
        // Reads the Keychain once (no item exists for this id); writes nothing.
        let client = try VaifClient(projectId: "proj_default_store_check", apiKey: testKey, urlSession: MockURLProtocol.session)
        let keychain = try #require(client.auth.store as? KeychainSessionStore)
        #expect(keychain.service == "studio.vaif.client")
        #expect(keychain.account == "session.https://api.vaif.studio.proj_default_store_check")
        #expect(keychain.accessGroup == nil)
        #expect(keychain.useDataProtectionKeychain == false)

        let platform = try VaifClient(apiKey: testKey, urlSession: MockURLProtocol.session)
        #expect((platform.auth.store as? KeychainSessionStore)?.account == "session.https://api.vaif.studio.platform")
    }

    /// The default store's item is named by the API origin and the project.
    @Test func theDefaultKeychainItemIsKeyedByTheAPIOriginAndProject() {
        func account(_ baseURL: String, _ projectId: String?) -> String? {
            (DefaultSessionStore.make(projectId: projectId, baseURL: URL(string: baseURL)!) as? KeychainSessionStore)?.account
        }
        #expect(account("https://api.vaif.studio", "proj_x") == "session.https://api.vaif.studio.proj_x")
        #expect(account("HTTPS://API.Example.COM:443/", "proj_x") == "session.https://api.example.com.proj_x")
        #expect(account("https://api.example.com:8443", "proj_x") == "session.https://api.example.com:8443.proj_x")
        #expect(account("http://localhost:8787", "proj_x") == "session.http://localhost:8787.proj_x")
        #expect(account("http://[::1]:3000", "proj_x") == "session.http://[::1]:3000.proj_x")
        #expect(account("https://api.example.com", nil) == "session.https://api.example.com.platform")
    }

    /// A client refuses a Keychain store made for another API or project.
    @Test func aKeychainStoreForAnotherOriginOrProjectIsRefused() async throws {
        let stub = Stub { _, _ in emptyList }
        for store in [KeychainSessionStore(projectId: testProject), // the default baseURL, not the stub's
                      KeychainSessionStore(projectId: "proj_other", baseURL: stub.baseURL)] {
            let error = await vaifError {
                _ = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL,
                                   sessionStore: store, urlSession: MockURLProtocol.session)
            }
            #expect(error?.kind == .invalidArgument)
        }
        // A store made for this API and project is accepted.
        _ = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: stub.baseURL,
                           sessionStore: KeychainSessionStore(projectId: testProject, baseURL: stub.baseURL.appendingPathComponent("/")),
                           urlSession: MockURLProtocol.session)
    }

    /// A stored session names the API origin and project it was saved for,
    /// and one saved for another is not restored.
    @Test func aSessionSavedForAnotherOriginOrProjectIsNotRestored() throws {
        let session = Session(accessToken: "at", refreshToken: "rt", expiresAt: Date(timeIntervalSince1970: 1_900_000_000))
        let owner = SessionOwner(baseURL: URL(string: "https://staging.example.com")!, projectId: "proj_x")
        let data = try SessionCoding.encode(session, owner: owner)
        let json = try JSONDecoder().decode(JSONValue.self, from: data)
        #expect(json["origin"] == "https://staging.example.com")
        #expect(json["projectId"] == "proj_x")
        #expect(json["session"]?["accessToken"] == "at")

        #expect(try SessionCoding.decode(data, owner: owner) == session)
        let production = SessionOwner(baseURL: URL(string: "https://api.example.com")!, projectId: "proj_x")
        #expect(try SessionCoding.decode(data, owner: production) == nil)
        let otherProject = SessionOwner(baseURL: URL(string: "https://staging.example.com")!, projectId: "proj_y")
        #expect(try SessionCoding.decode(data, owner: otherProject) == nil)
        let platform = SessionOwner(baseURL: URL(string: "https://staging.example.com")!, projectId: nil)
        #expect(try SessionCoding.decode(data, owner: platform) == nil)
        // A session stored without an origin is not restored by a store that requires one.
        #expect(throws: (any Error).self) { try SessionCoding.decode(SessionCoding.encode(session), owner: owner) }
    }

    @Test func aMemoryStoreOptsOutOfTheKeychain() async throws {
        let projectId = "proj_\(UUID().uuidString)"
        let stub = Stub { _, _ in loginReply("at_m", "rt_m") }
        let client = try VaifClient(projectId: projectId, apiKey: testKey, baseURL: stub.baseURL,
                                    sessionStore: MemorySessionStore(), urlSession: MockURLProtocol.session)
        #expect(client.auth.store is MemorySessionStore)
        _ = try await client.auth.signIn(email: "a@b.c", password: "pw")
        #expect(try client.auth.store?.load()?.accessToken == "at_m")
        if KeychainProbe.available {
            #expect(try KeychainSessionStore(projectId: projectId, baseURL: stub.baseURL).load() == nil)
        }
    }
}

enum KeychainProbe {
    /// Whether this process may write generic passwords (CI runners and
    /// developer Macs can; some sandboxes cannot).
    static let available: Bool = {
        let service = "studio.vaif.client.probe.\(UUID().uuidString)"
        let store = KeychainSessionStore(service: service, account: "probe")
        do {
            try store.save(Session(accessToken: "probe", expiresAt: Date()))
            try store.clear()
            return true
        } catch {
            return false
        }
    }()

    static let required = ProcessInfo.processInfo.environment["VAIF_REQUIRE_KEYCHAIN"] == "1"
}

@Suite(.serialized) struct KeychainSessionStoreTests {
    @Test func theKeychainIsUsableWhereItIsRequired() {
        // CI sets VAIF_REQUIRE_KEYCHAIN=1 so the Keychain test below cannot be skipped there silently.
        #expect(!KeychainProbe.required || KeychainProbe.available, "the Keychain is not writable in this environment")
    }

    @Test(.enabled(if: KeychainProbe.available, "Keychain not writable here"))
    func savesUpdatesLoadsAndClearsOneItem() throws {
        let store = KeychainSessionStore(projectId: "proj_\(UUID().uuidString)", service: "studio.vaif.client.tests")
        defer { try? store.clear() }
        #expect(try store.load() == nil)
        let first = Session(accessToken: "a1", refreshToken: "r1", expiresAt: Date(timeIntervalSince1970: 1_800_000_000), user: User(id: "u1"))
        try store.save(first)
        #expect(try store.load() == first)
        let second = Session(accessToken: "a2", refreshToken: "r2", expiresAt: Date(timeIntervalSince1970: 1_800_000_900))
        try store.save(second) // an update, not a duplicate add
        #expect(try store.load() == second)
        try store.clear()
        #expect(try store.load() == nil)
        try store.clear() // clearing nothing is fine
    }

    @Test(.enabled(if: KeychainProbe.available, "Keychain not writable here"))
    func undecodableDataIsDeletedAndReadsAsSignedOut() throws {
        let store = KeychainSessionStore(service: "studio.vaif.client.tests", account: "corrupt.\(UUID().uuidString)")
        defer { try? store.clear() }
        let add: [String: Any] = [kSecClass as String: kSecClassGenericPassword, kSecAttrService as String: store.service,
                                  kSecAttrAccount as String: store.account, kSecValueData as String: Data("not json".utf8)]
        #expect(SecItemAdd(add as CFDictionary, nil) == errSecSuccess)
        #expect(try store.load() == nil)
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword, kSecAttrService as String: store.service,
                                    kSecAttrAccount as String: store.account]
        #expect(SecItemCopyMatching(query as CFDictionary, nil) == errSecItemNotFound)
    }

    @Test(.enabled(if: KeychainProbe.available, "Keychain not writable here"))
    func aClientSignedInWithTheKeychainStoreIsRestoredByTheNextClient() async throws {
        let projectId = "proj_\(UUID().uuidString)"
        let stub = Stub { _, _ in loginReply("at_k", "rt_k") }
        let store = KeychainSessionStore(projectId: projectId, baseURL: stub.baseURL, service: "studio.vaif.client.tests")
        defer { try? store.clear() }
        let first = try VaifClient(projectId: projectId, apiKey: testKey, baseURL: stub.baseURL, sessionStore: store, urlSession: MockURLProtocol.session)
        _ = try await first.auth.signIn(email: "a@b.c", password: "pw")
        let second = try VaifClient(projectId: projectId, apiKey: testKey, baseURL: stub.baseURL, sessionStore: store, urlSession: MockURLProtocol.session)
        #expect(await second.auth.session?.accessToken == "at_k")
        #expect(await second.auth.session?.refreshToken == "rt_k")
    }

    /// The default store is keyed by the API origin and the project, so
    /// clients for one project on two APIs never share a stored session.
    @Test(.enabled(if: KeychainProbe.available, "Keychain not writable here"))
    func twoClientsForOneProjectAtDifferentBaseURLsKeepSeparateSessions() async throws {
        let projectId = "proj_\(UUID().uuidString)"
        let staging = Stub { _, _ in loginReply("at_staging", "rt_staging") }
        let production = Stub { _, _ in loginReply("at_production", "rt_production") }
        let first = try VaifClient(projectId: projectId, apiKey: testKey, baseURL: staging.baseURL, urlSession: MockURLProtocol.session)
        let second = try VaifClient(projectId: projectId, apiKey: testKey, baseURL: production.baseURL, urlSession: MockURLProtocol.session)
        let firstItem = try #require(first.auth.store as? KeychainSessionStore)
        let secondItem = try #require(second.auth.store as? KeychainSessionStore)
        defer { try? firstItem.clear(); try? secondItem.clear() }

        _ = try await first.auth.signIn(email: "a@b.c", password: "pw")
        let restoredForProduction = try VaifClient(projectId: projectId, apiKey: testKey, baseURL: production.baseURL,
                                                   urlSession: MockURLProtocol.session)
        // Keyed by the project alone, both clients would use the item `session.<projectId>`,
        // and this would restore at_staging.
        #expect(await restoredForProduction.auth.session == nil)

        _ = try await second.auth.signIn(email: "a@b.c", password: "pw")
        let restoredForStaging = try VaifClient(projectId: projectId, apiKey: testKey, baseURL: staging.baseURL,
                                                urlSession: MockURLProtocol.session)
        #expect(await restoredForStaging.auth.session?.accessToken == "at_staging")
        let restoredAgain = try VaifClient(projectId: projectId, apiKey: testKey, baseURL: production.baseURL,
                                           urlSession: MockURLProtocol.session)
        #expect(await restoredAgain.auth.session?.accessToken == "at_production")
    }

    /// An item at this client's key that does not name this client's API
    /// origin and project is not restored.
    @Test(.enabled(if: KeychainProbe.available, "Keychain not writable here"))
    func aStoredSessionThatDoesNotNameThisOriginIsNotRestored() async throws {
        let projectId = "proj_\(UUID().uuidString)"
        let stub = Stub { _, _ in emptyList }
        let client = try VaifClient(projectId: projectId, apiKey: testKey, baseURL: stub.baseURL, urlSession: MockURLProtocol.session)
        let item = try #require(client.auth.store as? KeychainSessionStore)
        defer { try? item.clear() }
        let foreign = Session(accessToken: "at_foreign", refreshToken: "rt_foreign", expiresAt: Date(timeIntervalSince1970: 1_900_000_000))
        // The same session written by a store that records no origin.
        try KeychainSessionStore(service: item.service, account: item.account).save(foreign)

        let relaunched = try VaifClient(projectId: projectId, apiKey: testKey, baseURL: stub.baseURL, urlSession: MockURLProtocol.session)
        #expect(await relaunched.auth.session == nil)
    }

    @Test(.enabled(if: KeychainProbe.available, "Keychain not writable here"))
    func aClientWithoutASessionStoreKeepsTheSessionInTheKeychain() async throws {
        let projectId = "proj_\(UUID().uuidString)"
        let stub = Stub { request, _ in
            if request.path.hasSuffix("/logout") { return .json(200, ["ok": true]) }
            return loginReply("at_d", "rt_d")
        }
        let item = KeychainSessionStore(projectId: projectId, baseURL: stub.baseURL) // the default store's item
        defer { try? item.clear() }
        let first = try VaifClient(projectId: projectId, apiKey: testKey, baseURL: stub.baseURL, urlSession: MockURLProtocol.session)
        _ = try await first.auth.signIn(email: "a@b.c", password: "pw")
        #expect(try item.load()?.accessToken == "at_d")

        let relaunched = try VaifClient(projectId: projectId, apiKey: testKey, baseURL: stub.baseURL, urlSession: MockURLProtocol.session)
        #expect(await relaunched.auth.session?.refreshToken == "rt_d")
        try await relaunched.auth.signOut()
        #expect(try item.load() == nil)
    }
}
