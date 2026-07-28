import Testing
@testable import LeafKit
import LeafMarkdown
import NIO

@Suite("Markdown Tag Tests")
struct MarkdownTagTests {
    // MARK: - Properties

    let ast: [Syntax]
    let markdownTag = MarkdownTag()

    // MARK: - Setup

    init() throws {
        var lexer = LeafLexer(name: "markdowntest", template: "#markdown(data)")
        let tokens = try lexer.lex()
        var parser = LeafParser(name: "markdowntest", tokens: tokens)
        self.ast = try parser.parse()
    }

    // MARK: - Helper

    func render(context: [String: LeafData]) throws -> String {
        var serializer = LeafSerializer(
            ast: ast,
            tags: ["markdown": markdownTag],
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

    @Test("Raw HTML is passed through")
    func rawHtmlIsPassedThrough() throws {
        let inputMarkdown = "<br>"
        let expectedHtml = "<br>\n"

        let resultString = try render(context: ["data": .string(inputMarkdown)])
        #expect(resultString == expectedHtml)
    }
}
