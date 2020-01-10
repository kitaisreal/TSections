// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "TSections",
    platforms: [
        .macOS(.v10_10), .iOS(.v8), .tvOS(.v9), .watchOS(.v2)
    ],
    products: [
        .library(name: "TSections", targets: ["TSections"]),
    ],
    targets: [
        .target(name: "TSections", dependencies: [], path: "Sources"),
        .testTarget(name: "TSectionsTests", dependencies: ["TSections"], path: "Tests"),
    ],
    swiftLanguageVersions: [.v5]
)
