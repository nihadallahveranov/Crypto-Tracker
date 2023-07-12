//
//  RouterTests.swift
//  Crypto TrackerTests
//
//  Created by Nihad Allahveranov on 12.07.23.
//

import XCTest
import Alamofire
@testable import Crypto_Tracker

class RouterTests: XCTestCase {
    var router: Router<CryptoAPI>!
    
    override func setUp() {
        super.setUp()
        router = Router<CryptoAPI>()
    }
    
    func test_currency_rates_request_success() {
        // Arrange
        let endpoint: CryptoAPI = .currencyRates
        
        // Act
        let expectation = XCTestExpectation(description: "Currency rates request completion")
        router.request(endpoint) { (data, response, error) in
            // Assert
            XCTAssertNil(error)  // Verify that no error occurred
            XCTAssertNotNil(data)  // Verify that data is not nil
            XCTAssertNotNil(response)  // Verify that response is not nil
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    override func tearDown() {
        router = nil
        super.tearDown()
    }
}
