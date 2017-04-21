import XCTest
import Vapor

@testable import Leaf
@testable import LeafMarkdown

class LeafTests: XCTestCase {
    static var allTests = [
        ("testRunTag", testRunTag),
        ("testNilParameterDoesNotCrashLeaf", testNilParameterDoesNotCrashLeaf),
    ]
    
    func testRunTag() {
        let tag = Markdown()
        let inputMarkdown = "# This is a test\n\nWe have some text in a tag"
        let expectedHtml = "<h1>This is a test</h1>\n<p>We have some text in a tag</p>\n"
        
        do {
            let node = try run(tag: tag, context: inputMarkdown.makeNode(in: nil), arguments: [.constant(value: inputMarkdown)])
            XCTAssertEqual(node?.string, expectedHtml)
        }
        catch {
            XCTFail()
        }
    }
    
    func testNilParameterDoesNotCrashLeaf() {
        let tag = Markdown()
        let expectedHtml = ""
        
        do {
            let node = try run(tag: tag, context: nil, arguments: [])
            XCTAssertEqual(node?.string, expectedHtml)
        }
        catch  {
            XCTFail("Markdown Tag threw exception")
        }
    }
}

extension LeafTests {    
    func run(tag: Tag, context node: Node, arguments: [Argument]) throws -> Node? {
        let context = Context(node)
        
        return try tag.run(
            stem: Stem(DataFile(workDir: "")),
            context: context,
            tagTemplate: TagTemplate(name: "", parameters: [], body: nil),
            arguments: arguments
        )
    }
}
