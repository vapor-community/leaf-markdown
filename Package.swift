import PackageDescription

let package = Package(
    name: "vapor-markdown",
    targets: [
    	Target(name: "vapor-markdown-example", dependencies: ["vapor-markdown"])
    ],
    dependencies: [
    	.Package(url: "https://github.com/vapor/vapor.git", majorVersion: 0, minor: 17),
    	.Package(url: "https://github.com/czechboy0/cmark.swift.git", majorVersion: 0, minor: 1)
    ]
)
