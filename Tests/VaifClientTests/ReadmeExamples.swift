import Foundation
@testable import VaifClient

// The README's code, section by section, compiled with the tests so a renamed
// API breaks the build instead of the docs. Never called: it would need a
// live API.
private struct Todo: Codable, Sendable { let id: String; let title: String; let done: Bool }

@available(*, deprecated, message: "compile-only README examples")
private func readmeExamples(userId: String, listId: String, totpCode: String, totpOrBackupCode: String,
                            tokenFromEmail: String, callbackCode: String, pngData: Data, zipSize: Int) async throws {
    // Quick start
    let vaif = try VaifClient(projectId: "YOUR_PROJECT_ID", apiKey: "vk_pub_...")
    _ = try await vaif.auth.signIn(email: "ada@example.com", password: "a strong password")
    let todosPage = try await vaif.from("todos")
        .eq("done", false)
        .order("created_at", ascending: false)
        .limit(20)
        .list()
    print("\(todosPage.count) open todos")
    for todo in todosPage.data {
        print(todo["title"]?.stringValue ?? "")
    }

    // Client options
    _ = try VaifClient(
        projectId: "YOUR_PROJECT_ID",
        apiKey: "vk_pub_...",
        baseURL: URL(string: "https://api.vaif.studio")!,
        timeout: 15,
        retry: .default,
        headers: ["X-App-Version": "1.4.2"],
        sessionStore: nil,
        urlSession: .shared
    )
    _ = RetryPolicy(maxRetries: 3, baseDelay: 1, maxDelay: 30, multiplier: 2, retryOn: [429, 503], retryOnNetworkError: true)
    _ = RetryPolicy.none

    // Session storage
    _ = try VaifClient(projectId: "YOUR_PROJECT_ID", apiKey: "vk_pub_...",
                       sessionStore: MemorySessionStore())
    _ = try VaifClient(projectId: "YOUR_PROJECT_ID", apiKey: "vk_pub_...",
                       sessionStore: KeychainSessionStore(projectId: "YOUR_PROJECT_ID",
                                                          accessGroup: "TEAMID.com.example.shared"))
    _ = KeychainSessionStore(projectId: "YOUR_PROJECT_ID", useDataProtectionKeychain: true)
    _ = await vaif.auth.sessionStoreError

    // Session lifecycle
    Task {
        for await change in await vaif.auth.sessionChanges() {
            switch change.event {
            case .signedIn, .tokenRefreshed: print("signed in:", change.session?.user?.email ?? "")
            case .signedOut: print("signed out")
            }
        }
    }

    // Auth
    let created = try await vaif.auth.signUp(email: "ada@example.com", password: "a strong password",
                                             metadata: ["plan": "free"])
    if created.pendingVerification {
        print(created.message ?? "Check your email to verify the address.")
    }
    switch try await vaif.auth.signIn(email: "ada@example.com", password: "a strong password") {
    case .session(let session):
        print("signed in as", session.user?.email ?? "")
    case .mfaRequired(let challengeToken):
        try await vaif.auth.verifyMFA(challengeToken: challengeToken, code: totpCode)
    }
    _ = try await vaif.auth.getUser()
    try await vaif.auth.requestPasswordReset(email: "ada@example.com")
    try await vaif.auth.resetPassword(token: tokenFromEmail, newPassword: "a new strong password")
    try await vaif.auth.signOut()

    // MFA
    let enrollment = try await vaif.auth.enrollMFA()
    _ = (enrollment.secret, enrollment.otpauthUri)
    _ = try await vaif.auth.confirmMFA(enrollToken: enrollment.enrollToken, code: totpCode)
    _ = try await vaif.auth.regenerateMFACodes(code: totpCode)
    try await vaif.auth.disableMFA(code: totpOrBackupCode)

    // OAuth
    let start = try await vaif.auth.getOAuthSignInURL(provider: "google", redirectURL: "myapp://callback")
    _ = (start.url, start.state)
    let result: SignInResult = try await vaif.auth.exchangeOAuthCode(code: callbackCode, codeVerifier: start.codeVerifier)
    _ = result

    // Accounts and projects
    _ = VaifError(kind: .invalidArgument, message: "", code: "CONSOLE_ONLY").isConsoleOnly

    // Database
    let todos = vaif.from("todos")
    let page = try await todos
        .select("id", "title", "priority")
        .eq("owner_id", userId)
        .gte("priority", 2)
        .in("status", ["open", "blocked"])
        .order("priority", ascending: false)
        .limit(50)
        .list()
    print(page.count, page.data)
    _ = try await todos.eq("done", false).count()
    let second = try await todos.eq("done", false).paginate(page: 2, pageSize: 20)
    _ = (second.total, second.hasNext)
    _ = try await todos.range(from: 20, to: 39).list()
    _ = try await todos.ilike("title", "%milk%").list(as: Todo.self)
    _ = try await todos.get("ROW_ID", as: Todo.self)
    _ = try await todos.where(["OR": [
        ["field": "priority", "operator": "gte", "value": 3],
        ["field": "due_today", "value": true],
    ]]).list()

    // Writing rows
    _ = try await todos.insert(["title": "Buy milk"] as Row)
    _ = try await todos.insertMany([["title": "Buy eggs"], ["title": "Buy bread"]])
    _ = try await todos.upsert(["email": "ada@example.com", "name": "Ada"], onConflict: ["email"])
    _ = try await todos.update("ROW_ID", ["done": true] as Row)
    try await todos.delete("ROW_ID")
    _ = try await todos.eq("list_id", listId).updateMany(["archived": true])
    _ = try await todos.eq("done", true).lt("priority", 2).deleteMany()

    // Storage
    try await vaif.storage.upload("avatars/u1.png", data: pngData, contentType: "image/png")
    _ = try await vaif.storage.download("avatars/u1.png")
    _ = try await vaif.storage.createSignedURL("avatars/u1.png")
    _ = try await vaif.storage.createSignedUploadURL("exports/2026-10.zip", sizeBytes: zipSize,
                                                     contentType: "application/zip")
    let listing = try await vaif.storage.list(bucket: "avatars", prefix: "u1/", limit: 100)
    for file in listing.files { print(file.key, file.size) }
    try await vaif.storage.delete("avatars/u1.png", bucket: "avatars")

    // Functions
    let response = try await vaif.functions.invoke("send-email", body: ["to": "ada@example.com"])
    _ = try response.json()
    _ = response.text
    _ = try await vaif.functions.invoke("report", method: "GET", path: "/daily", query: ["day": "mon"])
    _ = try await vaif.functions.invoke("report", method: "GET", idempotent: true)

    // Realtime
    let subscription = try await vaif.realtime.subscribe(
        table: "todos",
        filters: [.eq("owner_id", userId)],
        columns: ["id", "title", "done"]
    )
    do {
        for try await event in subscription.events {
            switch event.operation {
            case "DELETE": print("deleted", event.oldRecord ?? [:])
            default: print(event.operation, event.record ?? [:])
            }
        }
    } catch {
        // The socket closed or the session ended. Subscribe again to resume.
    }
    await subscription.unsubscribe()

    // Generated API operations
    _ = try await vaif.operations.getProjectsByProjectId(path: ["projectId": "YOUR_PROJECT_ID"])
    _ = try await vaif.operations.getV1DataByProjectIdByTable(
        path: ["projectId": "YOUR_PROJECT_ID", "table": "todos"], query: ["limit": 20])
    _ = OperationsClient.generatedCount
    _ = OperationsClient.ungenerated

    // Error handling
    do {
        _ = try await vaif.from("todos").get("ROW_ID")
    } catch let error as VaifError {
        switch error.kind {
        case .notFound:
            print("no such row")
        case .rateLimited:
            print("retry after", error.retryAfter ?? 1, "seconds")
        default:
            print(error.kind, error.status ?? 0, error.code ?? "", error.message, error.requestId ?? "")
        }
        _ = (error.details, error.body)
    }
}
