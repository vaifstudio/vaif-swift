import Foundation
import Testing
@testable import VaifClient

/// A string shared between a test and its stub.
final class LockedText: @unchecked Sendable {
    private let lock = NSLock()
    private var text: String
    init(_ text: String) { self.text = text }
    var value: String {
        get { lock.lock(); defer { lock.unlock() }; return text }
        set { lock.lock(); text = newValue; lock.unlock() }
    }
}

@Suite struct StorageFunctionsTests {
    @Test func uploadMintsThenPutsWithoutCredentials() async throws {
        let objects = Stub { _, i in i == 0 ? .status(503) : .status(200) } // PUT retried once
        let api = Stub { _, _ in .json(200, ["ok": true, "url": .string("https://\(objects.host)/bucket/dev/a.png?X-Amz-Signature=x")]) }
        let client = try makeClient(api)
        try await client.auth.setSession(accessToken: "at_user", refreshToken: "rt")
        let result = try await client.storage.upload("avatars/u1.png", data: Data("\u{89}PNG".utf8), contentType: "image/png", bucket: "media")
        let mint = api.last
        #expect(mint.path == "/storage/upload-url")
        #expect(mint.header("Authorization") == "Bearer at_user")
        #expect(mint.json == ["key": "avatars/u1.png", "bucket": "media", "sizeBytes": .integer(Data("\u{89}PNG".utf8).count), "contentType": "image/png"])
        #expect(objects.count == 2)
        let put = objects.last
        #expect(put.method == "PUT")
        #expect(put.body == Data("\u{89}PNG".utf8))
        #expect(put.header("Content-Type") == "image/png")
        #expect(put.header("x-vaif-key") == nil)
        #expect(put.header("Authorization") == nil)
        #expect(result == UploadResult(key: "avatars/u1.png", bucket: "media", size: Data("\u{89}PNG".utf8).count))
    }

    @Test func uploadMintIsNotRetriedAndKeysAreValidated() async throws {
        let api = Stub { _, _ in .status(503) }
        let client = try makeClient(api)
        #expect(await vaifError { try await client.storage.upload("a.txt", data: Data("x".utf8)) }?.kind == .server)
        #expect(api.count == 1)
        for key in ["", "/abs", "a/../b", "bad\u{0}key"] {
            #expect(await vaifError { try await client.storage.upload(key, data: Data("x".utf8)) }?.kind == .invalidArgument)
        }
        #expect(api.count == 1)
    }

    /// `download` mints a link and reads it itself, so neither the API key
    /// nor the access token reaches the object store.
    @Test func downloadReadsTheSignedLinkWithoutCredentials() async throws {
        let objects = Stub { request, i in
            if request.path.hasSuffix("/missing.txt") {
                return Reply(status: 404, headers: ["Content-Type": "application/xml"], body: Data("<Error><Code>NoSuchKey</Code></Error>".utf8))
            }
            return i == 0 ? .status(503) : Reply(status: 200, body: Data("file-bytes".utf8)) // the GET is retried
        }
        let api = Stub { request, _ in
            let key = request.json?["key"]?.stringValue ?? ""
            return .json(200, ["ok": true, "url": .string("https://\(objects.host)/bucket/\(key)?X-Amz-Signature=sig"), "expiresIn": 600])
        }
        let client = try makeClient(api)
        try await client.auth.setSession(accessToken: "at_user", refreshToken: "rt")
        #expect(try await client.storage.download("a.txt", bucket: "media") == Data("file-bytes".utf8))
        let mint = api.last
        #expect(mint.method == "POST")
        #expect(mint.path == "/storage/download-url")
        #expect(mint.json == ["key": "a.txt", "bucket": "media"])
        #expect(mint.header("Authorization") == "Bearer at_user")
        #expect(objects.count == 2)
        let read = try #require(objects.requests.last)
        #expect(read.method == "GET")
        #expect(read.url.absoluteString == "https://\(objects.host)/bucket/a.txt?X-Amz-Signature=sig")
        #expect(read.header("x-vaif-key") == nil)
        #expect(read.header("Authorization") == nil)
        #expect(await vaifError { _ = try await client.storage.download("missing.txt") }?.kind == .notFound)
    }

