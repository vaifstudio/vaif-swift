# Changelog

All notable changes to `VaifClient` are recorded in this file. The package
follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html); see
"Versioning" in the README for what counts as a breaking change.

## 1.0.0 (unreleased)

The first supported release. It replaces the retracted 0.1.0 and 0.1.1 tags,
which called API routes that the VAIF Studio API does not serve. The API is
new: code written for 0.1.x does not compile against 1.0.0.

### Added

- `VaifClient` (`Sendable`): base URL validation (https, except for
  `localhost`, `127.0.0.1` and `::1`; any other http base URL throws
  `invalidArgument`, so the API key and access token never travel in
  cleartext), a hard timeout per attempt, `RetryPolicy` (replays only
  GET/HEAD/OPTIONS or calls marked idempotent, plus any request that never
  connected), custom headers, cancellation as `CancellationError`, and one
  typed `VaifError` (with the response `headers`) for every failure,
  including values that do not decode as the requested type. A redirect to
  another origin is followed only for GET and HEAD, to https (http only for
  localhost), and without credentials or custom headers; a realtime
  connection follows none.
- `AuthClient` actor on `/projects/:projectId/auth`: `signUp`, `signIn`
  (`.session` or `.mfaRequired`), `verifyMFA`, `refreshSession` (one request
  for concurrent callers; the rotating refresh token is read from the cookie
  or, in body mode, the body), `signOut`, `getUser`, `requestPasswordReset`,
  `resetPassword`, `setSession` and `sessionChanges()`. Access tokens refresh
  30 seconds before expiry and once after the API rejects one with 401.
- TOTP MFA management: `enrollMFA`, `confirmMFA`, `disableMFA` and
  `regenerateMFACodes`.
- Google and GitHub sign-in: `getOAuthSignInURL` (PKCE S256 with a verifier
  and state from the system's secure random source) and `exchangeOAuthCode`.
- Session persistence through `SessionStore`. A client created without
  `sessionStore:` keeps the session in the Keychain
  (`KeychainSessionStore(projectId:baseURL:)`: one item per API origin and
  project; on iOS, tvOS, watchOS and visionOS, and on macOS with
  `useDataProtectionKeychain`, readable after first unlock and this device
  only, otherwise in the macOS login keychain; undecodable data is
  deleted). The item records its origin and project, a session saved for
  another is not restored, and the client refuses a Keychain store made for
  another origin or project. `sessionStore: MemorySessionStore()` opts out of
  the Keychain. The client restores the stored session at start-up and saves
  every change; failures are recorded in `auth.sessionStoreError`.
- A session that cannot be saved stays in memory and the stored session is
  deleted, so the next launch cannot restore an older one. Sign-in calls,
  `setSession` and `VaifClient(session:)` throw `.storage` when an older
  session is still stored after that. `signOut` retries a failed delete once
  and throws `.storage` while the session is still stored. Refreshes never
  throw because of the store.
- A client without `projectId` is a platform-account client: `signUp` and
  `requestPasswordReset` throw `CONSOLE_ONLY` before any request
  (`VaifError.isConsoleOnly`), with a message that gives the console address
  (`VaifError.consoleSignUpURL` or `VaifError.consolePasswordResetURL`);
  OAuth and data queries throw `PROJECT_ID_REQUIRED`.
  Platform auth uses the `refresh_token` cookie.
- Value-type `Query` on `/v1/data/:projectId/:table`: filters, `where`,
  `select`, `order`, `limit`, `offset`, inclusive `range`, `count`, `list` and
  `list(as:)`, `first`, `paginate`, `get` and `get(_:as:)`, `insert` (any
  `Encodable`), `insertMany`, `upsert`, `update`, `delete`, and `updateMany` /
  `deleteMany` on the bulk routes, which refuse any filter the server would
  ignore rather than widen the write.
- `StorageClient`: `upload` (a presigned PUT signed for the exact size and
  content type), `download` (reads a signed download URL), `createSignedURL`,
  `createSignedUploadURL` (size required), and `list` / `delete` by bucket
  name or UUID. `StorageFile.size` is an `Int64`, so a listing that includes
  an object over 2 GiB decodes on Apple Watch. Signed and upload URLs must be
  https (http only for localhost), and no API credential is sent to them.
- `FunctionsClient.invoke` with method, path, query and headers. A function's
  own 401 is thrown as it is; only the API's 401 refreshes the session.
- `RealtimeClient.subscribe(table:filters:columns:)` over Foundation
  WebSockets: `wss` (plain `ws` only for localhost; any other scheme throws
  `INVALID_REALTIME_URL`), credentials in the first frame, server
  acknowledgment, typed `RealtimeFilter`s, a heartbeat that re-sends a
  refreshed access token, a bounded buffer and typed error frames. No
  automatic reconnect, broadcast or presence.
- `OperationsClient`: one method per typed operation in the API's SDK
  OpenAPI document, except the staff-only operations (775 in this version,
  `OperationsClient.generatedCount`).
  The 168 operations without a method are listed, with the reason, in
  `OperationsClient.ungenerated`: the routes without a typed contract and the
  134 staff-only operations (reason `platform staff only`).
- Staff-only operations are not generated, including the ones outside
  `/admin`: every operation under `/admin/*` and `/auth/impersonate/*`, plus
  feature flags (`/flags`), enterprise contract and invoice writes,
  `GET /ai/copilot/stats` and documentation edits under `/docs`. The API
  answers them only for VAIF platform staff.
- The shared SDK conformance cases run in `swift test` against a fake API.

### Changed

- Swift tools 6.0 and the Swift 6 language mode (Xcode 16 or later).
- The `User-Agent` header is `vaif-swift/1.0.0`.

### Removed

- The 0.1.x sources: the `/db/*` and `/ai/chat` clients, the SwiftUI
  wrappers, TypeGen and the old Keychain helper. `KeychainSessionStore`
  replaces the Keychain helper.

## 0.1.1 and 0.1.0 (retracted)

These tags called `/db/*` and `/ai/chat` routes that the VAIF Studio API does
not serve. They are left in place, because a SwiftPM tag cannot be withdrawn
from clones and caches, but they are not supported. Use 1.0.0 or later.
