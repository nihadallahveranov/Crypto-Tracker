//
//  URLParameterEncoderTests.swift
//  Crypto TrackerTests
//
//  Created by Nihad Allahveranov on 12.07.23.
//

import XCTest
@testable import Crypto_Tracker

class URLParameterEncoderTests: XCTestCase {
    var encoder: URLParameterEncoder!
        
    override func setUp() {
        super.setUp()
        encoder = URLParameterEncoder()
    }
    
    func test_encode_sets_URLQueryItems() throws {
        // Arrange
        var urlRequest = URLRequest(url: URL(string: "https://api.coingecko.com/api/v3/simple/price")!)
        let parameters: [String: Any] = [
            "ids": "bitcoin,ethereum,ripple",
            "vs_currencies": "usd"
        ]
        
        // Act
        try encoder.encode(urlRequest: &urlRequest, with: parameters)
        
        // Assert
        let urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)!
        XCTAssertEqual(urlComponents.queryItems?.count, 2)  // Verify that the URL has two query items
        XCTAssertTrue(urlComponents.queryItems?.contains(URLQueryItem(name: "ids", value: "bitcoin,ethereum,ripple")) ?? false)  // Verify the presence of query item "ids=bitcoin,ethereum,ripple"
        XCTAssertTrue(urlComponents.queryItems?.contains(URLQueryItem(name: "vs_currencies", value: "usd")) ?? false)  // Verify the presence of query item "vs_currencies=usd"
    }
    
    func test_encode_leaves_URL_unchanged_when_parameters_empty() throws {
        // Arrange
        var urlRequest = URLRequest(url: URL(string: "https://api.coingecko.com/api/v3/simple/price")!)
        let parameters: [String: Any] = [:]  // Empty parameters
        
        // Act
        try encoder.encode(urlRequest: &urlRequest, with: parameters)
        
        // Assert
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://api.coingecko.com/api/v3/simple/price")  // Verify that the URL remains unchanged
    }
    
    func test_encode_sets_content_type_header_if_not_present() throws {
        // Arrange
        var urlRequest = URLRequest(url: URL(string: "https://api.coingecko.com/api/v3/simple/price")!)
        let parameters: [String: Any] = [
            "ids": "bitcoin,ethereum,ripple",
            "vs_currencies": "usd"
        ]
        
        // Act
        try encoder.encode(urlRequest: &urlRequest, with: parameters)
        
        // Assert
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/x-www-form-urlencoded; charset=utf-8")  // Verify that the "Content-Type" header is set to the correct value
    }
    
    func test_encode_does_not_set_content_type_header_if_already_present() throws {
        // Arrange
        var urlRequest = URLRequest(url: URL(string: "https://api.coingecko.com/api/v3/simple/price")!)
        urlRequest.setValue("text/plain", forHTTPHeaderField: "Content-Type")  // Set a custom "Content-Type" header
        let parameters: [String: Any] = [
            "ids": "bitcoin,ethereum,ripple",
            "vs_currencies": "usd"
        ]
        
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
