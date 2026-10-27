import Foundation
import Security

/// Where `AuthClient` keeps the signed-in session between launches.
///
/// The client restores the stored session when it is created, saves every
/// new or refreshed session and clears the store on sign-out. Calls are
/// synchronous and made from the `AuthClient` actor.
///
/// Without a `sessionStore` argument, `VaifClient` uses
/// `KeychainSessionStore(projectId:baseURL:)`. Pass `MemorySessionStore()` to
/// keep the session in memory only, or your own type to store it somewhere
/// else.
public protocol SessionStore: Sendable {
    /// The stored session, or nil when there is none.
    func load() throws -> Session?
    func save(_ session: Session) throws
    func clear() throws
}

/// The API origin and project a stored session belongs to.
struct SessionOwner: Equatable, Sendable {
    /// `scheme://host[:port]`, lowercase, without the scheme's default port.
    let origin: String
    /// nil for a platform-account client.
    let projectId: String?

    init(baseURL: URL, projectId: String?) {
        self.origin = Transport.origin(of: baseURL)
        self.projectId = projectId
    }

    /// The Keychain account: `session.<origin>.<projectId>`, with `platform`
    /// in place of the project for a platform-account client.
    var account: String { "session.\(origin).\(projectId ?? "platform")" }
}

/// The wire format of a stored session: JSON with dates as seconds since 1970.
enum SessionCoding {
    /// A session together with the API origin and project it was saved for.
    private struct OwnedSession: Codable {
        let origin: String
        let projectId: String?
        let session: Session
    }

    private static func encoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        encoder.outputFormatting = .sortedKeys
        return encoder
    }

    private static func decoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }

    static func encode(_ session: Session) throws -> Data {
        try encoder().encode(session)
    }

    static func decode(_ data: Data) throws -> Session {
        try decoder().decode(Session.self, from: data)
    }

    /// `{"origin": ..., "projectId": ..., "session": {...}}`.
    static func encode(_ session: Session, owner: SessionOwner) throws -> Data {
        try encoder().encode(OwnedSession(origin: owner.origin, projectId: owner.projectId, session: session))
    }

    /// The stored session, or nil when it was saved for another API origin or
    /// project. Throws when the data is not a session saved with its owner.
    static func decode(_ data: Data, owner: SessionOwner) throws -> Session? {
        let stored = try decoder().decode(OwnedSession.self, from: data)
        guard stored.origin == owner.origin, stored.projectId == owner.projectId else { return nil }
        return stored.session
    }
}

/// The store a client uses when the app passes none.
enum DefaultSessionStore {
    static func make(projectId: String?, baseURL: URL) -> any SessionStore {
        KeychainSessionStore(projectId: projectId, baseURL: baseURL)
    }
}

/// A session store in process memory: nothing survives a relaunch.
///
/// Pass it to `VaifClient(sessionStore:)` to keep the session out of the
/// Keychain.
public final class MemorySessionStore: SessionStore, @unchecked Sendable {
    private let lock = NSLock()
    private var data: Data?

    public init(_ session: Session? = nil) {
        data = session.flatMap { try? SessionCoding.encode($0) }
    }

    public func load() throws -> Session? {
        lock.lock(); defer { lock.unlock() }
        return try data.map(SessionCoding.decode)
    }

    public func save(_ session: Session) throws {
        let encoded = try SessionCoding.encode(session)
        lock.lock(); data = encoded; lock.unlock()
    }

    public func clear() throws {
        lock.lock(); data = nil; lock.unlock()
    }
}

