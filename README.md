# VaifClient

[![Swift 5.9+](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2015+%20|%20macOS%2012+%20|%20tvOS%2015+%20|%20watchOS%208+-blue.svg)](https://developer.apple.com)
[![SPM Compatible](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Official Swift SDK for [VAIF Studio](https://vaif.studio) — the Backend-as-a-Service platform. Provides type-safe access to database, auth, storage, edge functions, realtime subscriptions, and AI generation with first-class SwiftUI and Combine support.

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/vaifllc/vaif-swift.git", from: "0.2.0")
]
```

Then add `VaifClient` to your target dependencies:

```swift
.target(
    name: "MyApp",
    dependencies: ["VaifClient"]
)
```

Or in Xcode: **File > Add Package Dependencies** and enter `https://github.com/vaifllc/vaif-swift.git`.

## Quick Start

```swift
import VaifClient

let client = VaifClient(
    projectId: "your-project-id",
    apiKey: "your-api-key"
)

// Query the database
let result = try await client.database.from("users").select("*").execute()
print("Found \(result.data.count) users")
```

## Features

| Module       | Description                                         |
|------------- |-----------------------------------------------------|
| **Database** | Fluent query builder, filters, Codable results      |
| **Auth**     | Email/password, OAuth, OTP, Keychain persistence    |
| **Storage**  | Upload, download, signed URLs, progress tracking    |
| **Functions**| Invoke edge functions, raw response support         |
| **Realtime** | WebSocket channels, postgres changes, presence      |
| **AI**       | Schema/function/endpoint generation, chat streaming |

## SwiftUI Integration

### ObservableVaifClient

Use `ObservableVaifClient` as a `@StateObject` for reactive auth state in SwiftUI:

```swift
import SwiftUI
import VaifClient

@main
struct MyApp: App {
    @StateObject private var vaif = ObservableVaifClient(
        projectId: "your-project-id",
        apiKey: "your-api-key"
    )

    var body: some Scene {
        WindowGroup {
            ContentView()
                .vaifClient(vaif)
        }
    }
}
```

### Environment Access

Access the client anywhere in the view hierarchy via the environment:

```swift
struct ContentView: View {
    @EnvironmentObject var vaif: ObservableVaifClient

    var body: some View {
        if vaif.isLoading {
            ProgressView()
        } else if vaif.isAuthenticated {
            HomeView(user: vaif.user!)
        } else {
            LoginView()
        }
    }
}
```

### Auth-Aware Views

The `.vaifAuth()` modifier provides auth state directly:

```swift
struct RootView: View {
    var body: some View {
        Text("Hello")
            .vaifAuth { session, isLoading in
                if isLoading {
                    ProgressView()
                } else if let session {
                    Text("Welcome, \(session.user.email)")
                } else {
                    LoginView()
                }
            }
    }
}
```

### Combine Publishers

Use Combine for reactive data flows:

```swift
import Combine

// Auth state as a publisher
vaif.authStatePublisher
    .sink { event, session in
        print("Auth event: \(event)")
    }
    .store(in: &cancellables)

// Database query as a publisher
vaif.queryPublisher {
    try await $0.database.from("posts").select("*").execute()
}
.sink(
    receiveCompletion: { _ in },
    receiveValue: { result in
        print("Posts: \(result.data)")
    }
)
.store(in: &cancellables)
```

## Configuration

```swift
let client = VaifClient(
    projectId: "your-project-id",
    apiKey: "your-api-key",
    config: VaifConfig(
        apiUrl: "https://custom-api.example.com",
        realtimeUrl: "wss://custom-ws.example.com",
        timeout: 15,                              // Seconds
        headers: ["X-Custom": "value"],
        debug: true,
        retryConfig: RetryConfig(
            maxRetries: 3,
            baseDelay: 0.5,                       // Seconds
            maxDelay: 30
        )
    )
)
```

## Database

### Query Builder

All query builder methods return `self` with `@discardableResult` for clean chaining:

```swift
// Select with filters, ordering, and pagination
let result = try await client.database
    .from("posts")
    .select("id, title, created_at")
    .eq("published", value: true)
    .order("created_at", ascending: false)
    .limit(10)
    .offset(20)
    .execute()

// Insert
try await client.database.from("posts").insert([
    "title": "Hello World",
    "content": "My first post",
]).execute()

// Update
try await client.database
    .from("posts")
    .update(["title": "Updated Title"])
    .eq("id", value: "post-123")
    .execute()

// Delete
try await client.database
    .from("posts")
    .delete()
    .eq("id", value: "post-123")
    .execute()

// Upsert
try await client.database.from("users")
    .upsert([
        "email": "john@example.com",
        "name": "John Updated",
    ], onConflict: "email")
    .execute()
```

### Typed Results with Codable

```swift
struct User: Codable {
    let id: String
    let email: String
    let name: String
}

let users: [User] = try await client.database
    .from("users")
    .select("id, email, name")
    .executeAs()
```

### Single Row Queries

```swift
// Exactly one row (throws if 0 or >1)
let user = try await client.database
    .from("users")
    .select("*")
    .eq("id", value: "user-123")
    .single()

// Zero or one row (nil if not found)
let maybeUser = try await client.database
    .from("users")
    .select("*")
    .eq("email", value: "john@example.com")
    .maybeSingle()
```

### Filters

```swift
builder.eq("status", value: "active")           // =
builder.neq("role", value: "admin")             // !=
builder.gt("age", value: 18)                    // >
builder.gte("score", value: 100)                // >=
builder.lt("price", value: 50)                  // <
builder.lte("quantity", value: 0)               // <=
builder.like("name", pattern: "%john%")         // LIKE
builder.ilike("email", pattern: "%@gmail.com")  // ILIKE
builder.isNull("deleted_at")                    // IS NULL
builder.in("status", values: ["active", "pending"])
builder.contains("tags", value: ["swift"])
builder.textSearch("content", query: "hello world")
builder.or("age.gt.18,role.eq.admin")
```

### Raw SQL

```swift
let result = try await client.database.raw(
    "SELECT * FROM users WHERE age > $1 AND status = $2",
    params: [18, "active"]
)
```

## Auth

```swift
// Sign up
let response = try await client.auth.signUp(
    email: "user@example.com",
    password: "securepassword123",
    data: ["display_name": "New User"]
)

// Sign in with email/password
let response = try await client.auth.signInWithPassword(
    email: "user@example.com",
    password: "password123"
)

// OAuth (returns redirect URL)
let url = try client.auth.signInWithOAuth(
    provider: .google,
    redirectTo: "https://myapp.com/callback"
)

// OTP (magic link)
try await client.auth.signInWithOTP(email: "user@example.com")
try await client.auth.verifyOTP(
    email: "user@example.com",
    token: "123456",
    type: .email
)

// Session management
try await client.auth.refreshSession()
try await client.auth.signOut()

// Password reset
try await client.auth.resetPasswordForEmail(
    "user@example.com",
    redirectTo: "https://myapp.com/reset"
)
```

### Keychain Persistence

Sessions are automatically persisted to the iOS/macOS Keychain using the Security framework with `kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly`. On app launch, the SDK restores the session and refreshes the token if needed.

### Auth State Changes

```swift
let unsubscribe = client.auth.onAuthStateChange { event, session in
    switch event {
    case .signedIn:
        print("Signed in: \(session?.user.email ?? "")")
    case .signedOut:
        print("Signed out")
    case .tokenRefreshed:
        print("Token refreshed")
    default:
        break
    }
}

// Later: stop listening
unsubscribe()
```

## Storage

```swift
let bucket = client.storage.from("avatars")

// Upload
let result = try await bucket.upload(
    path: "profile.jpg",
    data: imageData,
    contentType: "image/jpeg",
    upsert: true
)

// Download
let data = try await bucket.download(path: "profile.jpg")

// Public URL
let url = bucket.getPublicURL(path: "profile.jpg")

// Signed URL (expires in 1 hour)
let signedURL = try await bucket.createSignedURL(
    path: "private/report.pdf",
    expiresIn: 3600
)

// List files
let files = try await bucket.list(path: "uploads/", limit: 100)

// Move, copy, remove
try await bucket.move(from: "old/path.jpg", to: "new/path.jpg")
try await bucket.copy(from: "source.jpg", to: "destination.jpg")
try await bucket.remove(paths: ["file1.jpg", "file2.jpg"])
```

## Functions

```swift
// Invoke an edge function
let result = try await client.functions.invoke("send-email", body: [
    "to": "user@example.com",
    "subject": "Welcome!",
    "body": "Thanks for signing up.",
])
print(result.data)

// Raw response (for non-JSON responses)
let raw = try await client.functions.invokeRaw("generate-pdf", body: [
    "template": "invoice",
])
// raw.data is Data, raw.contentType is the response content type
```

## Realtime

```swift
// Connect
try await client.realtime.connect(options: RealtimeOptions(
    heartbeat: true,
    heartbeatInterval: 30000,
    autoReconnect: true,
    maxReconnectAttempts: 10
))

// Subscribe to database changes
let channel = client.realtime.channel("room:lobby")

channel.onPostgresChanges(event: "INSERT", schema: "public", table: "messages") { payload in
    print("New message: \(payload)")
}

channel.onPostgresChanges(event: "UPDATE", schema: "public", table: "messages") { payload in
    print("Updated: \(payload)")
}

try await channel.subscribe { status, error in
    print("Channel: \(status)")
}

// Broadcast to other clients
channel.broadcast(event: "typing", payload: ["user": "john"])

// Presence tracking
channel.track(payload: [
    "user": "john",
    "online_at": "\(Int(Date().timeIntervalSince1970))",
])
channel.untrack()

// Disconnect when done
client.realtime.disconnect()
```

## AI

```swift
// Generate a database schema
let schema = try await client.ai.generateSchema(
    prompt: "Create a blog with posts, authors, and comments",
    format: "sql",
    includeRelations: true,
    includeIndexes: true
)
print("Generated \(schema.tables.count) tables using \(schema.creditsUsed) credits")

// Generate with model options
let schema = try await client.ai.generateSchema(
    prompt: "E-commerce product catalog",
    format: "sql",
    options: AIGenerateOptions(
        model: .precision,
        maxTokens: 4096,
        temperature: 0.3
    )
)

// Stream a chat response
let stream = try await client.ai.chatStream(messages: [
    AIChatMessage(role: "user", content: "Write a Swift function to reverse a string"),
])

for try await chunk in stream {
    print(chunk, terminator: "")
}

// Code review
let review = try await client.ai.review(
    code: myCode,
    language: "swift",
    focus: ["security", "performance"]
)

// Check AI credits
let credits = try await client.ai.getCredits()
print("Remaining: \(credits.remaining) credits")
```

## Error Handling

All errors use the unified `VaifError` enum:

```swift
do {
    let result = try await client.database
        .from("users")
        .select("*")
        .eq("id", value: "missing")
        .single()
} catch let error as VaifError {
    switch error {
    case .auth(let message, _, _):
        print("Auth error: \(message)")
    case .database(let message, _, _):
        print("Database error: \(message)")
    case .storage(let message, _, _):
        print("Storage error: \(message)")
    case .network(let underlying):
        print("Network error: \(underlying.localizedDescription)")
    case .timeout:
        print("Request timed out")
    case .rateLimited(let retryAfter):
        print("Rate limited, retry after \(retryAfter ?? 0)s")
    case .server(let message, let status):
        print("Server error \(status): \(message)")
    default:
        print("Error: \(error.localizedDescription)")
    }

    // Check if the error is retryable
    if error.isRetryable {
        print("This error can be retried")
    }

    // Get the HTTP status code
    if let status = error.statusCode {
        print("HTTP \(status)")
    }
}
```

### VaifError Cases

| Case              | Description                         |
|-------------------|-------------------------------------|
| `.network`        | Network connectivity failure        |
| `.timeout`        | Request timed out                   |
| `.auth`           | Authentication/authorization error  |
| `.database`       | Database query error                |
| `.storage`        | File storage error                  |
| `.function`       | Edge function error                 |
| `.ai`             | AI generation error                 |
| `.realtime`       | WebSocket/realtime error            |
| `.server`         | Server error (5xx)                  |
| `.invalidRequest` | Client-side validation error        |
| `.decoding`       | JSON decoding error                 |
| `.rateLimited`    | Rate limit exceeded (429)           |

All cases that represent server errors include `isRetryable` and `statusCode` computed properties.

## Requirements

- **Swift**: 5.9+
- **iOS**: 15.0+
- **macOS**: 12.0+
- **tvOS**: 15.0+
- **watchOS**: 8.0+
- **visionOS**: 1.0+

## License

[MIT](LICENSE)

## Links

- [VAIF Studio Documentation](https://docs.vaif.studio)
- [GitHub Repository](https://github.com/vaifllc/vaif-swift)
- [Report an Issue](https://github.com/vaifllc/vaif-swift/issues)
