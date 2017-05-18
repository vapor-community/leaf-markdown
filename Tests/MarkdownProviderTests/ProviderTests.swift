import XCTest
import Vapor
import LeafProvider

@testable import MarkdownProvider

class ProviderTests: XCTestCase {
    static var allTests = [
        ("testProviderCreation", testProviderAddsTagToLeaf),
        ("testProviderGracefullyHandlesNonLeafRenderer", testProviderGracefullyHandlesNonLeafRenderer)
    ]
    
    func testProviderAddsTagToLeaf() throws {
        var config = Config([:])
        try config.set("droplet.view", "leaf")
        try config.addProvider(LeafProvider.Provider.self)
        let drop = try Droplet(config)
        let leafProvider = MarkdownProvider.Provider()
        leafProvider.boot(drop)
        
        guard let leaf = drop.view as? LeafRenderer else {
            XCTFail()
            return
        }
        
        XCTAssertNotNil(leaf.stem.tags[Markdown().name])
    }
    
    func testProviderGracefullyHandlesNonLeafRenderer() throws {
        let drop = try Droplet()
        let leafProvider = MarkdownProvider.Provider()
        leafProvider.boot(drop)
        XCTAssert(true, "We should reach this point")
    }
}
