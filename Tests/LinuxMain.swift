import XCTest

@testable import LeafMarkdownTests

XCTMain([
    testCase(LeafTests.allTests),
    testCase(ProviderTests.allTests)
])
