// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "LeafMarkdown",
    products: [
        .library(name: "LeafMarkdown", targets: ["LeafMarkdown"]),
    ],
    dependencies: [
    	.package(url: "https://github.com/vapor/template-kit.git", from: "1.4.0"),
        .package(url: "https://github.com/vapor-community/markdown.git", from: "0.6.1"),
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0"),
    ],
    targets: [
        .target(name: "LeafMarkdown", dependencies: ["TemplateKit", "SwiftMarkdown"]),
        .testTarget(name: "LeafMarkdownTests", dependencies: ["LeafMarkdown", "Leaf"]),
    ]
)
