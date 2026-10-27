import Foundation
import Testing
@testable import VaifClient

@Suite struct StorageListTests {
    static let bucketUUID = "0f8fad5b-d9cb-469f-a165-70867728950e"

    @Test func listAndDeleteResolveTheBucketNameOnceAndSendTheKeyInTheQuery() async throws {
        let stub = Stub { request, _ in
            if request.path == "/storage/buckets" {
                return .json(200, ["ok": true, "buckets": [["id": .string(Self.bucketUUID), "name": "default"], ["id": "other", "name": "avatars"]]])
            }
            if request.method == "DELETE" { return .json(200, ["ok": true, "deleted": true]) }
            return .json(200, ["files": [["key": "a/b.txt", "size": 4, "lastModified": "2026-10-26"]], "folders": ["a/"], "nextToken": "next", "isTruncated": true])
        }
        let storage = try makeClient(stub).storage
        let result = try await storage.list(prefix: "a/", limit: 3, cursor: "cursor+")
        #expect(stub.requests.first?.path == "/storage/buckets" && stub.requests.first?.query("projectId") == testProject)
        #expect(stub.last.rawPath == "/buckets/\(Self.bucketUUID)/files")
        #expect(stub.last.query("maxKeys") == "3" && stub.last.query("prefix") == "a/" && stub.last.query("continuationToken") == "cursor+")
        #expect(result.files.first?.key == "a/b.txt" && result.prefixes == ["a/"] && result.nextCursor == "next" && result.hasMore)
        try await storage.delete("a/b c.txt")
        #expect(stub.last.method == "DELETE" && stub.last.rawPath == "/buckets/\(Self.bucketUUID)/files")
        #expect(stub.last.query("key") == "a/b c.txt")
        #expect(stub.count == 3) // the name was looked up once
    }

    @Test func aBucketUUIDSkipsTheLookupAndUnknownNamesAreNotFound() async throws {
        let stub = Stub { request, _ in
            request.path == "/storage/buckets" ? .json(200, ["ok": true, "buckets": []]) : .json(200, ["files": []])
        }
        let storage = try makeClient(stub).storage
        _ = try await storage.list(bucket: Self.bucketUUID)
        #expect(stub.count == 1 && stub.last.path == "/buckets/\(Self.bucketUUID)/files")
        #expect(await vaifError { _ = try await storage.list(bucket: "missing") }?.code == "BUCKET_NOT_FOUND")
        #expect(await vaifError { _ = try await storage.list(limit: 0) }?.kind == .invalidArgument)
        #expect(await vaifError { try await storage.delete("../etc", bucket: Self.bucketUUID) }?.kind == .invalidArgument)
    }

    /// An object over 2 GiB has a size that does not fit the 32-bit `Int` of
    /// an Apple Watch (arm64_32), so `StorageFile.size` is an `Int64` and a
    /// listing with a 5 GiB object decodes there.
    @Test func aListingDecodesAFiveGiBObjectSizeAsInt64() async throws {
        let stub = Stub { _, _ in
            .json(200, ["files": [["key": "big.bin", "size": 5368709120]], "folders": [], "isTruncated": false])
        }
        let listing = try await makeClient(stub).storage.list(bucket: Self.bucketUUID)
        let file = try #require(listing.files.first)
        #expect(file.key == "big.bin")
        #expect(type(of: file.size) == Int64.self)
        #expect(file.size == Int64(5_368_709_120))
    }

    @Test func aPlatformClientNeedsABucketUUID() async throws {
        let stub = Stub { _, _ in .json(200, ["files": []]) }
        let storage = try VaifClient(apiKey: testKey, baseURL: stub.baseURL, sessionStore: MemorySessionStore(),
                                     urlSession: MockURLProtocol.session).storage
        #expect(await vaifError { _ = try await storage.list(bucket: "default") }?.code == "PROJECT_ID_REQUIRED")
        #expect(stub.count == 0)
        _ = try await storage.list(bucket: Self.bucketUUID)
        #expect(stub.count == 1)
    }
}
