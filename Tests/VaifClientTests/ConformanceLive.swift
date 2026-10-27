import Foundation
import Testing
@testable import VaifClient

// Live conformance: the shared cases in Fixtures/core.json (or the file that
// CONFORMANCE_CASES names) run against a VAIF Studio API on this machine,
// instead of the fake API that the rest of the suite uses.
//
// The test runs only when CONFORMANCE_LIVE=1 is set. API_URL is the API, and
// CONSOLE_ORIGIN is the console origin that the API accepts for account
// requests. Both must be loopback URLs (localhost, 127.0.0.1 or ::1); a run
// with CONFORMANCE_LIVE=1 and any other URL fails instead of skipping. A
// request to any other host fails before it is sent.
//
// The run signs in with CONFORMANCE_ACCESS_TOKEN, or with a new
// @vaif-local.test account and a password generated for the run. It then
// creates an organization (when the account has none), a project, a table and
// a storage bucket, so use an API whose data you can discard. Cases that need
// functions or realtime run only with CONFORMANCE_FUNCTION=1 or
// CONFORMANCE_REALTIME=1.

func isLocalConformanceURL(_ url: URL) -> Bool {
    ["http", "https", "ws", "wss"].contains(url.scheme?.lowercased() ?? "") &&
    ["localhost", "127.0.0.1", "::1", "[::1]"].contains(url.host?.lowercased() ?? "") &&
    url.user == nil && url.password == nil
}

/// Intercept remote URLs before URLSession opens a connection, including
/// presigned PUTs. Redirects are refused by the task delegate below.
final class RejectRemoteConformanceProtocol: URLProtocol, @unchecked Sendable {
    override class func canInit(with request: URLRequest) -> Bool { request.url.map { !isLocalConformanceURL($0) } ?? true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    override func startLoading() { client?.urlProtocol(self, didFailWithError: URLError(.unsupportedURL)) }
    override func stopLoading() { }
}

final class ConformanceRedirectGuard: NSObject, URLSessionTaskDelegate, Sendable {
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse,
                    newRequest request: URLRequest, completionHandler: @escaping @Sendable (URLRequest?) -> Void) { completionHandler(nil) }
}

@MainActor final class LiveFixture {
    let api: URL
    let origin: String
    let session: URLSession
    let stamp = "\(Int(Date().timeIntervalSince1970))_\(UUID().uuidString.prefix(8).lowercased())"
    /// The disposable account's password, new for every run.
    let password = "Conformance-\(UUID().uuidString)-a1"
    var token: String?

    /// `API_URL` is a local API to run against; `CONSOLE_ORIGIN` is the
    /// console origin that API accepts for account requests. Both must be
    /// loopback URLs.
    init() throws {
        let env = ProcessInfo.processInfo.environment
        guard let apiText = env["API_URL"], let api = URL(string: apiText), isLocalConformanceURL(api),
              ["http", "https"].contains(api.scheme ?? ""), api.query == nil, api.fragment == nil,
              let originText = env["CONSOLE_ORIGIN"], let origin = URL(string: originText), isLocalConformanceURL(origin) else {
            throw ConformanceFailure(message: "Set API_URL and CONSOLE_ORIGIN to loopback URLs, without credentials, query or fragment")
        }
        self.api = api; self.origin = origin.absoluteString
        token = env["CONFORMANCE_ACCESS_TOKEN"]
        let config = URLSessionConfiguration.ephemeral
        config.httpCookieStorage = nil
        config.protocolClasses = [RejectRemoteConformanceProtocol.self] + (config.protocolClasses ?? [])
        self.session = URLSession(configuration: config, delegate: ConformanceRedirectGuard(), delegateQueue: nil)
    }

