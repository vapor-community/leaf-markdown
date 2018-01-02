import XCTest
import Vapor
import Leaf

@testable import MarkdownProvider

class ProviderTests: XCTestCase {
    static var allTests = [
        ("testProviderCreation", testProviderAddsTagToLeaf),
        ("testProviderGracefullyHandlesNonLeafRenderer", testProviderGracefullyHandlesNonLeafRenderer)
    ]

    func testProviderAddsTagToLeaf() throws {
        var services = Services.default()
        let leafProvider = LeafProvider()
        services.use(leafProvider)
        services.use(MarkdownProvider.Provider.self)
        let app = try Application(services: services)

        let renderer = try app.make(LeafRenderer.self, for: ViewRenderer.self)

        XCTAssertNotNil(renderer.tags[Markdown().name])
    }

    func testProviderGracefullyHandlesNonLeafRenderer() throws {
        let app = try Application()
        let leafProvider = MarkdownProvider.Provider()
        try leafProvider.boot(app)
        XCTAssert(true, "We should reach this point")
    }
}
