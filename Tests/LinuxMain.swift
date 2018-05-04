import XCTest

@testable import LeafMakrdownTests

XCTMain([
    testCase(LeafTests.allTests),
    testCase(ProviderTests.allTests)
])
