import Testing
@testable import LeafKit
import LeafMarkdown
import NIO

@Suite("Markdown Tag Tests")
struct MarkdownTagTests {
    // MARK: - Properties

    let ast: [Syntax]

    // MARK: - Setup

    init() throws {
        var lexer = LeafLexer(name: "markdowntest", template: "#markdown(data)")
        let tokens = try lexer.lex()
        var parser = LeafParser(name: "markdowntest", tokens: tokens)
        self.ast = try parser.parse()
    }

    // MARK: - Helper

    func render(context: [String: LeafData], options: MarkdownOptions = []) throws -> String {
        var serializer = LeafSerializer(
            ast: ast,
            tags: ["markdown": MarkdownTag(options: options)],
            ignoreUnfoundImports: false
        )
        let view = try serializer.serialize(context: context)
        return view.getString(at: view.readerIndex, length: view.readableBytes) ?? ""
    }

    // MARK: - Tests

    @Test("Renders markdown to HTML")
    func runTag() throws {
        let inputMarkdown = "# This is a test\n\nWe have some text in a tag"
        let expectedHtml = "<h1>This is a test</h1>\n<p>We have some text in a tag</p>\n"
        let resultString = try render(context: ["data": .string(inputMarkdown)])
        #expect(resultString == expectedHtml)
    }

    @Test("A nil parameter does not crash Leaf")
    func nilParameterDoesNotCrashLeaf() throws {
        let resultString = try render(context: ["data": .trueNil])
        #expect(resultString.isEmpty)
    }

    @Test("A non-string parameter throws")
    func rejectBadData() throws {
        #expect(throws: MarkdownTag.Error.self) {
            try render(context: ["data": .dictionary(["something": .string("somethingelese")])])
        }
    }

    @Test("Raw HTML is stripped by default")
    func stripHtml() throws {
        let inputMarkdown = "<br>"
        let expectedHtml = "<!-- raw HTML omitted -->\n"

        let resultString = try render(context: ["data": .string(inputMarkdown)])
        #expect(resultString == expectedHtml)
    }

    @Test("Raw HTML is preserved when unsafe is set")
    func doNotStripHtml() throws {
        let inputMarkdown = "<br>"
        let expectedHtml = "<br>\n"

        let resultString = try render(context: ["data": .string(inputMarkdown)], options: [.unsafe])
        #expect(resultString == expectedHtml)
    }

    @Test("Unsafe link schemes are stripped by default")
    func stripUnsafeLinks() throws {
        let inputMarkdown = "[click](javascript:alert(1))"
        let expectedHtml = "<p><a href=\"\">click</a></p>\n"

        let resultString = try render(context: ["data": .string(inputMarkdown)])
        #expect(resultString == expectedHtml)
    }

    @Test("Text and attributes are escaped")
    func escapesTextAndAttributes() throws {
        let inputMarkdown = "5 < 6 & 7 > 2\n\n![x](a.png \"\\\" onerror=alert(1) x=\\\"\")"

        let resultString = try render(context: ["data": .string(inputMarkdown)])
        #expect(resultString.contains("5 &lt; 6 &amp; 7 &gt; 2"))
        // The quotes in the title are escaped, so the payload cannot break out of the attribute.
        #expect(resultString.contains("title=\"&quot; onerror=alert(1) x=&quot;\""))
    }

    @Test("GitHub Flavored Markdown extensions are enabled")
    func gfmExtensions() throws {
        let inputMarkdown = "| a | b |\n| - | - |\n| 1 | 2 |\n\n~~struck~~"

        let resultString = try render(context: ["data": .string(inputMarkdown)])
        #expect(resultString.contains("<table>"))
        #expect(resultString.contains("<del>struck</del>"))
    }
}
