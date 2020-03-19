// swift-tools-version:5.1

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
        .package(url: "https://github.com/vapor-community/markdown.git", from: "0.5.0"),
        .package(url: "https://github.com/vapor/leaf-kit.git", from: "1.0.0-rc.1"),
    ],
    targets: [
        .target(name: "LeafMarkdown", dependencies: ["LeafKit", "SwiftMarkdown"]),
        .testTarget(name: "LeafMarkdownTests", dependencies: ["LeafMarkdown", "LeafKit"]),
    ]
)
