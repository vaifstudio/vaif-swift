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
        // 943 operations in the API's OpenAPI document: 801 generated, 142 not.
        #expect(OperationsClient.all.count == OperationsClient.generatedCount)
        #expect(OperationsClient.generatedCount == 801)
        #expect(OperationsClient.ungenerated.count == 142)
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

    /// True for /admin and /auth/impersonate and the paths under them.
    private static func isStaffOnly(_ path: String) -> Bool {
        path.range(of: #"^/(admin|auth/impersonate)(/|$)"#, options: .regularExpression) != nil
    }

    @Test func noMethodCallsAPlatformStaffRoute() throws {
        for (name, op) in OperationsClient.all {
            #expect(!Self.isStaffOnly(op.path), "\(name) calls \(op.method) \(op.path)")
        }
        let staff = OperationsClient.ungenerated.filter { $0.value == "platform staff only" }
        #expect(staff.count == 108)
        for (route, reason) in OperationsClient.ungenerated {
            let path = String(route.split(separator: " ", maxSplits: 1)[1])
            #expect(Self.isStaffOnly(path) == (reason == "platform staff only"), "\(route): \(reason)")
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
