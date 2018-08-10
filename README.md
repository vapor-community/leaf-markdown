# Leaf Markdown

[![Language](https://img.shields.io/badge/Swift-4-brightgreen.svg)](http://swift.org)
[![Build Status](https://travis-ci.org/vapor-community/leaf-markdown.svg?branch=master)](https://travis-ci.org/vapor-community/leaf-markdown)
[![codecov](https://codecov.io/gh/vapor-community/leaf-markdown/branch/master/graph/badge.svg)](https://codecov.io/gh/vapor-community/leaf-markdown)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/vapor-community/leaf-markdown/master/LICENSE)

A Markdown renderer for Vapor and Leaf. This uses the [Vapor Markdown](https://github.com/vapor/markdown) package to wrap [cmark](https://github.com/jgm/cmark) (though a [fork](https://github.com/brokenhandsio/cmark-gfm) is used to make it work with Swift PM), so it understands [Common Mark](http://commonmark.org). A quick reference guide for Common Mark can be found [here](http://commonmark.org/help/). It also supports [Github Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

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
        .package(url: "https://github.com/vapor-community/leaf-markdown.git", .upToNextMajor(from: "2.0.0"))
    ]
```

### Register with Leaf

To add the tag to Leaf, add it to your `LeafTagConfig`:

```swift
try services.register(LeafProvider())
var tags = LeafTagConfig.default()
tags.use(Markdown(), as: "markdown")
services.register(tags)
```

**Note:** it's important that you register the `LeafProvider` first otherwise this will override your `LeafTagConfig`.

Don't forget to import LeafMarkdown in the file you register the tag with `import LeafMarkdown`.
