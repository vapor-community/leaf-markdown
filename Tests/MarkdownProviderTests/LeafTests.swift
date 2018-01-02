import XCTest
import Vapor

@testable import Leaf
@testable import MarkdownProvider

class LeafTests: XCTestCase {
    static var allTests = [
        ("testRunTag", testRunTag),
        ("testNilParameterDoesNotCrashLeaf", testNilParameterDoesNotCrashLeaf),
    ]

    var renderer: LeafRenderer!
    let template = "#markdown(data)"

    override func setUp() {
        let queue = DispatchEventLoop(label: "io.brokenhands.markdown-provider.test")
        let tag = Markdown()
        self.renderer = LeafRenderer(config: LeafConfig(tags: [tag.name: tag]), on: queue)
    }
    
    func testRunTag() {
        let inputMarkdown = "# This is a test\n\nWe have some text in a tag"
        let data = LeafData.dictionary(["data": .string(inputMarkdown)])
        let expectedHtml = "<h1>This is a test</h1>\n<p>We have some text in a tag</p>\n"

        do {
            let result = try renderer.render(template, context: LeafContext(data: data)).blockingAwait()
            XCTAssertEqual(result, expectedHtml)
        }
        catch {
            XCTFail()
        }
    }
    
    func testNilParameterDoesNotCrashLeaf() {
        let data = LeafData.dictionary(["data": .null])
        let expectedHtml = ""

        do {
            let result = try renderer.render(template, context: LeafContext(data: data)).blockingAwait()
            XCTAssertEqual(result, expectedHtml)
        }
        catch {
            XCTFail()
        }
    }
}
