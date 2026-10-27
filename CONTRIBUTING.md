# Contributing

This repository is the published copy of the VAIF Studio Swift SDK. VAIF
Studio maintains the SDK in its main repository and publishes each release
here, so the history of this repository consists of release commits.

## Bugs and feature requests

Open an issue with the bug report or feature request template. For a bug,
include the `VaifClient` version, the platform and OS version, your Xcode or
Swift version, a short code sample that reproduces the problem, and the
`kind`, `code`, `status` and `requestId` of any `VaifError` that was thrown.
Remove API keys, access tokens and personal data before you post.

Report security vulnerabilities privately, as described in
[SECURITY.md](SECURITY.md), not in an issue.

## Local development

You need Xcode 16 or later.

```sh
swift build
swift test
```

`swift test` needs the swift-testing framework, which ships with Xcode. With
only the Command Line Tools selected, run `./scripts/test.sh` instead: it
runs `swift test` and adds the framework's search paths when they are needed.

To build for the other platforms the package supports, as CI does:

```sh
for platform in iOS tvOS watchOS visionOS; do
  xcodebuild build -scheme VaifClient -destination "generic/platform=$platform"
done
```

The test suite runs against a fake HTTP server and a fake WebSocket, so it
needs no network access or account. It includes:

- Keychain tests, which run where the login Keychain is writable and skip
  otherwise. Set `VAIF_REQUIRE_KEYCHAIN=1` to make a skip fail, as CI does.
- Integration tests against a real API, which run only when
  `VAIF_IT_BASE_URL`, `VAIF_IT_PROJECT_ID` and `VAIF_IT_API_KEY` are set.
  They sign up a user and create and delete rows and files, so use a project
  that holds no real data. `VAIF_IT_TABLE` names a table with a text column
  `name` (default `sdk_items`).
- Live conformance tests, which run the shared test cases against a VAIF
  Studio API on the same machine. They run only when `CONFORMANCE_LIVE=1` is
  set, and fail when `API_URL` or `CONSOLE_ORIGIN` is not a loopback URL. They
  create a project, a table and a storage bucket on that API, and an account
  when no access token is given. The comment at the top of
  `Tests/VaifClientTests/ConformanceLive.swift` lists every setting.

`Sources/VaifClient/Generated/` and `Tests/VaifClientTests/Fixtures/core.json`
are generated from the VAIF Studio API's OpenAPI document and shared test
cases. Do not edit them by hand; describe the change you need in an issue.

## Pull requests

Pull requests are welcome. Because this repository is published from VAIF
Studio's main repository, pull requests are not merged here. The maintainers
review each one and, when it is accepted, apply the change in the main
repository with you credited as a co-author. The change then appears here in
the next release.

Before you open a pull request:

- keep it to one change, and explain the problem it solves;
- add tests that fail without the change;
- run `swift test` (or `./scripts/test.sh`);
- follow the existing style: Swift 6 language mode, `Sendable` types,
  `async`/`await`, and documentation comments on public API.

By opening a pull request, you agree that your contribution is licensed under
the [MIT License](LICENSE) that covers this repository.

## Code of conduct

Everyone who takes part in this repository's issues and pull requests is
expected to follow the [code of conduct](CODE_OF_CONDUCT.md).
