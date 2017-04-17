import XCTest
import Vapor
import LeafProvider

@testable import LeafMarkdown

class ProviderTests: XCTestCase {
    static var allTests = [
        ("testProviderCreation", testProviderAddsTagToLeaf),
        ("testProviderGracefullyHandlesNonLeafRenderer", testProviderGracefullyHandlesNonLeafRenderer)
    ]
    
    func testProviderAddsTagToLeaf() throws {
        let drop = try Droplet()
        drop.view = LeafRenderer(viewsDir: "views")
        let leafProvider = LeafMarkdown.Provider()
        leafProvider.boot(drop)
        
        guard let leaf = drop.view as? LeafRenderer else {
            XCTFail()
            return
        }
        
        XCTAssertNotNil(leaf.stem.tags[Markdown().name])
    }
    
    func testProviderGracefullyHandlesNonLeafRenderer() throws {
        let drop = try Droplet()
        drop.view = StubbedRenderer()
        let leafProvider = LeafMarkdown.Provider()
        leafProvider.boot(drop)
        XCTAssert(true, "We should reach this point")
    }
}

struct StubbedRenderer: ViewRenderer {
    func make(_ path: String, _ context: Node) throws -> View {
        return View(bytes: "Stubbed renderer".bytes)
    }
}