    func call(_ method: String, _ path: String, _ body: JSONValue? = nil, authenticated: Bool = true) async throws -> JSONValue {
        let url = api.appendingPathComponent(String(path.dropFirst()))
        guard isLocalConformanceURL(url) else { throw ConformanceFailure(message: "Local URL required") }
        var request = URLRequest(url: url)
        request.httpMethod = method; request.timeoutInterval = 15; request.httpShouldHandleCookies = false
        request.setValue(origin, forHTTPHeaderField: "Origin")
        if authenticated, let token { request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") }
        if let body { request.httpBody = try JSONEncoder().encode(body); request.setValue("application/json", forHTTPHeaderField: "Content-Type") }
        let (bytes, response) = try await session.data(for: request)
        let http = try #require(response as? HTTPURLResponse)
        guard (200..<300).contains(http.statusCode) else { throw VaifError.from(status: http.statusCode, headers: [:], data: bytes) }
        return bytes.isEmpty ? .null : try JSONDecoder().decode(JSONValue.self, from: bytes)
    }

    func setup(_ definition: JSONValue, realtime: Bool) async throws -> ConformanceFixture {
        _ = try await call("GET", "/health", authenticated: false)
        if token == nil {
            let credentials: JSONValue = ["email": .string("sdk-conformance-\(stamp)@vaif-local.test"), "password": .string(password)]
            let account: JSONValue
            do { account = try await call("POST", "/auth/login", credentials, authenticated: false) }
            catch let error as VaifError where error.status == 401 {
                // A disposable account for this run; a 409 means it already exists.
                var signup = credentials.objectValue!; signup["name"] = "Local SDK conformance"
                do { account = try await call("POST", "/auth/signup", .object(signup), authenticated: false) }
                catch let conflict as VaifError where conflict.status == 409 {
                    account = try await call("POST", "/auth/login", credentials, authenticated: false)
                }
            }
            token = try #require(account["accessToken"]?.stringValue)
        }
        let orgs = try await call("GET", "/orgs")
        let org: JSONValue
        if let first = orgs.arrayValue?.first { org = first }
        else { org = try await call("POST", "/orgs", ["name": .string("SDK Swift \(stamp)")]) }
        let project = try await call("POST", "/projects", ["orgId": org["id"]!, "name": .string("SDK Swift \(stamp)")])
        let projectId = try #require(project["project"]?["id"]?.stringValue)
        let table = "sdk_notes_\(stamp)"
        let ownerRule = try #require(definition["table"]?["ownerRule"]?.stringValue)
        let columns = try #require(definition["table"]?["columns"]?.stringValue)
        guard ownerRule == "-- vaif:owner owner_id" else { throw ConformanceFailure(message: "Owner fixture required") }
        let pushed = try await call("POST", "/schema-engine/push/\(Transport.escape(projectId))", ["name": "conformance.sql", "sql": .string("\(ownerRule)\nCREATE TABLE \(table) (\(columns));")])
        guard pushed["ownerRules"]?["created"]?.arrayValue?.contains(.string(table)) == true else { throw ConformanceFailure(message: "Owner rule not installed") }
        if realtime { _ = try await call("POST", "/realtime/install", ["projectId": .string(projectId), "tables": [.string(table)]]) }
        let bucketName = "sdk-\(stamp.replacingOccurrences(of: "_", with: "-"))"
        let bucket = try await call("POST", "/storage/buckets", ["projectId": .string(projectId), "name": .string(bucketName), "public": false])
        let bucketId = try #require(bucket["bucket"]?["id"]?.stringValue)
        let anon = try #require(project["keys"]?["anon"]?.stringValue)
        let service = try #require(project["keys"]?["service_role"]?.stringValue)
        func make(_ key: String) throws -> VaifClient {
            try VaifClient(projectId: projectId, apiKey: key, baseURL: api, timeout: 15, retry: .none,
                           sessionStore: MemorySessionStore(), urlSession: session)
        }
        let console = try make(service)
        try await console.auth.setSession(accessToken: token!, refreshToken: nil)
        return ConformanceFixture(projectId: projectId, table: table, bucketId: bucketId, bucketName: bucketName,
                                  actors: ["alice": try make(anon), "bob": try make(anon), "service": try make(service), "console": console])
    }
}

extension SwiftConformance {
    @Test(.enabled(if: ProcessInfo.processInfo.environment["CONFORMANCE_LIVE"] == "1", "Live conformance needs a local VAIF API and CONFORMANCE_LIVE=1"))
    @MainActor func live() async throws {
        let cases = try SharedCases.load()
        let live = try LiveFixture()
        defer { live.session.invalidateAndCancel() }
        let env = ProcessInfo.processInfo.environment
        var fixtures: [String: ConformanceFixture] = [:]
        var passed = 0, failed = 0, skipped = 0
        for definition in cases.cases {
            if let required = definition.requires, env["CONFORMANCE_" + required.uppercased()] != "1" {
                print("SKIP \(definition.id): set CONFORMANCE_\(required.uppercased())=1")
                skipped += 1; continue
            }
            do {
                let name = try #require(definition.setup["fixture"]?.stringValue)
                let fixture: ConformanceFixture
                if let existing = fixtures[name] { fixture = existing }
                else {
                    fixture = try await live.setup(definition.setup, realtime: env["CONFORMANCE_REALTIME"] == "1")
                    fixtures[name] = fixture
                }
                let adapter = SharedAdapter(fixture: fixture, stamp: live.stamp, rotate: {
                    _ = try await live.call("POST", "/projects/\(Transport.escape(fixture.projectId))/settings/jwt/rotate")
                })
                try await adapter.run(definition)
                passed += 1; print("PASS \(definition.id)")
            } catch {
                // Never print request bodies, tokens, URLs or unfiltered API messages.
                let safe = (error as? VaifError).map { "\($0.status ?? 0) \($0.code ?? $0.kind.rawValue)" } ?? String(describing: type(of: error))
                failed += 1; print("FAIL \(definition.id): \(safe)")
            }
        }
        print("\(passed) passed, \(failed) failed, \(skipped) skipped")
        #expect(failed == 0, "Shared live conformance failed; see sanitized case results")
    }

    @Test func localGuardRefusesEgressAndCredentials() throws {
        for value in ["https://example.com", "http://localhost.evil.test", "http://user:pass@localhost", "file:///tmp/test"] {
            #expect(!isLocalConformanceURL(URL(string: value)!))
        }
        #expect(isLocalConformanceURL(URL(string: "http://127.0.0.1:3147")!))
        #expect(isLocalConformanceURL(URL(string: "ws://localhost:3147/realtime/ws")!))
    }
}
