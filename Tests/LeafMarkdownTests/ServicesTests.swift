import XCTest
import Vapor
import Leaf

import LeafMarkdown

class ServicesTests: XCTestCase {
    static var allTests = [
        ("testTagsCanBeAddedToServices", testTagsCanBeAddedToServices),
    ]

    func testTagsCanBeAddedToServices() throws {
        var services = Services.default()
        try services.register(LeafProvider())
        var tags = LeafTagConfig.default()
        tags.use(Markdown(), as: "markdown")
        services.register(tags)
        let app = try Application(services: services)
        let renderer = try app.make(LeafRenderer.self)

        XCTAssertNotNil(renderer.tags[Markdown().name])
    }
}
