//
//  ParameterEncoderTests.swift
//  Crypto TrackerTests
//
//  Created by Nihad Allahveranov on 12.07.23.
//

import XCTest
@testable import Crypto_Tracker

class ParameterEncodingTests: XCTestCase {
    var urlRequest: URLRequest!
    
    override func setUp() {
        super.setUp()
        urlRequest = URLRequest(url: URL(string: "https://api.coingecko.com/api/v3")!)
    }
    
    func test_encode_URL_encoding() throws {
        // Arrange
        let encoding: ParameterEncoding = .urlEncoding
        let urlParameters: [String: Any] = ["key": "value"]
        
        // Act
        try encoding.encode(urlRequest: &urlRequest, bodyParameters: nil, urlParameters: urlParameters)
        
        // Assert
        let urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)!
        XCTAssertEqual(urlComponents.queryItems?.count, 1)  // Verify that the URL has one query item
        XCTAssertTrue(urlComponents.queryItems?.contains(URLQueryItem(name: "key", value: "value")) ?? false)  // Verify the presence of query item "key=value"
    }
    
    func test_encode_JSON_encoding() throws {
        // Arrange
        let encoding: ParameterEncoding = .jsonEncoding
        let bodyParameters: [String: Any] = ["key": "value"]
        
        // Act
        try encoding.encode(urlRequest: &urlRequest, bodyParameters: bodyParameters, urlParameters: nil)
        
        // Assert
        XCTAssertNotNil(urlRequest.httpBody)  // Verify that the HTTP body is not nil
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")  // Verify that the "Content-Type" header is set to "application/json"
    }
    
    func test_encode_URL_and_JSON_encoding() throws {
        // Arrange
        let encoding: ParameterEncoding = .urlAndJsonEncoding
        let urlParameters: [String: Any] = ["key1": "value1"]
        let bodyParameters: [String: Any] = ["key2": "value2"]
        
        // Act
        try encoding.encode(urlRequest: &urlRequest, bodyParameters: bodyParameters, urlParameters: urlParameters)
        
        // Assert
        let urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)!
        XCTAssertEqual(urlComponents.queryItems?.count, 1)  // Verify that the URL has one query item
        XCTAssertTrue(urlComponents.queryItems?.contains(URLQueryItem(name: "key1", value: "value1")) ?? false)  // Verify the presence of query item "key1=value1"
        XCTAssertNotNil(urlRequest.httpBody)  // Verify that the HTTP body is not nil
    }
    
    override func tearDown() {
        urlRequest = nil
        super.tearDown()
    }
}
