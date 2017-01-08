import PackageDescription

let package = Package(
    name: "VaporMarkdown",
    targets: [
    	Target(name: "vapor-markdown-example", dependencies: ["VaporMarkdown"])
    ],
    dependencies: [
    	.Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 3),
    	.Package(url: "https://github.com/czechboy0/cmark.swift.git", majorVersion: 0, minor: 1)
    ]
)
