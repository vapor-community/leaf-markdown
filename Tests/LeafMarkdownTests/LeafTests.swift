import XCTest
@testable import LeafKit
import LeafMarkdown
import NIO

class MarkdownTests: XCTestCase {
    // MARK: - Properties
    
    var renderer: LeafRenderer!
    var ast: [Syntax]!
    var markdownTag: Markdown!

    // MARK: - Overrides
    
    override func setUpWithError() throws {
        var lexer = LeafLexer(name: "markdowntest", template: "#markdown(data)")
        let tokens = try lexer.lex()
        var parser = LeafParser(name: "markdowntest", tokens: tokens)
        ast = try parser.parse()
        markdownTag = Markdown()
    }

    // MARK: - Helper
    func render(context: [String: LeafData]) throws -> String {
        var serializer = LeafSerializer(
            ast: ast,
            context: context,
            tags: ["markdown": markdownTag]
        )
        let view = try serializer.serialize()
        return view.getString(at: view.readerIndex, length: view.readableBytes) ?? ""
    }
    
    // MARK: - Tests

    func testRunTag() throws {
        let inputMarkdown = "# This is a test\n\nWe have some text in a tag"
        let expectedHtml = "<h1>This is a test</h1>\n<p>We have some text in a tag</p>\n"
        let resultString = try render(context: ["data": .string(inputMarkdown)])
        XCTAssertEqual(resultString, expectedHtml)
    }

    func testNilParameterDoesNotCrashLeaf() throws {
        let expectedHtml = ""
        let resultString = try render(context: ["data": .trueNil])
        XCTAssertEqual(resultString, expectedHtml)
    }

    func testStripHtml() throws {
        let inputMarkdown = "<br>"
        let expectedHtml = "<!-- raw HTML omitted -->\n"

        let resultString = try render(context: ["data": .string(inputMarkdown)])
        XCTAssertEqual(resultString, expectedHtml)
    }

    func testRejectBadData() throws {
        XCTAssertThrowsError(try render(context: ["data": .dictionary(["something": .string("somethingelese")])]))
    }

    func testDoNotStripHtml() throws {
        markdownTag = Markdown(options: [.unsafe])

        let inputMarkdown = "<br>"
        let expectedHtml = "<br>\n"

        let resultString = try render(context: ["data": .string(inputMarkdown)])
        XCTAssertEqual(resultString, expectedHtml)
    }
}
