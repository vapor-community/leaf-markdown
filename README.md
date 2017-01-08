# VaporMarkdown

A Markdown renderer for Vapor and Leaf.

## Use

Once set up, you can use it in your Leaf template files like any other tag:

```
#markdown(myMarkdown)
```

Where you have passed `myMarkdown` into the view as somthing like:

```
# Hey

Check out my *awesome* markdown! It is easy to use in `tags`
```

## Setup

### Add as dependency

Add VaporMarkdown as a dependency in your `Package.swift` file:

```
    dependencies: [
	...,
        .Package(url: "https://github.com/brokenhandsio/VaporMarkdown", majorVersion: 0, minor: 1)
    ]
```

### Register with Leaf

During your setup (for example, in `main.swift`), register your tag as so:

```
if let leaf = drop.view as? LeafRenderer {
    leaf.stem.register(Markdown())
}
```

Don't forget to import VaporMarkdown in the file you register the tag in with `import VaporMarkdown`
