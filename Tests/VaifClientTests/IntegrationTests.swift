import Foundation
import Testing
@testable import VaifClient

/// End-to-end run against a real VAIF API. Skipped unless VAIF_IT_BASE_URL,
/// VAIF_IT_PROJECT_ID and VAIF_IT_API_KEY are set (use a throwaway project);
/// VAIF_IT_TABLE names a table with a text column "name" (default sdk_items).
private enum IT {
    static let env = ProcessInfo.processInfo.environment
    static var enabled: Bool {
        ["VAIF_IT_BASE_URL", "VAIF_IT_PROJECT_ID", "VAIF_IT_API_KEY"].allSatisfy { !(env[$0] ?? "").isEmpty }
    }
    static var table: String { env["VAIF_IT_TABLE"].flatMap { $0.isEmpty ? nil : $0 } ?? "sdk_items" }

    static func client() throws -> VaifClient {
        try VaifClient(projectId: env["VAIF_IT_PROJECT_ID"]!, apiKey: env["VAIF_IT_API_KEY"]!,
                       baseURL: URL(string: env["VAIF_IT_BASE_URL"]!)!, timeout: 20, sessionStore: MemorySessionStore())
    }

    static func token() -> String { UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased() }
}

@Suite(.enabled(if: IT.enabled, "VAIF_IT_* environment not set"), .serialized)
struct IntegrationTests {
    @Test func authLifecycle() async throws {
        let vaif = try IT.client()
        let email = "swift-\(IT.token().prefix(10))@example.com"
        let password = "Pw-\(IT.token())"

        let up = try await vaif.auth.signUp(email: email, password: password, metadata: ["sdk": "swift"])
        #expect(up.session?.refreshToken?.isEmpty == false)
        try await vaif.auth.signOut()
        #expect(await vaif.auth.session == nil)

        #expect(await vaifError { _ = try await vaif.auth.signIn(email: email, password: password + "-wrong") }?.kind == .auth)
        guard case .session = try await vaif.auth.signIn(email: email, password: password) else {
            Issue.record("expected a session"); return
        }
        let me = try await vaif.auth.getUser()
        #expect(me.email == email)

        let first = try #require(await vaif.auth.session)
        let refreshed = try await vaif.auth.refreshSession()
        #expect(refreshed.refreshToken != nil && refreshed.refreshToken != first.refreshToken)
        #expect(try await vaif.auth.getUser().id == me.id)

        try await vaif.auth.signOut()
        try await vaif.auth.setSession(accessToken: refreshed.accessToken, refreshToken: refreshed.refreshToken)
        #expect(await vaifError { try await vaif.auth.refreshSession() }?.kind == .auth)
    }

    @Test func dataCRUDFiltersAndPagination() async throws {
        let vaif = try IT.client()
        let marker = String(IT.token().prefix(8))
        let table = vaif.from(IT.table)

        let created = try await table.insert(["name": .string("\(marker)-a")] as Row)
        #expect(created["name"]?.stringValue == "\(marker)-a")
        let id = try #require(created["id"]?.stringValue)
        let more = try await table.insertMany([["name": .string("\(marker)-b")], ["name": .string("\(marker)-c")]])
        #expect(more.count == 2)
        #expect(try await table.get(id)["id"]?.stringValue == id)

        let mine = table.like("name", "\(marker)-%")
        let listed = try await mine.order("name").list()
        #expect(listed.count == 3)
        #expect(listed.data.map { $0["name"]?.stringValue } == ["\(marker)-a", "\(marker)-b", "\(marker)-c"])

        let page = try await mine.order("name").paginate(page: 2, pageSize: 2)
        #expect(page.total == 3 && page.data.count == 1 && !page.hasNext)

        let only = try await mine.eq("name", "\(marker)-b").select("id", "name").list()
        #expect(only.count == 1 && only.data.first?.count == 2)

        let updated = try await table.update(id, ["name": .string("\(marker)-z")] as Row)
        #expect(updated["name"]?.stringValue == "\(marker)-z")

        for row in more + [created] {
            try await table.delete(try #require(row["id"]?.stringValue))
        }
        #expect(await vaifError { _ = try await table.get(id) }?.kind == .notFound)
        #expect(await vaifError { _ = try await table.eq("no_such_column", 1).list() }?.code == "INVALID_COLUMN")
    }

    @Test func storageRoundTrip() async throws {
        let vaif = try IT.client()
        let key = "sdk-it/swift-\(IT.token()).txt"
        let payload = Data("hello from the swift sdk".utf8)
        try await vaif.storage.upload(key, data: payload, contentType: "text/plain")
        #expect(try await vaif.storage.download(key) == payload)
        #expect(try await vaif.storage.createSignedURL(key).hasPrefix("http"))
        #expect(await vaifError { _ = try await vaif.storage.download("sdk-it/missing-\(IT.token()).txt") }?.kind == .notFound)
    }

    @Test func unknownFunctionIsNotFound() async throws {
        let vaif = try IT.client()
        #expect(await vaifError { _ = try await vaif.functions.invoke("missing-\(IT.token().prefix(8))", body: ["x": 1]) }?.kind == .notFound)
    }
}
