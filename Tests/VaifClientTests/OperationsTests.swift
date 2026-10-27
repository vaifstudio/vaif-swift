import Foundation
import Testing
@testable import VaifClient

@Suite struct OperationsTests {
    @Test func platformSignupAndResetOperationsFailBeforeAnyRequest() async throws {
        let stub = Stub { _, _ in .json(200, ["ok": true]) }
        let client = try makeClient(stub)
        let signup = await vaifError { _ = try await client.operations.postAuthSignup(body: ["email": "a@b.c", "password": "pw"]) }
        let reset = await vaifError { _ = try await client.operations.postAuthForgotPassword(body: ["email": "a@b.c"]) }
        #expect(signup?.isConsoleOnly == true && reset?.isConsoleOnly == true)
        #expect(signup?.message.hasSuffix("To sign up users of your own app, call postProjectsByProjectIdAuthSignup.") == true)
        #expect(reset?.message.hasSuffix("To reset passwords for users of your own app, call postProjectsByProjectIdAuthForgotPassword.") == true)
        #expect(stub.count == 0)
        _ = try await client.operations.postProjectsByProjectIdAuthSignup(path: ["projectId": "p1"], body: ["email": "a@b.c", "password": "pw"])
        #expect(stub.last.path == "/projects/p1/auth/signup")
    }

    @Test func pathsAreEscapedAndCredentialsAttached() async throws {
        let stub = Stub { request, _ in
            if request.path == "/storage/download" { return Reply(body: Data([0, 1, 255])) }
            return .json(200, ["ok": true])
        }
        let client = try makeClient(stub)
        try await client.auth.setSession(accessToken: "user", refreshToken: nil)
        _ = try await client.operations.getProjectsByProjectId(path: ["projectId": "p/q +"])
        #expect(stub.last.rawPath == "/projects/p%2Fq%20%2B")
        #expect(stub.last.header("x-vaif-key") == testKey && stub.last.header("Authorization") == "Bearer user")
        let binary = try await client.operations.getStorageDownload(query: ["key": "a+b/c"])
        #expect(binary.data == Data([0, 1, 255]))
        #expect(stub.last.query("key") == "a+b/c")
    }

    @Test func missingArgumentsAndDotSegmentsAreRefusedLocally() async throws {
        let stub = Stub { _, _ in .json(200, ["ok": true]) }
        let ops = try makeClient(stub).operations
        #expect(await vaifError { _ = try await ops.getProjectsByProjectId(path: [:]) }?.kind == .invalidArgument)
        #expect(await vaifError { _ = try await ops.getProjectsByProjectId(path: ["projectId": ".."]) }?.kind == .invalidArgument)
        #expect(await vaifError { _ = try await ops.getStorageDownload() }?.kind == .invalidArgument)
        #expect(await vaifError { _ = try await ops.getStorageDownload(query: ["key": ["nested": ["deep": 1]]]) }?.kind == .invalidArgument)
        #expect(stub.count == 0)
    }

    @Test func queryValuesFlattenLikeTheOtherSDKs() throws {
        let items = try OperationsClient.queryItems(["b": [1, 2], "a": ["x": "1", "y": nil], "c": true, "d": nil, "e": 1.5])
        #expect(items.map { "\($0.name)=\($0.value ?? "")" } == ["a[x]=1", "b=1", "b=2", "c=true", "e=1.5"])
    }

    @Test func theTableIsCompleteAndConsistent() {
        // 943 operations in the API's OpenAPI document: 775 generated, 168 not.
        #expect(OperationsClient.all.count == OperationsClient.generatedCount)
        #expect(OperationsClient.generatedCount == 775)
        #expect(OperationsClient.ungenerated.count == 168)
        for (name, op) in OperationsClient.all {
            #expect(name.hasPrefix(op.method.lowercased()), "\(name)")
            let placeholders = op.path.split(separator: "{").dropFirst().compactMap { $0.split(separator: "}").first.map(String.init) }
            #expect(Set(placeholders) == Set(op.pathParameters) && placeholders.count == op.pathParameters.count, "\(name)")
            #expect(["json", "binary", "text", "none"].contains(op.bodyKind) && ["json", "sse", "binary"].contains(op.transport), "\(name)")
            #expect(op.bodyKind != "none" || !op.bodyRequired, "\(name)")
            #expect(OperationsClient.ungenerated["\(op.method) \(op.path)"] == nil, "\(name)")
        }
        #expect(OperationsClient.all["postAuthSignup"]?.path == "/auth/signup")
        #expect(OperationsClient.all["postAuthForgotPassword"]?.path == "/auth/forgot-password")
    }

