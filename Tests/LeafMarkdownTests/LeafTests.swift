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

//        let result = try renderer.render(path: template, context: ["data": .string(inputMarkdown)])
//        let resultString = result.getString(at: 0, length: result.readableBytes)
        let resultString = try render(context: ["data": .string(inputMarkdown)])
        XCTAssertEqual(resultString, expectedHtml)
    }

//    func testNilParameterDoesNotCrashLeaf() throws {
//        let expectedHtml = ""
//        let result = try renderer.render(path: template, context: ["data": .nil])
//        let resultString = result.getString(at: 0, length: result.readableBytes)
//        XCTAssertEqual(resultString, expectedHtml)
//    }
//
//    func testStripHtml() throws {
//        let inputMarkdown = "<br>"
//        let expectedHtml = "<!-- raw HTML omitted -->\n"
//
//        let result = try renderer.render(template, context: ["data": .string(inputMarkdown)])
//        let resultString = result.getString(at: 0, length: result.readableBytes)
//        XCTAssertEqual(resultString, expectedHtml)
//    }
//
//    func testRejectBadData() throws {
//        let data = LeafData.lazy { .null }
//        XCTAssertThrowsError(try renderer.render(template, context: ["data": data]))
//    }
//
//    func testDoNotStripHtml() throws {
//        let loop = EmbeddedEventLoop()
//        let config = LeafConfiguration(rootDirectory: Process().currentDirectoryPath)
//        var tags = defaultTags
//        tags["markdown"] = Markdown(options: [.unsafe])
//        let renderer = LeafRenderer(
//            configuration: config,
//            tags: tags,
//            files: NIOLeafFiles(fileio: .init(threadPool: .init(numberOfThreads: 1))),
//            eventLoop: loop
//        )
//
//        let inputMarkdown = "<br>"
//        let expectedHtml = "<br>\n"
//
//        let result = try renderer.render(template, context: ["data": .string(inputMarkdown)])
//        let resultString = result.getString(at: 0, length: result.readableBytes)
//        XCTAssertEqual(resultString, expectedHtml)
//    }
}