    @Test func signedURL() async throws {
        let api = Stub { _, i in i == 0 ? .status(503) : .json(200, ["ok": true, "url": "https://s3/get?sig"]) }
        let client = try makeClient(api)
        let url = try await client.storage.createSignedURL("a.txt", bucket: "media")
        #expect(url == "https://s3/get?sig")
        #expect(api.count == 2) // the 503 on the mint was retried
        #expect(api.last.path == "/storage/download-url")
        #expect(api.last.json == ["key": "a.txt", "bucket": "media"])
    }

    /// Signed and upload URLs must be https (http only to the loopback hosts).
    @Test func storageURLsMustBeHTTPS() async throws {
        let objects = Stub { _, _ in .status(200) }
        let minted = LockedText("http://\(objects.host)/bucket/a.txt?sig=1")
        let api = Stub { _, _ in .json(200, ["ok": true, "url": .string(minted.value)]) }
        let client = try makeClient(api)
        for insecure in ["http://\(objects.host)/bucket/a.txt?sig=1", "ftp://\(objects.host)/a.txt", "file:///etc/hosts", "/relative/a.txt"] {
            minted.value = insecure
            let upload = await vaifError { try await client.storage.upload("a.txt", data: Data("x".utf8)) }
            #expect(upload?.code == "INSECURE_STORAGE_URL")
            #expect(upload?.kind == .badResponse)
            #expect(await vaifError { _ = try await client.storage.download("a.txt") }?.code == "INSECURE_STORAGE_URL")
            #expect(await vaifError { _ = try await client.storage.createSignedURL("a.txt") }?.code == "INSECURE_STORAGE_URL")
            #expect(await vaifError { _ = try await client.storage.createSignedUploadURL("a.txt", sizeBytes: 1) }?.code == "INSECURE_STORAGE_URL")
        }
        #expect(objects.count == 0) // nothing was sent to an insecure URL
        for loopback in ["http://127.0.0.1:9000/bucket/a.txt?sig=1", "http://localhost:9000/a.txt", "http://[::1]:9000/a.txt"] {
            minted.value = loopback
            #expect(try await client.storage.createSignedURL("a.txt") == loopback)
        }
    }

    @Test func signedUploadURLRequiresSizeAndSendsType() async throws {
        let api = Stub { _, _ in .json(200, ["ok": true, "url": "https://s3/put?sig"]) }
        let client = try makeClient(api)
        #expect(try await client.storage.createSignedUploadURL("a.txt", sizeBytes: 10) == "https://s3/put?sig")
        #expect(api.last.json == ["key": "a.txt", "sizeBytes": 10])
        _ = try await client.storage.createSignedUploadURL("b.txt", sizeBytes: 3, contentType: "text/plain", bucket: "docs")
        #expect(api.last.json == ["key": "b.txt", "bucket": "docs", "sizeBytes": 3, "contentType": "text/plain"])
        for size in [0, 5_368_709_121] {
            #expect(await vaifError { _ = try await client.storage.createSignedUploadURL("c.txt", sizeBytes: size) }?.kind == .invalidArgument)
        }
        #expect(api.count == 2)
    }

    /// 5 GiB does not fit the 32-bit Int of an Apple Watch (arm64_32), so the
    /// limit is an Int64 and the package compiles there.
    @Test func theObjectSizeLimitIsFiveGiBOnEveryPlatform() {
        #expect(StorageClient.maxObjectBytes == 5_368_709_120)
        #expect(type(of: StorageClient.maxObjectBytes) == Int64.self)
    }

    @Test func invokeSendsEnvelope() async throws {
        let api = Stub { _, _ in .json(200, ["sent": true], headers: ["X-Fn": "1"]) }
        let client = try makeClient(api)
        let response = try await client.functions.invoke("send-email", body: ["to": "a@b.c", "path": "not-routing"])
        #expect(api.last.path == "/functions/send-email/invoke")
        #expect(api.last.json == ["method": "POST", "path": "/", "body": ["to": "a@b.c", "path": "not-routing"]])
        #expect(response.status == 200)
        #expect(try response.json()["sent"] == true)
        _ = try await client.functions.invoke("report", method: "get", path: "/daily", query: ["day": "mon"], headers: ["X-T": "1"])
        #expect(api.last.json == ["method": "GET", "path": "/daily", "query": ["day": "mon"], "headers": ["X-T": "1"]])
    }

