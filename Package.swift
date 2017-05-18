import PackageDescription

let package = Package(
    name: "LeafMarkdown",
    dependencies: [
    	.Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2),
        .Package(url: "https://github.com/vapor/leaf-provider.git", majorVersion: 1),
    	.Package(url: "https://github.com/vapor-community/markdown.git", majorVersion: 0)
    ]
)
