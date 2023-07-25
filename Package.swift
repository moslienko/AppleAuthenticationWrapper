// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AppleAuthenticationWrapper",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "AppleAuthenticationWrapper",
            targets: ["AppleAuthenticationWrapper"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AppleAuthenticationWrapper",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "AppleAuthenticationWrapperTests",
            dependencies: ["AppleAuthenticationWrapper"],
            path: "Tests"
        ),
    ]
)
