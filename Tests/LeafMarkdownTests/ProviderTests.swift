import XCTest
import Vapor

@testable import LeafMarkdown

class ProviderTests: XCTestCase {
    static var allTests = [
        ("testProviderCreation", testProviderAddsTagToLeaf),
        ("testProviderGracefullyHandlesNonLeafRenderer", testProviderGracefullyHandlesNonLeafRenderer)
    ]
    
    func testProviderAddsTagToLeaf() {
        let drop = Droplet()
        let leafProvider = LeafMarkdownProvider()
        leafProvider.boot(drop)
        
        guard let leaf = drop.view as? LeafRenderer else {
            XCTFail()
            return
        }
        
        XCTAssertNotNil(leaf.stem.tags[LeafMarkdownTag().name])
    }
    
    func testProviderGracefullyHandlesNonLeafRenderer() {
        let drop = Droplet()
        let stubbedRenderer = StubbedRenderer(viewsDir: "")
        drop.view = stubbedRenderer
        let leafProvider = LeafMarkdownProvider()
        leafProvider.boot(drop)
        XCTAssert(true, "We should reach this point")
    }
}

struct StubbedRenderer: ViewRenderer {
    init(viewsDir: String) {}
    
    func make(_ path: String, _ context: Node) throws -> View {
        return try View(bytes: "Stubbed renderer".bytes)
    }
}