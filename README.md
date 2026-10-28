# VaifClient for Swift

<!-- BEGIN GENERATED SDK STATUS: notice:swift -->
> `VaifClient` 1.0.0 is the version in this repository and has not been tagged yet. The hosted API (`https://api.vaif.studio`) and console are not available yet.
<!-- END GENERATED SDK STATUS: notice:swift -->

`VaifClient` is the Swift SDK for the [VAIF Studio](https://vaif.studio) API:
end-user authentication, database queries, file storage, functions, realtime
database changes and every typed API operation, for apps on Apple platforms.

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Quick start](#quick-start)
- [Authentication and configuration](#authentication-and-configuration)
- [Auth](#auth)
- [Database](#database)
- [Storage](#storage)
- [Functions](#functions)
- [Realtime](#realtime)
- [Generated API operations](#generated-api-operations)
- [Error handling](#error-handling)
- [Versioning](#versioning)
- [Support](#support)
- [License](#license)

## Requirements

- Swift 6.0 or later (Xcode 16 or later). The package builds in the Swift 6
  language mode.
- iOS 15, macOS 12, tvOS 15, watchOS 8 or visionOS 1, or later.
- No third-party dependencies. The package uses Foundation, CryptoKit and the
  Security framework.

## Installation

Each release is a version tag on this repository; see
[tags](https://github.com/vaifstudio/vaif-swift/tags) for the versions
available. 1.0.0 is the first supported release. Until it is tagged, add the
package from the `main` branch, with the `VaifClient` product, in
`Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/vaifstudio/vaif-swift.git", branch: "main"),
],
targets: [
    .target(name: "MyApp", dependencies: [
        .product(name: "VaifClient", package: "vaif-swift"),
    ]),
]
```

In Xcode, choose File > Add Package Dependencies, enter
`https://github.com/vaifstudio/vaif-swift.git`, and select "Branch" with
`main`.

The version rule in [Versioning](#versioning) applies once 1.0.0 is tagged:
then use `from: "1.0.0"` in `Package.swift`, or "Up to Next Major Version" from
1.0.0 in Xcode.

## Quick start

```swift
import VaifClient

let vaif = try VaifClient(projectId: "YOUR_PROJECT_ID", apiKey: "vk_pub_...")

_ = try await vaif.auth.signIn(email: "ada@example.com", password: "a strong password")

let todos = try await vaif.from("todos")
    .eq("done", false)
    .order("created_at", ascending: false)
    .limit(20)
    .list()

print("\(todos.count) open todos")
for todo in todos.data {
    print(todo["title"]?.stringValue ?? "")
}
```

Create one `VaifClient` per project and share it. It is `Sendable`, and its
`auth` client supplies the signed-in user's access token to every other call.

## Authentication and configuration

### API keys

Every API request carries the project's API key in the `x-vaif-key` header. Use a
`vk_pub_` key in apps. `vk_srv_` keys bypass row-level security and must never
ship in an app. Once a user signs in, requests also carry their access token
as a bearer token, and row-level security applies to that user.

### Client options

```swift
let vaif = try VaifClient(
    projectId: "YOUR_PROJECT_ID",
    apiKey: "vk_pub_...",
    baseURL: URL(string: "https://api.vaif.studio")!,
    timeout: 15,
    retry: .default,
    headers: ["X-App-Version": "1.4.2"],
    sessionStore: nil,
    urlSession: .shared
)
```

| Parameter | Default | Description |
|---|---|---|
| `projectId` | `nil` | The project's ID. Leave it out only for a VAIF Studio account client (see [Accounts and projects](#accounts-and-projects)). |
| `apiKey` | required | The project API key, sent as `x-vaif-key`. |
| `baseURL` | `https://api.vaif.studio` | The API origin. It must use https, except for `localhost`, `127.0.0.1` and `::1`. |
| `timeout` | `30` | The limit for each HTTP attempt, in seconds. |
| `retry` | `.default` | The retry policy for transient failures. `.none` disables retries. |
| `headers` | `[:]` | Extra headers sent with every API request. |
| `session` | `nil` | A session to start with. It is saved to the session store. |
| `sessionStore` | `nil` | Where the session is kept between launches. `nil` uses the Keychain; see [Session storage](#session-storage). |
| `urlSession` | `.shared` | The `URLSession` used for HTTP and WebSocket traffic. The SDK does not use its cookie storage. |

The initializer throws `VaifError` with kind `invalidArgument` for an empty
`projectId` or `apiKey`, a `timeout` that is not a positive, finite number of
seconds, a cleartext `baseURL`, or a `KeychainSessionStore` made for another
origin or project. It throws a `storage` error when `session` cannot be saved
and an older stored session cannot be deleted (see
[Session storage](#session-storage)).

### Retries and timeouts

GET, HEAD and OPTIONS requests are retried on HTTP 429, 500, 502, 503 and 504
and on network errors: up to 3 retries, waiting 1 second and doubling to at
most 30 seconds, with jitter, and honoring `Retry-After`. Other methods are
retried only when the request failed before a connection was opened, so a
write is never sent twice. Function calls marked `idempotent: true` are
retried like GET requests. Customize the policy with
`RetryPolicy(maxRetries:baseDelay:maxDelay:multiplier:retryOn:retryOnNetworkError:)`.

`timeout` is a hard limit for each attempt. Cancelling the calling task
cancels the request and throws `CancellationError`.

### Redirects

A redirect within the API's origin is followed. A redirect to another origin
is followed only for a GET or HEAD request, only to an https URL (http only
for `localhost`, `127.0.0.1` and `::1`), and without the API key, the access
token, cookies or the headers set with `headers:`.
A realtime connection never follows a redirect to another origin, because its
credentials are sent after the connection opens. Any other redirect fails
with code `INSECURE_REDIRECT`.

### Session storage

A client created without `sessionStore:` keeps the signed-in session in the
Keychain, using `KeychainSessionStore(projectId:baseURL:)`. The access token,
the rotating refresh token, the expiry and the user are stored as one
generic-password item (service `studio.vaif.client`, account
`session.<origin>.<projectId>`, for example
`session.https://api.vaif.studio.YOUR_PROJECT_ID`). The item records the API
origin and project it was saved for, so clients for one project on two
different APIs, such as staging and production, keep separate sessions, and a
session saved for another origin or project is never restored. The client
restores the session when it is created, saves every sign-in and refresh, and
deletes the item on sign-out.

On iOS, tvOS, watchOS and visionOS the item is readable after the device's
first unlock and stays on the device; it is not synced to iCloud Keychain. On
macOS the item is in the user's login keychain and is readable while that
keychain is unlocked, unless you pass `useDataProtectionKeychain: true` to
`KeychainSessionStore` (see below), which applies the iOS rule.

Every client for the same project and API shares the stored session. In a
server, or any process that acts for more than one user, pass
`MemorySessionStore()` to each client.

```swift
// Keep the session in memory only. It does not survive a relaunch.
let inMemory = try VaifClient(projectId: "YOUR_PROJECT_ID", apiKey: "vk_pub_...",
                              sessionStore: MemorySessionStore())

// Share the session with an app extension through a Keychain access group.
let shared = try VaifClient(projectId: "YOUR_PROJECT_ID", apiKey: "vk_pub_...",
                            sessionStore: KeychainSessionStore(projectId: "YOUR_PROJECT_ID",
                                                               accessGroup: "TEAMID.com.example.shared"))
```

A `KeychainSessionStore(projectId:baseURL:)` must name the client's own
project and `baseURL` (the default is `https://api.vaif.studio`); the client
initializer throws `invalidArgument` for a store made for another origin or
project.

To store the session somewhere else, conform a type to `SessionStore`
(`load()`, `save(_:)` and `clear()`). On macOS, pass
`useDataProtectionKeychain: true` to `KeychainSessionStore` to use the data
protection keychain; it requires a signed app with a keychain-access-groups
entitlement.

Session store failures are recorded in `await vaif.auth.sessionStoreError`.
When a new session cannot be saved, it stays in memory and the stored session
is deleted, so the next launch does not restore an older one. Sign-in calls,
`setSession` and the initializer's `session:` throw a `storage` error only if
an older session is still stored after that. `signOut()` throws a `storage`
error when the stored session could not be deleted; calling it again retries
the delete. Token refreshes never throw because of the store.

### Session lifecycle

Access tokens are refreshed 30 seconds before they expire. When the API
rejects a request's token with 401, the SDK refreshes once and sends the
request once more; a function's own 401 is not treated this way (see
[Functions](#functions)). Concurrent refreshes share one request. The
rotating refresh token arrives in the API's `project_refresh_token` cookie (or
in the response body when the API is configured for body mode); the SDK reads
it and sends it back itself.

To react to sign-in, refresh and sign-out:

```swift
Task {
    for await change in await vaif.auth.sessionChanges() {
        switch change.event {
        case .signedIn, .tokenRefreshed: print("signed in:", change.session?.user?.email ?? "")
        case .signedOut: print("signed out")
        }
    }
}
```

## Auth

End users of your project sign in against `/projects/:projectId/auth`.

```swift
let created = try await vaif.auth.signUp(email: "ada@example.com", password: "a strong password",
                                         metadata: ["plan": "free"])
if created.pendingVerification {
    print(created.message ?? "Check your email to verify the address.")
}

switch try await vaif.auth.signIn(email: "ada@example.com", password: "a strong password") {
case .session(let session):
    print("signed in as", session.user?.email ?? "")
case .mfaRequired(let challengeToken):
    try await vaif.auth.verifyMFA(challengeToken: challengeToken, code: totpCode)
}

let user = try await vaif.auth.getUser()
try await vaif.auth.requestPasswordReset(email: "ada@example.com")
try await vaif.auth.resetPassword(token: tokenFromEmail, newPassword: "a new strong password")
try await vaif.auth.signOut()
```

`signOut()` clears the session locally, then revokes it on the server. It
sends the refresh token with the request, so the server revokes the session
even when the access token has expired. A server failure is thrown after the
local sign-out; an already revoked session (401) is not an error.

### Multi-factor authentication (TOTP)

```swift
let enrollment = try await vaif.auth.enrollMFA()   // show enrollment.secret or otpauthUri once
let backupCodes = try await vaif.auth.confirmMFA(enrollToken: enrollment.enrollToken, code: totpCode)
let newBackupCodes = try await vaif.auth.regenerateMFACodes(code: totpCode)
try await vaif.auth.disableMFA(code: totpOrBackupCode)
```

### Sign in with Google or GitHub

```swift
let start = try await vaif.auth.getOAuthSignInURL(provider: "google", redirectURL: "myapp://callback")
// Keep start.state and start.codeVerifier, and open start.url with
// ASWebAuthenticationSession. When the callback arrives, confirm that its
// state equals start.state, then exchange the code:
let result = try await vaif.auth.exchangeOAuthCode(code: callbackCode, codeVerifier: start.codeVerifier)
```

The flow uses PKCE (S256), with a verifier and state from the system's secure
random source. The redirect URL must be on the project's list of redirect
URLs. `exchangeOAuthCode` returns a `SignInResult`, like `signIn`.

### Accounts and projects

A client created without `projectId` works with VAIF Studio accounts rather
than a project's users. VAIF Studio accounts are created and reset only in the
console, so that client's `signUp` and `requestPasswordReset` throw before
sending a request, with code `CONSOLE_ONLY` (`error.isConsoleOnly`). The
error's message gives the console address: `VaifError.consoleSignUpURL`
(`https://console.vaif.studio/register`) or `VaifError.consolePasswordResetURL`
(`https://console.vaif.studio/forgot-password`). OAuth and database queries on
that client throw `PROJECT_ID_REQUIRED`.

## Database

Queries run against `/v1/data/:projectId/:table`. A `Query` is a value type:
each modifier returns a new query, and invalid arguments are thrown by the
call that sends the request.

```swift
let todos = vaif.from("todos")

let page = try await todos
    .select("id", "title", "priority")
    .eq("owner_id", userId)
    .gte("priority", 2)
    .in("status", ["open", "blocked"])
    .order("priority", ascending: false)
    .limit(50)
    .list()
print(page.count, page.data)   // count: every matching row; data: this page

let open = try await todos.eq("done", false).count()
let second = try await todos.eq("done", false).paginate(page: 2, pageSize: 20)   // total, hasNext
let slice = try await todos.range(from: 20, to: 39).list()                       // inclusive

struct Todo: Codable, Sendable {
    let id: String
    let title: String
    let done: Bool
}
let typed = try await todos.ilike("title", "%milk%").list(as: Todo.self)
let one = try await todos.get("ROW_ID", as: Todo.self)   // kind .notFound if it does not exist
```

Filters (`eq`, `neq`, `gt`, `gte`, `lt`, `lte`, `like`, `ilike`, `in`) are
combined with AND. Use `where(_:)` for an OR group:

```swift
let urgent = try await todos.where(["OR": [
    ["field": "priority", "operator": "gte", "value": 3],
    ["field": "due_today", "value": true],   // the operator defaults to eq
]]).list()
```

`limit` accepts 1 to 1,000 rows.

### Writing rows

```swift
let created = try await todos.insert(["title": "Buy milk"] as Row)   // or any Encodable value
let many = try await todos.insertMany([["title": "Buy eggs"], ["title": "Buy bread"]])
let saved = try await todos.upsert(["email": "ada@example.com", "name": "Ada"], onConflict: ["email"])
let updated = try await todos.update("ROW_ID", ["done": true] as Row)
try await todos.delete("ROW_ID")

let archived = try await todos.eq("list_id", listId).updateMany(["archived": true])
let removed = try await todos.eq("done", true).lt("priority", 2).deleteMany()   // number of rows
```

`updateMany` and `deleteMany` use the bulk routes, which accept fewer filters
than a list query. `updateMany` accepts only `eq` filters with non-null
values, one per column. `deleteMany` accepts every filter method, once per
column and operator (`in` values must not contain commas), but no `where`
groups. A filter the bulk route would ignore, or no filter at all, is refused
before the request is sent, so a bulk write never affects more rows than the
query describes. `Row` is `[String: JSONValue]` and accepts literals.

## Storage

```swift
try await vaif.storage.upload("avatars/u1.png", data: pngData, contentType: "image/png")
let data = try await vaif.storage.download("avatars/u1.png")
// Valid for the project's signed URL lifetime, 10 minutes by default.
let downloadURL = try await vaif.storage.createSignedURL("avatars/u1.png")
let uploadURL = try await vaif.storage.createSignedUploadURL("exports/2026-10.zip", sizeBytes: zipSize,
                                                              contentType: "application/zip")

let listing = try await vaif.storage.list(bucket: "avatars", prefix: "u1/", limit: 100)
for file in listing.files { print(file.key, file.size) }
try await vaif.storage.delete("avatars/u1.png", bucket: "avatars")
```

`upload` requests a presigned URL signed for the exact size and content type,
then sends the bytes directly to the object store. `download` requests a
signed download URL and reads the object from it. The API key and access
token are never sent to those URLs. `upload`, `download`, `createSignedURL`
and `createSignedUploadURL` refuse a URL that is not https (http only for
`localhost`, `127.0.0.1` and `::1`) with code `INSECURE_STORAGE_URL`.

Objects can be up to 5 GiB. Without `bucket:`, `upload`, `download` and the
signed URL calls use the project's default bucket. `list` and `delete` take a
bucket name or ID and use the bucket management routes, which require a VAIF
Studio account with a role on the project; an app user's session is refused
there.

## Functions

```swift
let response = try await vaif.functions.invoke("send-email", body: ["to": "ada@example.com"])
let json = try response.json()   // or response.decode(MyType.self), response.text

let report = try await vaif.functions.invoke("report", method: "GET", path: "/daily", query: ["day": "mon"])
```

A response with a status outside 200 to 299 throws `VaifError`, with the
function's response in `body` and its headers in `headers`;
`error.header("X-Vaif-Run-Id")` identifies the run. Invocations are not
retried unless you pass `idempotent: true`.

A 401 from the function itself is thrown as it is: the SDK does not refresh
the session or run the function again. When the API rejects the session
token with 401, which it does before the function runs, the SDK refreshes
the session and sends the invocation once more.

## Realtime

```swift
let subscription = try await vaif.realtime.subscribe(
    table: "todos",
    filters: [.eq("owner_id", userId)],
    columns: ["id", "title", "done"]
)
do {
    for try await event in subscription.events {
        switch event.operation {
        case "DELETE": print("deleted", event.oldRecord ?? [:])
        default: print(event.operation, event.record ?? [:])
        }
    }
} catch {
    // The socket closed or the session ended. Subscribe again to resume.
}
await subscription.unsubscribe()
```

`subscribe` returns once the server acknowledges the subscription. Each
subscription uses its own WebSocket on `/realtime/ws`, over `wss` (plain `ws`
only for localhost). Credentials are sent in the first frame, never in the
URL, and a refreshed access token is sent to the server as it changes.
Row-level security applies to the events delivered. A consumer that falls
more than 256 events behind receives a `REALTIME_OVERFLOW` error. The SDK does
not reconnect automatically, and does not support broadcast or presence.

On watchOS, WebSocket connections are available only in the cases that
Apple's [TN3135: Low-level networking on watchOS](https://developer.apple.com/documentation/technotes/tn3135-low-level-networking-on-watchos)
describes, such as during an active audio session. Otherwise `subscribe`
throws a `network` error.

## Generated API operations

`vaif.operations` has one method for each operation in the VAIF Studio API's
OpenAPI document that has a typed success response, except the operations
the API answers only for VAIF platform staff: 775 in this version
(`OperationsClient.generatedCount`). Path parameters are strings; query
values, request bodies and JSON responses are `JSONValue`. Binary and
server-sent-event responses are returned as `FunctionResponse`.

```swift
let project = try await vaif.operations.getProjectsByProjectId(path: ["projectId": "YOUR_PROJECT_ID"])
let rows = try await vaif.operations.getV1DataByProjectIdByTable(
    path: ["projectId": "YOUR_PROJECT_ID", "table": "todos"], query: ["limit": 20])
```

The other 168 operations are listed, with the reason, in
`OperationsClient.ungenerated`: those without a typed contract, and the 134
staff-only operations, listed as `platform staff only`. The staff-only
operations are every operation under `/admin/*` and `/auth/impersonate/*`,
and those outside them: feature flags (`/flags`), enterprise contract and
invoice writes, Verament usage statistics (`GET /ai/copilot/stats`) and
documentation edits under `/docs`. Authentication, retries and errors work as for
the rest of the client. The files in `Sources/VaifClient/Generated/` are
generated; do not edit them by hand.

## Error handling

Every error the SDK throws, other than `CancellationError`, is a `VaifError`.
That includes a row, function response or realtime frame that does not decode
as expected (`badResponse`), and a request body or filter value that cannot be
encoded as JSON (`invalidArgument`).

```swift
do {
    _ = try await vaif.from("todos").get("ROW_ID")
} catch let error as VaifError {
    switch error.kind {
    case .notFound:
        print("no such row")
    case .rateLimited:
        print("retry after", error.retryAfter ?? 1, "seconds")
    default:
        print(error.kind, error.status ?? 0, error.code ?? "", error.message, error.requestId ?? "")
    }
}
```

| Property | Description |
|---|---|
| `kind` | The category of failure (below). |
| `status` | The HTTP status, or `nil` when no response was received. |
| `code` | A machine-readable code from the API (for example `INVALID_CREDENTIALS`) or from the SDK (below). |
| `message` | A description of the failure. |
| `details` | Additional details from the API, if any. |
| `requestId` | The API's request ID; include it when you contact support. |
| `retryAfter` | For `rateLimited`, the server's `Retry-After` value in seconds. |
| `body` | The decoded response body. For a function call, the function's response. |
| `headers` | The response headers, empty when no response was received. `header(_:)` reads one without regard to case. |

| Kind | Raised for |
|---|---|
| `validation` | HTTP 400 or 422. |
| `auth` | HTTP 401 or 403, or a call that needs a signed-in user when there is none. |
| `notFound` | HTTP 404. |
| `conflict` | HTTP 409. |
| `rateLimited` | HTTP 429. |
| `server` | HTTP 500 or above. |
| `request` | Any other status outside 200 to 299. |
| `network` | No usable response, or a realtime socket that closed. |
| `timeout` | An attempt that took longer than `timeout`. |
| `invalidArgument` | An argument rejected before any request was sent. |
| `badResponse` | A response, value or realtime frame that could not be decoded as expected. |
| `storage` | A session store failure. |

Codes set by the SDK:

| Code | Kind | Meaning |
|---|---|---|
| `NOT_SIGNED_IN` | `auth` | The call needs a signed-in user, or the user signed out while a refresh was in flight. |
| `NO_REFRESH_TOKEN` | `auth` | The session must be refreshed but has no refresh token. Sign in again. |
| `CONSOLE_ONLY` | `invalidArgument` | `signUp` or `requestPasswordReset` on a client without `projectId`. |
| `PROJECT_ID_REQUIRED` | `invalidArgument` | A project call on a client without `projectId`. |
| `BUCKET_NOT_FOUND` | `notFound` | `list` or `delete` named a bucket the project does not have. |
| `INSECURE_REDIRECT` | `request` | The response redirected to another origin in a way the SDK does not follow (see [Redirects](#redirects)). |
| `INSECURE_STORAGE_URL` | `badResponse` | The API returned a signed or upload URL that is not https. |
| `STORAGE_UPLOAD_FAILED` | the HTTP kind, or `network` or `timeout` | The object store refused or did not complete the upload. |
| `INVALID_REALTIME_URL` | `invalidArgument` | Realtime needs an https `baseURL` (http only for localhost). |
| `INVALID_CHANNEL` | `validation` | The server refused the subscription's table, filters or columns. |
| `REALTIME_OVERFLOW` | `network` | The consumer fell more than 256 events behind. |
| `REALTIME_BAD_REQUEST` | `validation` | The server closed the socket: bad request (close code 4000). |
| `REALTIME_UNAUTHORIZED`, `TOKEN_EXPIRED`, `REALTIME_FORBIDDEN` | `auth` | The server closed the socket: close codes 4001, 4002 and 4003. |
| `REALTIME_NOT_FOUND` | `notFound` | The server closed the socket: close code 4004. |
| `REALTIME_RATE_LIMITED` | `rateLimited` | The server closed the socket: close code 4029. |
| `REALTIME_CLOSED` | `network` | The socket closed for any other reason. |
| `REALTIME_BAD_FRAME` | `badResponse` | The server sent a frame that is not JSON. |
| `KEYCHAIN_<OSStatus>` | `storage` | The Keychain returned that `OSStatus`. |
| `SESSION_STORE_FAILED` | `storage` | A custom `SessionStore` threw an error that is not a `VaifError`. |

## Versioning

`VaifClient` follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
Depend on it with `from: "1.0.0"` to receive compatible updates.

A new major version is required for:

- removing or renaming a public type, method, property, parameter or enum
  case, or changing a public signature;
- adding a requirement to the `SessionStore` protocol;
- adding a case to `SignInResult` or `AuthStateChange.Event`;
- changing documented behavior, such as which requests are retried, where the
  session is stored, or the `kind` of an existing error;
- raising the minimum Swift or platform version.

Minor versions add functionality: new types and methods, new parameters with
default values, new generated operations, new error codes and new
`VaifError.Kind` cases. Include a `default` case when you switch over
`VaifError.Kind`. Patch versions contain fixes only. Changes are listed in
[CHANGELOG.md](CHANGELOG.md).

## Support

- Bugs and feature requests: open an issue in this repository.
- Security vulnerabilities: do not open an issue. Email security@vaif.studio
  as described in [SECURITY.md](SECURITY.md).
- Questions about your VAIF Studio account or project: email
  support@vaif.studio.

Contributions are described in [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT. See [LICENSE](LICENSE).
