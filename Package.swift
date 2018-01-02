// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "MarkdownProvider",
    products: [
        .library(name: "MarkdownProvider", targets: ["MarkdownProvider"]),
    ],
    dependencies: [
    	.package(url: "https://github.com/vapor/vapor.git", .branch("beta")),
        .package(url: "https://github.com/vapor/leaf.git", .branch("beta")),
        .package(url: "https://github.com/vapor-community/markdown.git", .upToNextMajor(from: "0.4.0")),
    ],
    targets: [
        .target(name: "MarkdownProvider", dependencies: ["Vapor", "Leaf", "SwiftMarkdown"]),
        .testTarget(name: "MarkdownProviderTests", dependencies: ["MarkdownProvider"]),
    ]
)
