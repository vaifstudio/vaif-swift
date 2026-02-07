/// VAIF Storage Client
///
/// File storage operations with CDN and image transformations.

import Foundation

// MARK: - Storage Types

/// File object metadata
public struct FileObject: Codable {
    public let id: String
    public let name: String
    public let bucketId: String
    public let createdAt: Date
    public let updatedAt: Date?
    public let size: Int
    public let contentType: String?
    public let metadata: [String: String]?

    enum CodingKeys: String, CodingKey {
        case id, name, size, metadata
        case bucketId = "bucket_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case contentType = "content_type"
    }
}

/// Storage bucket
public struct Bucket: Codable {
    public let id: String
    public let name: String
    public let `public`: Bool
    public let fileSizeLimit: Int?
    public let allowedMimeTypes: [String]?
    public let createdAt: Date
    public let updatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case id, name
        case `public` = "public"
        case fileSizeLimit = "file_size_limit"
        case allowedMimeTypes = "allowed_mime_types"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

/// Upload result
public struct UploadResult: Codable {
    public let id: String
    public let path: String
    public let fullPath: String
    public let size: Int
    public let contentType: String?

    enum CodingKeys: String, CodingKey {
        case id, path, size
        case fullPath = "full_path"
        case contentType = "content_type"
    }
}

/// Storage error
public struct StorageError: Error, Sendable, LocalizedError {
    public let message: String
    public let statusCode: String
    public let error: String

    public var errorDescription: String? {
        "StorageError: \(message) (status: \(statusCode))"
    }
}

/// Image transform options
public struct ImageTransformOptions {
    public let width: Int?
    public let height: Int?
    public let resize: String?
    public let format: String?
    public let quality: Int?

    public init(
        width: Int? = nil,
        height: Int? = nil,
        resize: String? = nil,
        format: String? = nil,
        quality: Int? = nil
    ) {
        self.width = width
        self.height = height
        self.resize = resize
        self.format = format
        self.quality = quality
    }

    func toQueryParams() -> [String: String] {
        var params: [String: String] = [:]
        if let width = width { params["width"] = String(width) }
        if let height = height { params["height"] = String(height) }
        if let resize = resize { params["resize"] = resize }
        if let format = format { params["format"] = format }
        if let quality = quality { params["quality"] = String(quality) }
        return params
    }
}

/// Upload options
public struct UploadOptions {
    public let contentType: String?
    public let cacheControl: String?
    public let upsert: Bool
    public let metadata: [String: String]?

    public init(
        contentType: String? = nil,
        cacheControl: String? = nil,
        upsert: Bool = false,
        metadata: [String: String]? = nil
    ) {
        self.contentType = contentType
        self.cacheControl = cacheControl
        self.upsert = upsert
        self.metadata = metadata
    }
}

/// Download options
public struct DownloadOptions {
    public let transform: ImageTransformOptions?

    public init(transform: ImageTransformOptions? = nil) {
        self.transform = transform
    }
}

// MARK: - Storage Client

/// Storage client for VAIF Studio.
public final class VaifStorage {
    private let client: VaifClient

    init(client: VaifClient) {
        self.client = client
    }

    /// Get a storage bucket.
    public func from(_ bucket: String) -> StorageBucket {
        return StorageBucket(client: client, bucket: bucket)
    }

    /// List all buckets.
    public func listBuckets() async throws -> (data: [Bucket]?, error: StorageError?) {
        let response: ApiResponse<[Bucket]> = try await client.request(
            path: "/storage/buckets"
        )

        if let error = response.error {
            return (nil, StorageError(
                message: error.message,
                statusCode: String(response.status),
                error: error.code ?? "STORAGE_ERROR"
            ))
        }

        return (response.data, nil)
    }

