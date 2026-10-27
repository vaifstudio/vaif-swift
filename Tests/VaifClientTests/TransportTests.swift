import Foundation
import Testing
@testable import VaifClient

@Suite struct TransportTests {
    @Test func validatesConfiguration() async throws {
        #expect(throws: VaifError.self) { try VaifClient(projectId: "", apiKey: testKey) }
        #expect(throws: VaifError.self) { try VaifClient(projectId: testProject, apiKey: "") }
        #expect(throws: VaifError.self) {
            try VaifClient(projectId: testProject, apiKey: testKey, baseURL: URL(string: "http://api.vaif.studio")!)
        }
        let local = try VaifClient(projectId: testProject, apiKey: testKey, baseURL: URL(string: "http://localhost:3000/")!,
                                   sessionStore: MemorySessionStore())
        #expect(local.baseURL.absoluteString == "http://localhost:3000")
    }

    @Test func sendsKeyVersionAndUserAgent() async throws {
        let stub = Stub { _, _ in emptyList }
        let client = try makeClient(stub, headers: ["X-App": "demo"])
        _ = try await client.from("todos").list()
        let request = stub.last
        #expect(request.header("x-vaif-key") == testKey)
        #expect(request.header("Accept-Versions") == "v1")
        #expect(request.header("User-Agent") == "vaif-swift/1.0.0")
        #expect(VaifClient.version == "1.0.0")
        #expect(request.header("X-App") == "demo")
        #expect(request.header("Authorization") == nil)
    }

    @Test(arguments: [
        (400, "INVALID_COLUMN", VaifError.Kind.validation),
        (401, "INVALID_CREDENTIALS", .auth),
        (403, "FORBIDDEN", .auth),
        (404, "NOT_FOUND", .notFound),
        (409, "CONFLICT", .conflict),
        (402, "PAYMENT_REQUIRED", .request),
        (500, "InternalError", .server),
    ])
    func mapsStatusToTypedError(status: Int, code: String, kind: VaifError.Kind) async throws {
        let stub = Stub { _, _ in
            .json(status, ["error": .string(code), "message": "boom", "requestId": "req_1"])
        }
        let error = await vaifError { _ = try await makeClient(stub, retry: .none).from("todos").list() }
        #expect(error?.kind == kind)
        #expect(error?.status == status)
        #expect(error?.code == code)
        #expect(error?.message == "boom")
        #expect(error?.requestId == "req_1")
    }

    @Test func prefersExplicitCodeOverErrorField() async throws {
        let stub = Stub { _, _ in .json(400, ["error": "BadRequest", "code": "INVALID_COLUMN", "message": "no col"]) }
        let error = await vaifError { _ = try await makeClient(stub).from("todos").list() }
        #expect(error?.code == "INVALID_COLUMN")
    }

    @Test func retriesGetOn5xxThenSucceeds() async throws {
        let stub = Stub { _, i in
            switch i {
            case 0: return .status(503)
            case 1: return .status(502)
            default: return .json(200, ["data": [["id": 1]], "count": 1])
            }
        }
        let result = try await makeClient(stub).from("todos").list()
        #expect(result.count == 1)
        #expect(stub.count == 3)
    }

    @Test func retryBudgetIsBounded() async throws {
        let stub = Stub { _, _ in .status(500) }
        let error = await vaifError { _ = try await makeClient(stub).from("todos").list() }
        #expect(error?.kind == .server)
        #expect(stub.count == 4)
    }

    @Test func doesNotReplayPostOn5xx() async throws {
        let stub = Stub { _, _ in .status(503) }
        let error = await vaifError { try await makeClient(stub).from("todos").insert(["title": "x"] as Row) }
        #expect(error?.kind == .server)
        #expect(stub.count == 1)
    }

    @Test func retriesAnyMethodWhenConnectionNeverOpened() async throws {
        let stub = Stub { _, i in i == 0 ? .fail(.cannotConnectToHost) : .json(200, ["data": ["id": "n1"]]) }
        let row = try await makeClient(stub).from("todos").insert(["title": "x"] as Row)
        #expect(row["id"] == "n1")
        #expect(stub.count == 2)
    }

    @Test func hardTimeoutIsTypedAndPostIsNotReplayed() async throws {
        let stub = Stub { _, _ in Reply(status: 200, delay: 3) }
        let client = try makeClient(stub, timeout: 0.1)
        let start = Date()
        let error = await vaifError { try await client.from("todos").insert(["title": "x"] as Row) }
        #expect(error?.kind == .timeout)
        #expect(stub.count == 1)
        #expect(Date().timeIntervalSince(start) < 2)
        let getError = await vaifError { _ = try await client.from("todos").list() }
        #expect(getError?.kind == .timeout)
        #expect(stub.count == 5) // GET timeouts are retried
    }

    @Test func cancellationPropagates() async throws {
        let stub = Stub { _, _ in Reply(status: 200, delay: 5) }
        let client = try makeClient(stub)
        let task = Task { try await client.from("todos").list() }
        try await Task.sleep(nanoseconds: 50_000_000)
        task.cancel()
        await #expect(throws: CancellationError.self) { _ = try await task.value }
    }

    @Test func rateLimitHonorsRetryAfter() async throws {
        let stub = Stub { _, _ in .json(429, ["error": "RateLimited", "message": "slow"], headers: ["Retry-After": "7"]) }
        let client = try makeClient(stub, retry: RetryPolicy(maxRetries: 1, baseDelay: 0, maxDelay: 0))
        let error = await vaifError { _ = try await client.from("todos").list() }
        #expect(error?.kind == .rateLimited)
        #expect(error?.retryAfter == 7)
        #expect(stub.count == 2)
    }

    @Test func retryDelayIsExponentialCappedAndPrefersRetryAfter() {
        let policy = RetryPolicy(baseDelay: 1, maxDelay: 5, multiplier: 2)
        #expect((1...1.25).contains(policy.delay(forAttempt: 0)))
        #expect((4...5).contains(policy.delay(forAttempt: 2)))
        #expect((5...6.25).contains(policy.delay(forAttempt: 10)))
        #expect(policy.delay(forAttempt: 0, retryAfter: 3) == 3)
        #expect(policy.delay(forAttempt: 0, retryAfter: 60) == 5)
    }

    @Test func aTimeoutMustBeFinite() async throws {
        for timeout in [TimeInterval.infinity, .nan, 0, -1] {
            let error = await vaifError {
                _ = try VaifClient(projectId: testProject, apiKey: testKey, timeout: timeout, sessionStore: MemorySessionStore())
            }
            #expect(error?.kind == .invalidArgument)
            #expect(error?.message == "timeout must be a positive, finite number of seconds")
        }
    }

    /// A wait never traps converting seconds to nanoseconds: non-finite and
    /// huge values are capped at 10^9 seconds, and NaN or negative is no wait.
    @Test func waitsAreConvertedWithoutTrapping() {
        #expect(Transport.nanos(0.5) == 500_000_000)
        #expect(Transport.nanos(.infinity) == 1_000_000_000_000_000_000)
        #expect(Transport.nanos(1e300) == 1_000_000_000_000_000_000)
        #expect(Transport.nanos(.nan) == 0)
        #expect(Transport.nanos(-1) == 0)
        let unbounded = RetryPolicy(baseDelay: 1, maxDelay: .infinity)
        #expect(Transport.nanos(unbounded.delay(forAttempt: 0, retryAfter: .infinity)) == 1_000_000_000_000_000_000)
    }
}

