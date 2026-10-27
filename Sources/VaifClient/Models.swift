import Foundation

/// A project end user.
public struct User: Sendable, Codable, Hashable {
    public let id: String
    public let email: String?
    public let phone: String?
    public let provider: String?
    public let metadata: JSONValue?
    public let emailVerifiedAt: String?
    public let createdAt: String?

    public init(id: String, email: String? = nil, phone: String? = nil, provider: String? = nil,
                metadata: JSONValue? = nil, emailVerifiedAt: String? = nil, createdAt: String? = nil) {
        self.id = id
        self.email = email
        self.phone = phone
        self.provider = provider
        self.metadata = metadata
        self.emailVerifiedAt = emailVerifiedAt
        self.createdAt = createdAt
    }
}

/// An authenticated end-user session. `Codable`, so it can be persisted (for
/// example in the Keychain) and restored with `auth.setSession(_:)`.
///
/// `refreshToken` is the rotating token the API issues in the
/// `project_refresh_token` cookie.
public struct Session: Sendable, Codable, Hashable {
    public let accessToken: String
    public let refreshToken: String?
    public let expiresAt: Date
    public let user: User?

    public init(accessToken: String, refreshToken: String? = nil, expiresAt: Date, user: User? = nil) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expiresAt = expiresAt
        self.user = user
    }

    public func expires(within interval: TimeInterval) -> Bool {
        expiresAt.timeIntervalSinceNow <= interval
    }
}

/// The outcome of `signIn`: a session, or an MFA challenge to complete.
public enum SignInResult: Sendable, Equatable {
    case session(Session)
    case mfaRequired(challengeToken: String)
}

/// The outcome of `signUp`. `session` is nil when the API answers "pending
/// verification" (it does not reveal whether an address already exists).
public struct SignUpResult: Sendable, Equatable {
    public let session: Session?
    public let user: User?
    public let pendingVerification: Bool
    public let message: String?
}

/// Session changes delivered by `auth.sessionChanges()`.
public struct AuthStateChange: Sendable, Equatable {
    public enum Event: String, Sendable {
        case signedIn = "SIGNED_IN"
        case tokenRefreshed = "TOKEN_REFRESHED"
        case signedOut = "SIGNED_OUT"
    }

    public let event: Event
    public let session: Session?
}

/// Rows from a list query plus the total number of matching rows.
public struct ListResult<Element: Sendable>: Sendable {
    public let data: [Element]
    public let count: Int
}

/// One page of offset pagination (`page` starts at 1).
public struct Page<Element: Sendable>: Sendable {
    public let data: [Element]
    public let total: Int
    public let page: Int
    public let pageSize: Int

    public var pageCount: Int { pageSize > 0 ? (total + pageSize - 1) / pageSize : 0 }
    public var hasNext: Bool { page < pageCount }
    public var hasPrevious: Bool { page > 1 }
}

/// A stored object.
public struct UploadResult: Sendable, Equatable {
    public let key: String
    public let bucket: String?
    public let size: Int
}

public struct MFAEnrollment: Sendable, Decodable {
    public let enrollToken: String
    public let secret: String
    public let otpauthUri: String
    public let expiresInSeconds: Int
}

public struct OAuthSignIn: Sendable {
    public let url: String
    public let state: String
    public let codeVerifier: String
    public let expiresIn: Int?
}

public struct StorageFile: Sendable, Decodable {
    public let key: String
    /// The object's size in bytes. An `Int64`, because an object can be up to
    /// 5 GiB and `Int` is 32 bits on Apple Watch.
    public let size: Int64
    public let lastModified: String?
    public let etag: String?
}

public struct StorageList: Sendable {
    public let files: [StorageFile]
    public let prefixes: [String]
    public let nextCursor: String?
    public let hasMore: Bool
}

/// The HTTP response produced by a function.
public struct FunctionResponse: Sendable {
    public let status: Int
    public let headers: [String: String]
    public let data: Data

    /// The body decoded as JSON. Throws a `.badResponse` `VaifError` when
    /// it is not JSON.
    public func json() throws -> JSONValue {
        do {
            return try JSONDecoder().decode(JSONValue.self, from: data)
        } catch {
            throw VaifError(kind: .badResponse, message: "the response body is not JSON", status: status)
        }
    }

    /// The body decoded into a `Decodable` type. Throws a `.badResponse`
    /// `VaifError` when it does not match.
    public func decode<T: Decodable>(_ type: T.Type = T.self, decoder: JSONDecoder = JSONDecoder()) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw VaifError.decoding(error, as: T.self, status: status)
        }
    }

    public var text: String { String(decoding: data, as: UTF8.self) }
}