    /// Create a bucket.
    public func createBucket(
        name: String,
        `public`: Bool = false,
        fileSizeLimit: Int? = nil,
        allowedMimeTypes: [String]? = nil
    ) async throws -> (data: Bucket?, error: StorageError?) {
        var body: [String: Any] = [
            "name": name,
            "public": `public`
        ]
        if let limit = fileSizeLimit { body["fileSizeLimit"] = limit }
        if let types = allowedMimeTypes { body["allowedMimeTypes"] = types }

        let response: ApiResponse<Bucket> = try await client.request(
            path: "/storage/buckets",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return (nil, StorageError(
                message: error.message,
                statusCode: String(response.status),
                error: error.code ?? "STORAGE_ERROR"
            ))
        }

        return (response.data, nil)
    }

    /// Delete a bucket.
    public func deleteBucket(_ name: String) async throws -> StorageError? {
        let safeName = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? name
        let response: ApiResponse<EmptyResponse> = try await client.request(
            path: "/storage/buckets/\(safeName)",
            method: "DELETE"
        )

        if let error = response.error {
            return StorageError(
                message: error.message,
                statusCode: String(response.status),
                error: error.code ?? "STORAGE_ERROR"
            )
        }

        return nil
    }
}

// MARK: - Storage Bucket

/// Storage bucket operations.
public final class StorageBucket {
    private let client: VaifClient
    private let bucket: String

    init(client: VaifClient, bucket: String) {
        self.client = client
        self.bucket = bucket
    }

    /// Validate and sanitize a storage path to prevent path traversal attacks.
    /// Rejects paths containing '..' segments or absolute paths.
    private func sanitizePath(_ path: String) throws -> String {
        guard !path.hasPrefix("/") else {
            throw StorageError(
                message: "Storage path must not be absolute: \(path)",
                statusCode: "400",
                error: "INVALID_PATH"
            )
        }
        let segments = path.components(separatedBy: "/")
        for segment in segments {
            if segment == ".." {
                throw StorageError(
                    message: "Storage path must not contain path traversal (..): \(path)",
                    statusCode: "400",
                    error: "INVALID_PATH"
                )
            }
        }
        // Normalize: remove empty segments and '.' references
        let normalized = segments.filter { !$0.isEmpty && $0 != "." }.joined(separator: "/")
        return normalized
    }

    /// Upload a file.
    public func upload(
        path: String,
        data: Data,
        options: UploadOptions = UploadOptions()
    ) async throws -> (data: UploadResult?, error: StorageError?) {
        let safePath = try sanitizePath(path)
        let url = URL(string: "\(client.config.apiUrl)/storage/\(bucket)/\(safePath)")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(client.config.projectId, forHTTPHeaderField: "X-Project-ID")
        request.setValue(client.config.apiKey, forHTTPHeaderField: "apikey")

        if let token = client.getAccessToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        var body = Data()

        // Add file data
        let filename = path.components(separatedBy: "/").last ?? "file"
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(options.contentType ?? "application/octet-stream")\r\n\r\n".data(using: .utf8)!)
        body.append(data)
        body.append("\r\n".data(using: .utf8)!)

        // Add options
        if let contentType = options.contentType {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"contentType\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(contentType)\r\n".data(using: .utf8)!)
        }

        if options.upsert {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"upsert\"\r\n\r\n".data(using: .utf8)!)
            body.append("true\r\n".data(using: .utf8)!)
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body

        let (responseData, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return (nil, StorageError(message: "Invalid response", statusCode: "0", error: "NETWORK_ERROR"))
        }

