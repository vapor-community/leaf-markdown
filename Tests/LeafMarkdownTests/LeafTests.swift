import XCTest
@testable import LeafKit
import LeafMarkdown

class MarkdownTests: XCTestCase {
    // MARK: - Properties
    
    var renderer: LeafRenderer!
    var template: ResolvedDocument!

    // MARK: - Overrides
    
    override func setUp() {
        let loop = EmbeddedEventLoop()
        let config = LeafConfiguration(rootDirectory: Process().currentDirectoryPath)
        var tags = defaultTags
        tags["markdown"] = Markdown()
        self.renderer = LeafRenderer(
            configuration: config,
            tags: tags,
            files: NIOLeafFiles(fileio: .init(threadPool: .init(numberOfThreads: 1))),
            eventLoop: loop
        )
        
        do {
            var lexer = LeafLexer(name: "markdowntest", template: "#markdown(data)")
            let tokens = try lexer.lex()
            var parser = LeafParser(name: "markdowntest", tokens: tokens)
            let syntax = try parser.parse()
            let unresolved = UnresolvedDocument(name: "markdowntest", raw: syntax)
            let resolver = ExtendResolver(document: unresolved, dependencies: [])
            template = try resolver.resolve(rootDirectory: config.rootDirectory)
        } catch {
            XCTFail()
        }
    }
    
    // MARK: - Tests

    func testRunTag() throws {
        let inputMarkdown = "# This is a test\n\nWe have some text in a tag"
        let expectedHtml = "<h1>This is a test</h1>\n<p>We have some text in a tag</p>\n"

        let result = try renderer.render(template, context: ["data": .string(inputMarkdown)])
        let resultString = result.getString(at: 0, length: result.readableBytes)
        XCTAssertEqual(resultString, expectedHtml)
    }

    func testNilParameterDoesNotCrashLeaf() throws {
        let expectedHtml = ""
        let result = try renderer.render(template, context: ["data": .null])
        let resultString = result.getString(at: 0, length: result.readableBytes)
        XCTAssertEqual(resultString, expectedHtml)
    }

    func testStripHtml() throws {
        let inputMarkdown = "<br>"
        let expectedHtml = "<!-- raw HTML omitted -->\n"

        let result = try renderer.render(template, context: ["data": .string(inputMarkdown)])
        let resultString = result.getString(at: 0, length: result.readableBytes)
        XCTAssertEqual(resultString, expectedHtml)

    }

    func testDoNotStripHtml() throws {
        let loop = EmbeddedEventLoop()
        let config = LeafConfiguration(rootDirectory: Process().currentDirectoryPath)
        var tags = defaultTags
        tags["markdown"] = Markdown(options: [.init(rawValue: 1 << 17)])
        let renderer = LeafRenderer(
            configuration: config,
            tags: tags,
            files: NIOLeafFiles(fileio: .init(threadPool: .init(numberOfThreads: 1))),
            eventLoop: loop
        )

        let inputMarkdown = "<br>"
        let expectedHtml = "<br>\n"

        let result = try renderer.render(template, context: ["data": .string(inputMarkdown)])
        let resultString = result.getString(at: 0, length: result.readableBytes)
        XCTAssertEqual(resultString, expectedHtml)
    }
}