/// Keeps the session (access token, rotating refresh token, expiry and user)
/// as one generic-password item in the Keychain.
///
/// `VaifClient` uses `KeychainSessionStore(projectId:baseURL:)` when no store
/// is passed. Create one yourself to share the session with an app extension:
///
/// ```swift
/// let vaif = try VaifClient(projectId: "YOUR_PROJECT_ID", apiKey: "vk_pub_...",
///                           sessionStore: KeychainSessionStore(projectId: "YOUR_PROJECT_ID",
///                                                              accessGroup: "TEAMID.com.example.shared"))
/// ```
///
/// On iOS, tvOS, watchOS and visionOS, and on macOS with
/// `useDataProtectionKeychain: true`, the item is readable after the device's
/// first unlock and never leaves the device
/// (`kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly`; it is not synced to
/// iCloud Keychain), so background refreshes keep working. By default on
/// macOS the item is in the user's login keychain, where that attribute does
/// not apply: it is readable while the login keychain is unlocked and moves
/// with that keychain, for example to a new Mac with Migration Assistant.
///
/// Every client for the same API origin and project shares the item. In a
/// server, or any process that acts for more than one user, give each client
/// a `MemorySessionStore()` instead.
///
/// A stored value that can no longer be decoded is deleted and treated as
/// signed out.
public struct KeychainSessionStore: SessionStore {
    public let service: String
    public let account: String
    public let accessGroup: String?
    /// macOS only: use the data protection keychain (as iOS always does), so
    /// the item is readable after first unlock and stays on this device. It
    /// requires a signed app with a keychain-access-groups entitlement.
    public let useDataProtectionKeychain: Bool
    /// The API origin and project the item belongs to, for a store made with
    /// `init(projectId:baseURL:)`; nil for one named by service and account.
    let owner: SessionOwner?

    /// The item named by `service` and `account`, holding the session alone.
    public init(service: String = "studio.vaif.client", account: String = "session",
                accessGroup: String? = nil, useDataProtectionKeychain: Bool = false) {
        self.init(service: service, account: account, accessGroup: accessGroup,
                  useDataProtectionKeychain: useDataProtectionKeychain, owner: nil)
    }

    /// One item per API origin and project (or platform account), named
    /// `session.<origin>.<projectId>`, for example
    /// `session.https://api.vaif.studio.YOUR_PROJECT_ID`. Two clients for one
    /// project on different APIs keep separate sessions. The item records the
    /// origin and project, and a session saved for another is not restored.
    ///
    /// `VaifClient` refuses a store made for an origin or project other than
    /// its own, so pass the client's `baseURL` here.
    public init(projectId: String?, baseURL: URL = VaifClient.defaultBaseURL, service: String = "studio.vaif.client",
                accessGroup: String? = nil, useDataProtectionKeychain: Bool = false) {
        let owner = SessionOwner(baseURL: baseURL, projectId: projectId)
        self.init(service: service, account: owner.account, accessGroup: accessGroup,
                  useDataProtectionKeychain: useDataProtectionKeychain, owner: owner)
    }

    private init(service: String, account: String, accessGroup: String?, useDataProtectionKeychain: Bool, owner: SessionOwner?) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
        self.useDataProtectionKeychain = useDataProtectionKeychain
        self.owner = owner
    }

    private func query() -> [String: Any] {
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
        ]
        if let accessGroup { query[kSecAttrAccessGroup as String] = accessGroup }
        if useDataProtectionKeychain { query[kSecUseDataProtectionKeychain as String] = true }
        return query
    }

    static func failure(_ status: OSStatus, _ action: String) -> VaifError {
        let detail = (SecCopyErrorMessageString(status, nil) as String?) ?? "OSStatus \(status)"
        return VaifError(kind: .storage, message: "Keychain \(action) failed: \(detail)", code: "KEYCHAIN_\(status)")
    }

    public func load() throws -> Session? {
        var request = query()
        request[kSecReturnData as String] = true
        request[kSecMatchLimit as String] = kSecMatchLimitOne
        var result: CFTypeRef?
        let status = SecItemCopyMatching(request as CFDictionary, &result)
        if status == errSecItemNotFound { return nil }
        guard status == errSecSuccess, let data = result as? Data else { throw Self.failure(status, "read") }
        do {
            guard let owner else { return try SessionCoding.decode(data) }
            return try SessionCoding.decode(data, owner: owner)
        } catch {
            try clear()
            return nil
        }
    }

    public func save(_ session: Session) throws {
        let data = try owner.map { try SessionCoding.encode(session, owner: $0) } ?? SessionCoding.encode(session)
        let attributes: [String: Any] = [
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly,
        ]
        var status = SecItemUpdate(query() as CFDictionary, attributes as CFDictionary)
        if status == errSecItemNotFound {
            var add = query()
            add.merge(attributes) { _, new in new }
            status = SecItemAdd(add as CFDictionary, nil)
        }
        guard status == errSecSuccess else { throw Self.failure(status, "write") }
    }

    public func clear() throws {
        let status = SecItemDelete(query() as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw Self.failure(status, "delete") }
    }
}
