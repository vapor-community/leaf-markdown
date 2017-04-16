import PackageDescription

let package = Package(
    name: "LeafMarkdown",
    dependencies: [
    	.Package(url: "https://github.com/vapor/vapor.git", Version(2,0,0, prereleaseIdentifiers: ["beta"])),
        .Package(url: "https://github.com/vapor/leaf-provider.git", Version(1,0,0, prereleaseIdentifiers: ["beta"])),
    	.Package(url: "https://github.com/brokenhandsio/SwiftMarkdown.git", majorVersion: 0, minor: 1)
    ]
)
