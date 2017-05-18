import XCTest

@testable import MarkdownProviderTests

XCTMain([
    testCase(LeafTests.allTests),
    testCase(ProviderTests.allTests)
])
