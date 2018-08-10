import XCTest

@testable import LeafMarkdownTests

XCTMain([
    testCase(LeafTests.allTests),
    testCase(ServicesTests.allTests)
])
