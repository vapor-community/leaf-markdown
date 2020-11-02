import XCTest
@testable import LeafKit
import LeafMarkdown

class MarkdownTests: XCTestCase {
    // MARK: - Properties
    
    var renderer: LeafRenderer!
    var eventLoop: EventLoop!
    var leafSource: StubbedLeafSource!
    let templateString = "#markdown(data)"
    let template = "template"

    // MARK: - Overrides
    override func setUp() {
        eventLoop = EmbeddedEventLoop()
        LeafConfiguration.started = false
        LeafConfiguration.entities = .leaf4Core

        leafSource = StubbedLeafSource(templateName: template, templateContents: templateString)
        LeafConfiguration.entities.use(Markdown(), asFunction: "markdown")
        self.renderer = LeafRenderer(cache: DefaultLeafCache(), sources: .singleSource(leafSource), eventLoop: eventLoop)
    }

    override func tearDownWithError() throws {
        try eventLoop.syncShutdownGracefully()
    }
    
    // MARK: - Tests

    func testRunTag() throws {
        let inputMarkdown = "# This is a test\n\nWe have some text in a tag"
        let expectedHtml = "<h1>This is a test</h1>\n<p>We have some text in a tag</p>\n"

        let resultString = try getRenderedString(input: .string(inputMarkdown))
        XCTAssertEqual(resultString, expectedHtml)
    }

    func testStripHtml() throws {
        let inputMarkdown = "<br>"
        let expectedHtml = "<!-- raw HTML omitted -->\n"

        let resultString = try getRenderedString(input: .string(inputMarkdown))
        XCTAssertEqual(resultString, expectedHtml)
    }

    func testRejectBadData() throws {
        XCTAssertThrowsError(try getRenderedString(input: .init(nilLiteral: ())))
    }

    func testDoNotStripHtml() throws {
        LeafConfiguration.started = false
        LeafConfiguration.entities = .leaf4Core
        LeafConfiguration.entities.use(Markdown(options: .unsafe), asFunction: "markdown")
        self.renderer = LeafRenderer(cache: DefaultLeafCache(), sources: .singleSource(leafSource), eventLoop: eventLoop)

        let inputMarkdown = "<br>"
        let expectedHtml = "<br>\n"

        let resultString = try getRenderedString(input: .string(inputMarkdown))
        XCTAssertEqual(resultString, expectedHtml)
    }

    private func getRenderedString(input: LeafData) throws -> String {
        let result = try renderer.render(template: template, context: ["data": input]).wait()
        let resultString = String(decoding: result.readableBytesView, as: UTF8.self)
        return resultString
    }
}

struct LeafMarkdownTestError: Error {}
