import XCTest
@testable import LeafKit
import LeafMarkdown

class MarkdownTests: XCTestCase {
    // MARK: - Properties
    
    var renderer: LeafRenderer!
    var eventLoop: EventLoop!
//    var template: ResolvedDocument!
    let templateString = "#markdown(data)"
    let template = "template"

    // MARK: - Overrides
    override func setUp() {
        eventLoop = EmbeddedEventLoop()

        let leafSource = StubbedLeafSource(templateName: template, templateContents: templateString)
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

        let resultString = try getRenderedString(input: inputMarkdown)
        XCTAssertEqual(resultString, expectedHtml)
    }

//    func testNilParameterDoesNotCrashLeaf() throws {
//        let expectedHtml = ""
//        let result = try renderer.render(template, context: ["data": .null])
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

    private func getRenderedString(input: String) throws -> String {
        let result = try renderer.render(template: template, context: ["data": .string(input)]).wait()
        let resultString = String(decoding: result.readableBytesView, as: UTF8.self)
        return resultString
    }
}

struct LeafMarkdownTestError: Error {}
