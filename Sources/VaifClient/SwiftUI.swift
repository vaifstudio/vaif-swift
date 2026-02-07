/// VAIF SwiftUI Integration
///
/// Observable wrappers, environment keys, and view modifiers for SwiftUI.

import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(Combine)
import Combine
#endif

// MARK: - Observable Client Wrapper

/// Observable wrapper around VaifClient for SwiftUI integration.
///
/// ```swift
/// @StateObject var vaif = ObservableVaifClient(
///     projectId: "your-project-id",
///     apiKey: "your-api-key"
/// )
/// ```
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public final class ObservableVaifClient: ObservableObject {
    /// The underlying VaifClient.
    public let client: VaifClient

    /// Current auth session.
    @Published public var session: Session?

    /// Current authenticated user.
    @Published public var user: User?

    /// Whether the user is authenticated.
    @Published public var isAuthenticated: Bool = false

    /// Whether the client is loading initial session.
    @Published public var isLoading: Bool = true

    private var unsubscribe: (() -> Void)?

    public init(
        projectId: String,
        apiKey: String,
        apiUrl: String = "https://api.vaif.studio",
        realtimeUrl: String = "wss://realtime.vaif.studio",
        timeout: TimeInterval = 30,
        headers: [String: String] = [:],
        debug: Bool = false
    ) {
        self.client = VaifClient(
            projectId: projectId,
            apiKey: apiKey,
            apiUrl: apiUrl,
            realtimeUrl: realtimeUrl,
            timeout: timeout,
            headers: headers,
            debug: debug
        )
        setupAuthListener()
    }

    public init(client: VaifClient) {
        self.client = client
        setupAuthListener()
    }

    private func setupAuthListener() {
        unsubscribe = client.auth.onAuthStateChange { [weak self] event, session in
            DispatchQueue.main.async {
                self?.session = session
                self?.user = session?.user
                self?.isAuthenticated = session != nil
                self?.isLoading = false
            }
        }
    }

    deinit {
        unsubscribe?()
    }
}

// MARK: - Environment Key

#if canImport(SwiftUI)

/// Environment key for injecting VaifClient into the SwiftUI environment.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
private struct VaifClientKey: EnvironmentKey {
    static let defaultValue: VaifClient? = nil
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension EnvironmentValues {
    /// The VaifClient instance available in the environment.
    var vaifClient: VaifClient? {
        get { self[VaifClientKey.self] }
        set { self[VaifClientKey.self] = newValue }
    }
}

// MARK: - View Modifiers

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension View {
    /// Inject a VaifClient into the environment.
    ///
    /// ```swift
    /// ContentView()
    ///     .vaifClient(client)
    /// ```
    func vaifClient(_ client: VaifClient) -> some View {
        environment(\.vaifClient, client)
    }
}

// MARK: - Auth-Aware View Modifier

/// View modifier that conditionally shows content based on auth state.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
struct VaifAuthViewModifier<AuthenticatedContent: View, UnauthenticatedContent: View>: ViewModifier {
    @ObservedObject var vaif: ObservableVaifClient
    let authenticated: (User) -> AuthenticatedContent
    let unauthenticated: () -> UnauthenticatedContent

    func body(content: Content) -> some View {
        Group {
            if vaif.isLoading {
                content
            } else if let user = vaif.user {
                authenticated(user)
            } else {
                unauthenticated()
            }
        }
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension View {
    /// Show different views based on authentication state.
    ///
    /// ```swift
    /// ProgressView()
    ///     .vaifAuth(vaif,
    ///         authenticated: { user in HomeView(user: user) },
    ///         unauthenticated: { LoginView() }
    ///     )
    /// ```
    func vaifAuth<A: View, U: View>(
        _ vaif: ObservableVaifClient,
        authenticated: @escaping (User) -> A,
        unauthenticated: @escaping () -> U
    ) -> some View {
        modifier(VaifAuthViewModifier(
            vaif: vaif,
            authenticated: authenticated,
            unauthenticated: unauthenticated
        ))
    }
}

#endif

// MARK: - Combine Publishers

#if canImport(Combine)

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension VaifAuth {
    /// Combine publisher for auth state changes.
    var authStatePublisher: AnyPublisher<(AuthChangeEvent, Session?), Never> {
        let subject = PassthroughSubject<(AuthChangeEvent, Session?), Never>()

        let unsub = onAuthStateChange { event, session in
            subject.send((event, session))
        }

        return subject
            .handleEvents(receiveCancel: { unsub() })
            .eraseToAnyPublisher()
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension VaifDatabase {
    /// Execute a query and return a Combine publisher.
    func queryPublisher<T: Decodable>(
        table: String,
        build: @escaping (QueryBuilder<[String: Any]>) -> QueryBuilder<[String: Any]>
    ) -> AnyPublisher<QueryResult<[T]>, Error> {
        Future { promise in
            Task {
                do {
                    let query = build(self.from(table))
                    let result: QueryResult<[T]> = try await query.execute()
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

#endif
