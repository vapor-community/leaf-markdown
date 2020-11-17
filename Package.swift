// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "LeafMarkdown",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "LeafMarkdown", targets: ["LeafMarkdown"]),
    ],
    dependencies: [
        .package(name: "SwiftMarkdown", url: "https://github.com/vapor-community/markdown.git", from: "0.6.1"),
        .package(url: "https://github.com/vapor/leaf-kit.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "LeafMarkdown", dependencies: [
            .product(name: "LeafKit", package: "leaf-kit"),
            .product(name: "SwiftMarkdown", package: "SwiftMarkdown"),
        ]),
        .testTarget(name: "LeafMarkdownTests", dependencies: [
            .target(name: "LeafMarkdown"),
            .product(name: "LeafKit", package: "leaf-kit"),
        ]),
    ]
)