        if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
            let result = try JSONDecoder().decode(UploadResult.self, from: responseData)
            return (result, nil)
        } else {
            return (nil, StorageError(
                message: "Upload failed: \(httpResponse.statusCode)",
                statusCode: String(httpResponse.statusCode),
                error: "UPLOAD_ERROR"
            ))
        }
    }

    /// Download a file.
    public func download(
        path: String,
        options: DownloadOptions = DownloadOptions()
    ) async throws -> (data: Data?, error: StorageError?) {
        let safePath = try sanitizePath(path)
        var urlString = "\(client.config.apiUrl)/storage/\(bucket)/\(safePath)"

        if let transform = options.transform {
            let params = transform.toQueryParams()
            if !params.isEmpty {
                urlString += "?" + params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            }
        }

        guard let url = URL(string: urlString) else {
            return (nil, StorageError(message: "Invalid URL", statusCode: "0", error: "INVALID_URL"))
        }

        var request = URLRequest(url: url)
        request.setValue(client.config.apiKey, forHTTPHeaderField: "apikey")

        if let token = client.getAccessToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return (nil, StorageError(message: "Invalid response", statusCode: "0", error: "NETWORK_ERROR"))
        }

        if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
            return (data, nil)
        } else {
            return (nil, StorageError(
                message: "Download failed: \(httpResponse.statusCode)",
                statusCode: String(httpResponse.statusCode),
                error: "DOWNLOAD_ERROR"
            ))
        }
    }

    /// Get public URL for a file.
    public func getPublicUrl(path: String) throws -> String {
        let safePath = try sanitizePath(path)
        return "\(client.config.apiUrl)/storage/\(bucket)/\(safePath)"
    }

    /// Create signed URL.
    public func createSignedUrl(
        path: String,
        expiresIn: Int,
        transform: ImageTransformOptions? = nil,
        download: Any? = nil
    ) async throws -> (data: [String: Any]?, error: StorageError?) {
        let safePath = try sanitizePath(path)
        var body: [String: Any] = ["expiresIn": expiresIn]
        if let transform = transform {
            body["transform"] = transform.toQueryParams()
        }
        if let download = download {
            body["download"] = download
        }

        let response: ApiResponse<[String: String]> = try await client.request(
            path: "/storage/\(bucket)/\(safePath)/sign",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return (nil, StorageError(
                message: error.message,
                statusCode: String(response.status),
                error: error.code ?? "SIGN_ERROR"
            ))
        }

        return (response.data as [String: Any]?, nil)
    }

    /// List files in a path.
    public func list(
        path: String = "",
        limit: Int? = nil,
        offset: Int? = nil,
        search: String? = nil,
        sortBy: [String: String]? = nil
    ) async throws -> (data: [FileObject]?, error: StorageError?) {
        var body: [String: Any] = ["prefix": path]
        if let limit = limit { body["limit"] = limit }
        if let offset = offset { body["offset"] = offset }
        if let search = search { body["search"] = search }
        if let sortBy = sortBy { body["sortBy"] = sortBy }

        let response: ApiResponse<[FileObject]> = try await client.request(
            path: "/storage/\(bucket)/list",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return (nil, StorageError(
                message: error.message,
                statusCode: String(response.status),
                error: error.code ?? "LIST_ERROR"
            ))
        }

        return (response.data, nil)
    }

    /// Move/rename a file.
    public func move(from: String, to: String) async throws -> StorageError? {
        let response: ApiResponse<EmptyResponse> = try await client.request(
            path: "/storage/\(bucket)/move",
            method: "POST",
            body: AnyCodable(["from": from, "to": to])
        )

        if let error = response.error {
            return StorageError(
                message: error.message,
                statusCode: String(response.status),
                error: error.code ?? "MOVE_ERROR"
            )
        }

        return nil
    }

    /// Copy a file.
    public func copy(from: String, to: String) async throws -> StorageError? {
        let response: ApiResponse<EmptyResponse> = try await client.request(
            path: "/storage/\(bucket)/copy",
            method: "POST",
            body: AnyCodable(["from": from, "to": to])
        )

        if let error = response.error {
            return StorageError(
                message: error.message,
                statusCode: String(response.status),
                error: error.code ?? "COPY_ERROR"
            )
        }

        return nil
    }

    /// Delete file(s).
    public func remove(_ paths: [String]) async throws -> StorageError? {
        let response: ApiResponse<EmptyResponse> = try await client.request(
            path: "/storage/\(bucket)/delete",
            method: "DELETE",
            body: AnyCodable(["paths": paths])
        )

        if let error = response.error {
            return StorageError(
                message: error.message,
                statusCode: String(response.status),
                error: error.code ?? "DELETE_ERROR"
            )
        }

        return nil
    }
}
