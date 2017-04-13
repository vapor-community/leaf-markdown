# Leaf Markdown

[![Language](https://img.shields.io/badge/Swift-3-brightgreen.svg)](http://swift.org)
[![Build Status](https://travis-ci.org/brokenhandsio/LeafMarkdown.svg?branch=master)](https://travis-ci.org/brokenhandsio/LeafMarkdown)
[![codecov](https://codecov.io/gh/brokenhandsio/LeafMarkdown/branch/master/graph/badge.svg)](https://codecov.io/gh/brokenhandsio/LeafMarkdown)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/brokenhandsio/LeafMarkdown/master/LICENSE)

A Markdown renderer for Vapor and Leaf. This uses the [Vapor Markdown](https://github.com/vapor/markdown) package to wrap [cmark](https://github.com/jgm/cmark) (though a [fork](https://github.com/vapor/cmark) is used to make it work with Swift PM), so it understands [Common Mark](http://commonmark.org). A quick reference guide for Common Mark can be found [here](http://commonmark.org/help/).

## Use

Once set up, you can use it in your Leaf template files like any other tag:

```swift
#markdown(myMarkdown)
```

Where you have passed `myMarkdown` into the view as somthing like:

```markdown
# Hey #

Check out my *awesome* markdown! It is easy to use in `tags`
```

## Setup

### Add as dependency

Add LeafMarkdown as a dependency in your `Package.swift` file:

```swift
    dependencies: [
        ...,
        .Package(url: "https://github.com/brokenhandsio/LeafMarkdown", majorVersion: 0)
    ]
```

### Add the Provider

You can add a provider to you `Droplet`, which will do all of the setup for you and register your tag. Just add it as so:

```swift
let drop = Droplet()
try drop.addProvider(LeafMarkdown.Provider.self)
```


### Register with Leaf

Alternatively, you can also directly add the Tag onto your `LeafRenderer` if desired. During your setup (for example, in `main.swift`), register your tag as so:

```swift
if let leaf = drop.view as? LeafRenderer {
    leaf.stem.register(Markdown())
}
```

Don't forget to import LeafMarkdown in the file you register the tag or add the provider in with `import LeafMarkdown`
