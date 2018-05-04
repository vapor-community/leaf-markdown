// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "LeafMarkdown",
    products: [
        .library(name: "LeafMarkdown", targets: ["LeafMarkdown"]),
    ],
    dependencies: [
    	.package(url: "https://github.com/vapor/vapor.git", from: "3.0.0-rc"),
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0-rc"),
        .package(url: "https://github.com/vapor-community/markdown.git", .upToNextMajor(from: "0.4.0")),
    ],
    targets: [
        .target(name: "LeafMarkdown", dependencies: ["Vapor", "Leaf", "SwiftMarkdown"]),
        .testTarget(name: "LeafMarkdownTests", dependencies: ["LeafMarkdown"]),
    ]
)
