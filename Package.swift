// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VaifClient",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "VaifClient",
            targets: ["VaifClient"]
        ),
    ],
    targets: [
        .target(
            name: "VaifClient",
            path: "Sources/VaifClient",
            linkerSettings: [
                .linkedFramework("Security"),
            ]
        ),
        .testTarget(
            name: "VaifClientTests",
            dependencies: ["VaifClient"],
            path: "Tests/VaifClientTests"
        ),
    ]
)
