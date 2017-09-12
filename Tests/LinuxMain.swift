#if os(Linux)

import XCTest
@testable import PaystackProviderTests

XCTMain([
    testCase(PaystackProviderTests.allTests),
])

#endif