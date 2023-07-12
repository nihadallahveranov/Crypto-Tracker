//
//  JSONParameterEncoderTests.swift
//  Crypto TrackerTests
//
//  Created by Nihad Allahveranov on 12.07.23.
//

import XCTest
@testable import Crypto_Tracker

class JSONParameterEncoderTest: XCTestCase {
    var encoder: JSONParameterEncoder!
        
    override func setUp() {
        super.setUp()
        encoder = JSONParameterEncoder()
    }
    
    func test_encode_sets_HTTP_body_with_data() throws {
        // Arrange
        var urlRequest = URLRequest(url: URL(string: "https://api.coingecko.com/api/v3")!)
        let parameters: [String: Any] = ["key": "value"]
        
        // Act
        try encoder.encode(urlRequest: &urlRequest, with: parameters)
        
        // Assert
        XCTAssertNotNil(urlRequest.httpBody)  // Verify that the HTTP body is not nil
        XCTAssertEqual(urlRequest.httpBody, try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted))  // Verify that the HTTP body matches the serialized JSON data
    }
    
    func test_encode_sets_content_type_header_if_not_present() throws {
        // Arrange
        var urlRequest = URLRequest(url: URL(string: "https://api.coingecko.com/api/v3")!)
        let parameters: [String: Any] = ["key": "value"]
        
        // Act
        try encoder.encode(urlRequest: &urlRequest, with: parameters)
        
        // Assert
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")  // Verify that the "Content-Type" header is set to "application/json"
    }
    
    func test_encode_does_not_set_content_type_header_if_already_present() throws {
        // Arrange
        var urlRequest = URLRequest(url: URL(string: "https://api.coingecko.com/api/v3")!)
        urlRequest.setValue("text/plain", forHTTPHeaderField: "Content-Type")  // Set a custom "Content-Type" header
        let parameters: [String: Any] = ["key": "value"]
        
        // Act
        try encoder.encode(urlRequest: &urlRequest, with: parameters)
        
        // Assert
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "text/plain")  // Verify that the "Content-Type" header remains unchanged
    }
    
    override func tearDown() {
        encoder = nil
        super.tearDown()
    }
}
