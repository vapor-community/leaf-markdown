import PackageDescription

let package = Package(
    name: "LeafMarkdown",
    dependencies: [
    	.Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 4),
    	.Package(url: "https://github.com/brokenhandsio/SwiftMarkdown.git", majorVersion: 0, minor: 1)
    ]
)