/// A redirect never carries the API key, the access token, cookies or the
/// client's own headers to another origin.
@Suite struct RedirectTests {
    /// A GET with every credential the SDK sends, redirected by the API.
    private func credentialedGet(_ api: Stub) async throws -> HTTPResponse {
        let client = try makeClient(api, headers: ["X-App-Secret": "app-secret"])
        var request = HTTPRequest(method: "GET", path: "/storage/download")
        request.bearer = "at_secret"
        request.headers["Cookie"] = "project_refresh_token=rt_secret"
        return try await client.transport.send(request)
    }

    @Test func aRedirectToAnotherOriginCarriesNoCredentials() async throws {
        let files = Stub { _, _ in Reply(status: 200, body: Data("file-bytes".utf8)) }
        let api = Stub { _, _ in .redirect(to: "https://\(files.host)/object?sig=abc") }
        let response = try await credentialedGet(api)
        #expect(response.data == Data("file-bytes".utf8))
        #expect(api.last.header("x-vaif-key") == testKey) // the API itself gets them
        let followed = files.last
        #expect(followed.url.absoluteString == "https://\(files.host)/object?sig=abc")
        #expect(followed.header("x-vaif-key") == nil)
        #expect(followed.header("Authorization") == nil)
        #expect(followed.header("Cookie") == nil)
        #expect(followed.header("X-App-Secret") == nil)
        #expect(followed.header("Accept-Versions") == nil)
    }

    @Test func aRedirectWithinTheAPIOriginKeepsTheCredentials() async throws {
        let api = Stub { request, _ in
            request.path == "/storage/download" ? .redirect(to: "/storage/moved") : Reply(status: 200, body: Data("ok".utf8))
        }
        _ = try await credentialedGet(api)
        let followed = api.last
        #expect(followed.path == "/storage/moved")
        #expect(followed.header("x-vaif-key") == testKey)
        #expect(followed.header("Authorization") == "Bearer at_secret")
        #expect(followed.header("X-App-Secret") == "app-secret")
    }

    @Test func aRedirectThatWouldSendTheBodyToAnotherOriginIsRefused() async throws {
        let elsewhere = Stub { _, _ in .json(200, ["ok": true]) }
        let api = Stub { _, _ in .redirect(307, to: "https://\(elsewhere.host)/auth/login") }
        let client = try makeClient(api)
        let error = await vaifError { _ = try await client.auth.signIn(email: "ada@example.com", password: "a strong password") }
        #expect(error?.code == "INSECURE_REDIRECT")
        #expect(error?.status == 307)
        #expect(elsewhere.count == 0)
    }

    @Test func aRedirectToCleartextIsRefused() async throws {
        let elsewhere = Stub { _, _ in Reply(status: 200, body: Data("plain".utf8)) }
        let api = Stub { _, _ in .redirect(302, to: "http://\(elsewhere.host)/object") }
        let error = await vaifError { _ = try await credentialedGet(api) }
        #expect(error?.code == "INSECURE_REDIRECT")
        #expect(error?.kind == .request)
        #expect(error?.message == "refused a redirect to http://\(elsewhere.host): another origin is followed only for a GET or HEAD request to https (http only for localhost, 127.0.0.1 and ::1)")
        #expect(elsewhere.count == 0)
    }
}
