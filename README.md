# Leaf Markdown

[![Language](https://img.shields.io/badge/Swift-5.2-brightgreen.svg)](http://swift.org)
[![Build Status](https://github.com/vapor-community/leaf-markdown/workflows/CI/badge.svg?branch=main)](https://github.com/vapor-community/leaf-markdown/actions)
[![codecov](https://codecov.io/gh/vapor-community/leaf-markdown/branch/main/graph/badge.svg)](https://codecov.io/gh/vapor-community/leaf-markdown)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/vapor-community/leaf-markdown/main/LICENSE)

A Markdown renderer for Vapor and Leaf. This uses the [Vapor Markdown](https://github.com/vapor/markdown) package to wrap [cmark](https://github.com/github/cmark-gfm) (though a [fork](https://github.com/brokenhandsio/cmark-gfm) is used to make it work with Swift PM), so it understands [Common Mark](http://commonmark.org). A quick reference guide for Common Mark can be found [here](http://commonmark.org/help/). It also supports [Github Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

## Usage

Once set up, you can use it in your Leaf template files like any other tag:

```swift
#markdown(myMarkdown)
```

Where you have passed `myMarkdown` into the view as something like:

```markdown
# Hey #

Check out my *awesome* markdown! It is easy to use in `tags`
```

## Setup

### Add as dependency

Add Leaf Markdown as a dependency in your `Package.swift` file:

```swift
    dependencies: [
        ...,
        .package(name: "LeafMarkdown", url: "https://github.com/vapor-community/leaf-markdown.git", .upToNextMajor(from: "3.0.0")),
    ]
```

Then add the dependency to your target:

```swift
.target(
    name: "App",
    dependencies: [
        // ...
        "LeafMarkdown"
    ],
    // ...
)
```

### Register with Leaf

Register the tag with Leaf so Leaf knows about it:

```swift
app.leaf.tags["markdown"] = Markdown()
```

Don't forget to import LeafMarkdown in the file you register the tag with `import LeafMarkdown`.
