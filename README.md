# Leaf Markdown

[![Language](https://img.shields.io/badge/Swift-6.1-brightgreen.svg)](http://swift.org)
[![Build Status](https://github.com/vapor-community/leaf-markdown/workflows/CI/badge.svg?branch=main)](https://github.com/vapor-community/leaf-markdown/actions)
[![codecov](https://codecov.io/gh/vapor-community/leaf-markdown/branch/main/graph/badge.svg)](https://codecov.io/gh/vapor-community/leaf-markdown)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/vapor-community/leaf-markdown/main/LICENSE)

A Markdown renderer for Vapor and Leaf. This wraps [swift-cmark](https://github.com/swiftlang/swift-cmark), the Swift project's fork of [cmark-gfm](https://github.com/github/cmark-gfm), so it understands [CommonMark](http://commonmark.org). A quick reference guide for CommonMark can be found [here](http://commonmark.org/help/). It also supports [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/) — tables, strikethrough, task lists and autolinks are all enabled.

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
        .package(url: "https://github.com/vapor-community/leaf-markdown.git", .upToNextMajor(from: "4.0.0")),
    ]
```

Then add the dependency to your target:

```swift
.target(
    name: "App",
    dependencies: [
        // ...
        .product(name: "LeafMarkdown", package: "leaf-markdown"),
    ],
    // ...
)
```

### Register with Leaf

Register the tag with Leaf so Leaf knows about it:

```swift
app.leaf.tags["markdown"] = MarkdownTag()
```

Don't forget to import LeafMarkdown in the file you register the tag with `import LeafMarkdown`.

## Options

`MarkdownTag` accepts a `MarkdownOptions` set to control how markdown is parsed and rendered:

```swift
app.leaf.tags["markdown"] = MarkdownTag(options: [.smart, .footnotes])
```

### Rendering

| Option | Effect |
| --- | --- |
| `.unsafe` | Render raw HTML and unsafe links instead of stripping them. See the warning below. |
| `.sourcePos` | Include a `data-sourcepos` attribute on all block elements. |
| `.hardBreaks` | Render soft breaks as hard line breaks. |
| `.noBreaks` | Render soft breaks as spaces. |
| `.githubPreLang` | Use GitHub-style `<pre lang="x">` for code blocks instead of `<pre><code class="language-x">`. |
| `.tablePreferStyleAttributes` | Align table cells with `style` attributes instead of `align` attributes. |

### Parsing

| Option | Effect |
| --- | --- |
| `.smart` | Convert straight quotes to curly, `---` to em dashes and `--` to en dashes. |
| `.footnotes` | Parse footnotes. |
| `.validateUTF8` | Replace illegal UTF-8 sequences with U+FFFD before parsing. |
| `.liberalHTMLTag` | Be liberal in interpreting inline HTML tags. |
| `.strikethroughDoubleTilde` | Only parse strikethroughs surrounded by exactly two tildes. |
| `.fullInfoString` | Include a code block's full info string in a `data-meta` attribute. |

## Rendering untrusted markdown

By default, raw HTML in the markdown source is replaced with an `<!-- raw HTML omitted -->` comment, and links using `javascript:`, `vbscript:`, `file:` and most `data:` schemes are replaced with an empty destination. Text and attribute values are escaped.

```swift
// "<br>"                      -> "<!-- raw HTML omitted -->"
// "[click](javascript:x())"   -> "<a href=\"\">click</a>"
MarkdownTag()
```

Passing `.unsafe` turns all of that off:

```swift
// "<br>"                      -> "<br>"
MarkdownTag(options: [.unsafe])
```

Only use `.unsafe` for markdown you control. If you are rendering markdown submitted by your users, leave it off.