    @Test func staffOnlyOperationsOutsideAdminHaveNoMethod() throws {
        #expect(OperationsClient.all["postFlags"] == nil)
        #expect(OperationsClient.all["postEnterpriseInvoicesByInvoiceIdPaid"] == nil)
        #expect(OperationsClient.ungenerated["POST /flags"] == "platform staff only")
        #expect(OperationsClient.ungenerated["POST /enterprise/invoices/{invoiceId}/paid"] == "platform staff only")
        // The methods themselves: no declaration of either name in the sources.
        let generated = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
            .appendingPathComponent("Sources/VaifClient/Generated/GeneratedOperations.swift")
        let text = try String(contentsOf: generated, encoding: .utf8)
        #expect(!text.contains("func postFlags("))
        #expect(!text.contains("func postEnterpriseInvoicesByInvoiceIdPaid("))
    }

    /// True for /admin and /auth/impersonate and the paths under them.
    private static func isStaffOnlyPath(_ path: String) -> Bool {
        path.range(of: #"^/(admin|auth/impersonate)(/|$)"#, options: .regularExpression) != nil
    }

    /// The platform-staff operations outside those paths. The API answers
    /// each only for VAIF platform staff, so the package has no method for them.
    private static let staffOnlyOutsideAdmin: Set<String> = [
        "DELETE /docs/api-endpoints/{id}",
        "DELETE /docs/changelog/{id}",
        "DELETE /docs/examples/{id}",
        "DELETE /docs/sdk-examples/{id}",
        "DELETE /docs/sdks/{id}",
        "DELETE /docs/v2/pages/{id}",
        "DELETE /flags/{key}",
        "GET /ai/copilot/stats",
        "GET /flags",
        "PATCH /docs/api-endpoints/{id}",
        "PATCH /docs/changelog/{id}",
        "PATCH /docs/examples/{id}",
        "PATCH /docs/sdks/{id}",
        "PATCH /docs/v2/pages/{id}",
        "POST /docs/api-endpoints",
        "POST /docs/changelog",
        "POST /docs/examples",
        "POST /docs/sdk-examples",
        "POST /docs/sdks",
        "POST /docs/v2/pages",
        "POST /enterprise/contracts",
        "POST /enterprise/contracts/{contractId}/invoice",
        "POST /enterprise/invoices/{invoiceId}/paid",
        "POST /enterprise/invoices/{invoiceId}/send",
        "POST /flags",
        "PUT /flags/{key}",
    ]

    private static func isStaffOnly(_ method: String, _ path: String) -> Bool {
        isStaffOnlyPath(path) || staffOnlyOutsideAdmin.contains("\(method) \(path)")
    }

    @Test func noMethodCallsAPlatformStaffRoute() throws {
        #expect(Self.staffOnlyOutsideAdmin.count == 26)
        for (name, op) in OperationsClient.all {
            #expect(!Self.isStaffOnly(op.method, op.path), "\(name) calls \(op.method) \(op.path)")
        }
        let staff = OperationsClient.ungenerated.filter { $0.value == "platform staff only" }
        #expect(staff.count == 134)
        for (route, reason) in OperationsClient.ungenerated {
            let parts = route.split(separator: " ", maxSplits: 1).map(String.init)
            #expect(Self.isStaffOnly(parts[0], parts[1]) == (reason == "platform staff only"), "\(route): \(reason)")
        }
        #expect(OperationsClient.ungenerated["POST /auth/impersonate/token"] == "platform staff only")
        #expect(OperationsClient.ungenerated["POST /admin/admins"] == "platform staff only")

        // No source file names a staff route except in the list of operations
        // without a generated method.
        let sources = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
            .appendingPathComponent("Sources/VaifClient")
        let files = try #require(FileManager.default.enumerator(at: sources, includingPropertiesForKeys: nil))
            .compactMap { $0 as? URL }
            .filter { $0.pathExtension == "swift" }
        #expect(files.count > 10)
        let named = #"["\s]/(admin|auth/impersonate)([/"{.\s]|$)"#
        let listed = #"^        "[A-Z]+ [^"]+": "platform staff only",$"#
        for file in files {
            let text = try String(contentsOf: file, encoding: .utf8)
            for (index, line) in text.components(separatedBy: "\n").enumerated()
            where line.range(of: named, options: .regularExpression) != nil
                && line.range(of: listed, options: .regularExpression) == nil {
                Issue.record("\(file.lastPathComponent):\(index + 1) names a platform-staff route: \(line)")
            }
        }
    }
}
