import Foundation

/// Upload, download and sign URLs for the project's objects.
///
/// `bucket` is optional everywhere; without it the project's default bucket is
/// used. Keys are relative paths such as `"avatars/u1.png"`.
public struct StorageClient: Sendable {
    /// Largest single-part object a presigned PUT accepts: 5 GiB. An `Int64`,
    /// because the value does not fit the 32-bit `Int` of an Apple Watch.
    public static let maxObjectBytes: Int64 = 5 * 1024 * 1024 * 1024

    let transport: Transport
    let auth: AuthClient
    let projectId: String?
    private let bucketIds = BucketIdCache()

    init(transport: Transport, auth: AuthClient, projectId: String? = nil) {
        self.transport = transport
        self.auth = auth
        self.projectId = projectId
    }

    static func check(key: String) throws {
        guard !key.isEmpty else { throw VaifError.invalidArgument("key must not be empty") }
        guard !key.hasPrefix("/") else { throw VaifError.invalidArgument("key must be relative") }
        guard !key.split(separator: "/", omittingEmptySubsequences: false).contains("..") else {
            throw VaifError.invalidArgument("key must not contain '..' segments")
        }
        guard !key.unicodeScalars.contains(where: { $0.value < 32 }) else {
            throw VaifError.invalidArgument("key must not contain control characters")
        }
    }

    private func target(_ key: String, _ bucket: String?) throws -> [String: JSONValue] {
        try Self.check(key: key)
        var body: [String: JSONValue] = ["key": .string(key)]
        if let bucket, !bucket.isEmpty { body["bucket"] = .string(bucket) }
        return body
    }

    private struct URLPayload: Decodable { let url: String? }

    /// Mints a signed URL. Only an https URL (http only to `localhost`,
    /// `127.0.0.1` or `::1`) is accepted: object bytes and the signature in
    /// the URL never travel unencrypted.
    private func mint(_ path: String, _ body: [String: JSONValue], idempotent: Bool) async throws -> String {
        var request = try HTTPRequest.json("POST", path, body)
        request.idempotent = idempotent
        let response = try await sendAuthorized(request, transport: transport, auth: auth)
        guard let url = try response.decode(URLPayload.self).url, !url.isEmpty else {
            throw VaifError(kind: .badResponse, message: "the response did not include a URL", status: response.status)
        }
        guard let parsed = URL(string: url), parsed.host != nil, Transport.isSecure(parsed) else {
            throw VaifError(kind: .badResponse,
                            message: "the API returned a storage URL that is not https (http is accepted only for localhost)",
                            status: response.status, code: "INSECURE_STORAGE_URL")
        }
        return url
    }

    /// A time-limited download URL, valid for the project's signed URL
    /// lifetime (10 minutes by default).
    public func createSignedURL(_ key: String, bucket: String? = nil) async throws -> String {
        // Minting a download URL has no side effects, so it may be retried.
        try await mint("/storage/download-url", try target(key, bucket), idempotent: true)
    }

    /// A time-limited URL that accepts an HTTP PUT of the object's bytes.
    ///
    /// The URL is signed for exactly `sizeBytes` bytes and, when `contentType`
    /// is given, exactly that `Content-Type`: the PUT must send both as signed
    /// or the object store refuses it. The API checks the size against the
    /// bucket's and project's limits and the storage quota, and meters it.
    public func createSignedUploadURL(_ key: String, sizeBytes: Int, contentType: String? = nil, bucket: String? = nil) async throws -> String {
        guard sizeBytes >= 1, Int64(sizeBytes) <= Self.maxObjectBytes else {
            throw VaifError.invalidArgument("sizeBytes must be between 1 and \(Self.maxObjectBytes)")
        }
        var body = try target(key, bucket)
        body["sizeBytes"] = .integer(sizeBytes)
        if let contentType, !contentType.isEmpty { body["contentType"] = .string(contentType) }
        // Metered on the server: never replayed after it may have been received.
        return try await mint("/storage/upload-url", body, idempotent: false)
    }

    /// Store `data` at `key`, overwriting any existing object.
    ///
    /// This mints a presigned URL and PUTs the bytes straight to the object
    /// store; the API key and session token are never sent there. The PUT is
    /// retried on transient failures, the metered mint is not.
    @discardableResult
    public func upload(_ key: String, data: Data, contentType: String = "application/octet-stream", bucket: String? = nil) async throws -> UploadResult {
        guard !data.isEmpty else { throw VaifError.invalidArgument("data must not be empty") }
        guard Int64(data.count) <= Self.maxObjectBytes else { throw VaifError.invalidArgument("upload accepts at most 5 GiB per object") }
        let url = try await createSignedUploadURL(key, sizeBytes: data.count, contentType: contentType, bucket: bucket)
        var put = HTTPRequest(method: "PUT", path: url, body: data, contentType: contentType)
        put.absolute = true
        put.idempotent = true
        do {
            _ = try await transport.send(put)
        } catch var error as VaifError {
            if error.code == nil { error.code = "STORAGE_UPLOAD_FAILED" }
            throw error
        }
        return UploadResult(key: key, bucket: bucket, size: data.count)
    }