    @Test func invokeErrorsAndRetries() async throws {
        let api = Stub { request, i in
            if request.path.contains("/flaky/") { return i == 1 ? .status(502) : .json(200, ["ok": 1]) }
            return .json(400, ["error": "ValidationError", "message": "bad input", "field": "to"])
        }
        let client = try makeClient(api)
        let error = await vaifError { _ = try await client.functions.invoke("f", body: [:]) }
        #expect(error?.kind == .validation)
        #expect(error?.body?["field"] == "to")
        #expect(api.count == 1)
        let ok = try await client.functions.invoke("flaky", idempotent: true)
        #expect(try ok.json()["ok"] == 1)
        #expect(api.count == 3)
        #expect(await vaifError { _ = try await client.functions.invoke("f", method: "TRACE") }?.kind == .invalidArgument)
        #expect(await vaifError { _ = try await client.functions.invoke("f", path: "no-slash") }?.kind == .invalidArgument)
        #expect(await vaifError { _ = try await client.functions.invoke("") }?.kind == .invalidArgument)
    }
}

/// Every error the SDK throws is a `VaifError`, including a function
/// response that is not the JSON the caller asked for.
@Suite struct FunctionResponseTests {
    @Test func anUndecodableResponseOrBodyIsAVaifError() async throws {
        struct Greeting: Decodable { let message: String }
        struct Reading: Encodable { let value: Double }
        let api = Stub { _, _ in Reply(status: 200, headers: ["Content-Type": "text/plain"], body: Data("plain text".utf8)) }
        let client = try makeClient(api)
        let response = try await client.functions.invoke("hello")
        #expect(response.text == "plain text")
        let json = await vaifError { _ = try response.json() }
        #expect(json?.kind == .badResponse)
        #expect(json?.status == 200)
        let typed = await vaifError { _ = try response.decode(Greeting.self) }
        #expect(typed?.kind == .badResponse)
        #expect(typed?.status == 200)
        let unencodable = await vaifError { _ = try await client.functions.invoke("hello", encoding: Reading(value: .nan)) }
        #expect(unencodable?.kind == .invalidArgument)
        #expect(api.count == 1) // refused before sending
    }
}

/// Only the API's own 401 refreshes the session and resends; a function's
/// 401, relayed by the invoke route, is returned as it is.
@Suite struct FunctionUnauthorizedTests {
    @Test func aFunctionsOwn401IsThrownWithoutRefreshingOrRunningItAgain() async throws {
        let api = Stub { request, _ in
            if request.path.hasSuffix("/auth/refresh") { return loginReply("at_new", "rt_2") }
            return .json(401, ["error": "UNAUTHORIZED", "message": "wrong webhook signature"],
                         headers: ["X-Vaif-Run-Id": "run_7f3a", "X-Vaif-Run-Duration-Ms": "12"])
        }
        let client = try makeClient(api)
        try await client.auth.setSession(accessToken: "at_1", refreshToken: "rt_1")
        let error = await vaifError { _ = try await client.functions.invoke("verify-webhook", body: ["sig": "x"]) }
        #expect(error?.status == 401)
        #expect(error?.message == "wrong webhook signature")
        #expect(error?.header("x-vaif-run-id") == "run_7f3a")
        // Without this check, the SDK would refresh (rotating rt_1) and run the function a second time.
        #expect(api.requests.map(\.path) == ["/functions/verify-webhook/invoke"])
        #expect(await client.auth.session?.accessToken == "at_1")
        #expect(await client.auth.session?.refreshToken == "rt_1")
    }

    @Test func theAPIsOwn401OnAnInvocationRefreshesAndSendsItOnce() async throws {
        let api = Stub { request, _ in
            if request.path.hasSuffix("/auth/refresh") { return loginReply("at_new", "rt_2") }
            if request.header("Authorization") == "Bearer at_1" {
                return .json(401, ["error": "UNAUTHORIZED", "message": "Invalid or expired token"])
            }
            return .json(200, ["ok": true], headers: ["X-Vaif-Run-Id": "run_8b2c"])
        }
        let client = try makeClient(api)
        try await client.auth.setSession(accessToken: "at_1", refreshToken: "rt_1")
        let response = try await client.functions.invoke("report")
        #expect(response.status == 200)
        #expect(api.requests.map(\.path) == ["/functions/report/invoke", "/projects/proj_123/auth/refresh", "/functions/report/invoke"])
        #expect(api.last.header("Authorization") == "Bearer at_new")
    }
}
