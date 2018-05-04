import XCTest

@testable import LeafMakrdownTests

XCTMain([
    testCase(LeafTests.allTests),
    testCase(ServicesTests.allTests)
])
