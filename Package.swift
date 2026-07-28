// swift-tools-version:6.1

import PackageDescription

let extraSettings: [SwiftSetting] = [
    .enableExperimentalFeature("SuppressedAssociatedTypesWithDefaults"),
    .enableExperimentalFeature("LifetimeDependence"),
    .enableExperimentalFeature("Lifetimes"),
    .enableUpcomingFeature("LifetimeDependence"),
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
    .enableUpcomingFeature("InferIsolatedConformances"),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("MemberImportVisibility"),
    .enableUpcomingFeature("InternalImportsByDefault"),
]

let package = Package(
    name: "LeafMarkdown",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "LeafMarkdown", targets: ["LeafMarkdown"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor-community/markdown.git", from: "0.6.1"),
        .package(url: "https://github.com/vapor/leaf-kit.git", from: "1.14.3"),
    ],
    targets: [
        .target(
            name: "LeafMarkdown",
            dependencies: [
                .product(name: "LeafKit", package: "leaf-kit"),
                .product(name: "SwiftMarkdown", package: "markdown"),
            ],
            swiftSettings: extraSettings
        ),
        .testTarget(
            name: "LeafMarkdownTests",
            dependencies: [
                .target(name: "LeafMarkdown"),
                .product(name: "LeafKit", package: "leaf-kit"),
            ],
            swiftSettings: extraSettings),
    ]
)
