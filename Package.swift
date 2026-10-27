// swift-tools-version: 6.0
// Swift 6 language mode (complete concurrency checking). Requires Xcode 16+ /
// Swift 6 toolchains; tests use swift-testing.

import PackageDescription

let package = Package(
    name: "VaifClient",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "VaifClient", targets: ["VaifClient"]),
    ],
    targets: [
        .target(
            name: "VaifClient",
            path: "Sources/VaifClient"
        ),
        .testTarget(
            name: "VaifClientTests",
            dependencies: ["VaifClient"],
            path: "Tests/VaifClientTests",
            resources: [.copy("Fixtures")]
        ),
    ]
)