    /// An object's bytes; throws `.notFound` when missing.
    ///
    /// Mints a download URL (as `createSignedURL` does) and reads it directly
    /// from the object store; the API key and session token are never sent
    /// there. The read is retried on transient failures.
    public func download(_ key: String, bucket: String? = nil) async throws -> Data {
        let url = try await createSignedURL(key, bucket: bucket)
        var get = HTTPRequest(method: "GET", path: url)
        get.absolute = true
        return try await transport.send(get).data
    }

    /// The bucket's UUID: a UUID passes through; a name is looked up once in
    /// the project's bucket list (`GET /storage/buckets?projectId=`) and cached.
    func bucketId(_ bucket: String) async throws -> String {
        guard !bucket.isEmpty else { throw VaifError.invalidArgument("bucket must not be empty") }
        if bucket.count == 36, UUID(uuidString: bucket) != nil { return bucket }
        if let cached = bucketIds[bucket] { return cached }
        guard let projectId else { throw VaifError.projectIdRequired("Resolving bucket \"\(bucket)\" by name (or pass its UUID)") }
        var request = HTTPRequest(method: "GET", path: "/storage/buckets")
        request.query = [URLQueryItem(name: "projectId", value: projectId)]
        struct Bucket: Decodable { let id: String; let name: String }
        struct Payload: Decodable { let buckets: [Bucket]? }
        let buckets = try await sendAuthorized(request, transport: transport, auth: auth).decode(Payload.self).buckets ?? []
        for found in buckets { bucketIds[found.name] = found.id }
        guard let id = bucketIds[bucket] else {
            throw VaifError(kind: .notFound, message: "Bucket \"\(bucket)\" not found in project \(projectId)", code: "BUCKET_NOT_FOUND")
        }
        return id
    }

    /// One page of the objects in `bucket` (a name or UUID; default `default`).
    ///
    /// Uses the bucket routes (`GET /buckets/:bucketId/files`), which require
    /// a VAIF Studio account with a role on the project: an app user's
    /// session or a project key alone is refused.
    public func list(bucket: String = "default", prefix: String? = nil, limit: Int = 100, cursor: String? = nil) async throws -> StorageList {
        guard (1...1000).contains(limit) else { throw VaifError.invalidArgument("limit must be between 1 and 1000") }
        let id = try await bucketId(bucket)
        var request = HTTPRequest(method: "GET", path: "/buckets/\(Transport.escape(id))/files")
        request.query = [URLQueryItem(name: "maxKeys", value: String(limit))]
        if let prefix, !prefix.isEmpty { request.query.append(URLQueryItem(name: "prefix", value: prefix)) }
        if let cursor, !cursor.isEmpty { request.query.append(URLQueryItem(name: "continuationToken", value: cursor)) }
        struct Payload: Decodable {
            let files: [StorageFile]?
            let folders: [String]?
            let nextToken: String?
            let isTruncated: Bool?
        }
        let payload = try await sendAuthorized(request, transport: transport, auth: auth).decode(Payload.self)
        return StorageList(files: payload.files ?? [], prefixes: payload.folders ?? [], nextCursor: payload.nextToken, hasMore: payload.isTruncated ?? false)
    }

    /// Delete one object (`DELETE /buckets/:bucketId/files?key=`; the key
    /// travels in the query). Same account requirement as `list`.
    public func delete(_ key: String, bucket: String = "default") async throws {
        try Self.check(key: key)
        let id = try await bucketId(bucket)
        var request = HTTPRequest(method: "DELETE", path: "/buckets/\(Transport.escape(id))/files")
        request.query = [URLQueryItem(name: "key", value: key)]
        _ = try await sendAuthorized(request, transport: transport, auth: auth)
    }
}

/// Bucket name -> UUID, for the lifetime of one client.
final class BucketIdCache: @unchecked Sendable {
    private let lock = NSLock()
    private var ids: [String: String] = [:]

    subscript(name: String) -> String? {
        get { lock.lock(); defer { lock.unlock() }; return ids[name] }
        set { lock.lock(); ids[name] = newValue; lock.unlock() }
    }
}
