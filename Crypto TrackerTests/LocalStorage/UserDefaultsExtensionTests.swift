//
//  UserDefaultsExtensionTests.swift
//  Crypto TrackerTests
//
//  Created by Nihad Allahveranov on 12.07.23.
//

import XCTest
@testable import Crypto_Tracker

class UserDefaultsExtensionTests: XCTestCase {
    var userDefaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        userDefaults = UserDefaults.standard
    }
    
    func test_save_object() {
        // Arrange
        let objectToSave = TestObject(name: "Test", age: 25)
        let key = "TestKey"
        
        // Act
        userDefaults.saveObject(objectToSave, key: key)
        
        // Assert
        let savedData = userDefaults.data(forKey: key)
        XCTAssertNotNil(savedData)  // Verify that the data was saved to UserDefaults
        
        if let savedData = savedData {
            let decodedObject = try? JSONDecoder().decode(TestObject.self, from: savedData)
            XCTAssertEqual(decodedObject?.name, objectToSave.name)  // Verify that the saved object can be decoded and has the same name
            XCTAssertEqual(decodedObject?.age, objectToSave.age)  // Verify that the saved object can be decoded and has the same age
        }
    }
    
    func test_add_history_item() {
        // Arrange
        let coin = Coin(name: "Bitcoin", rate: 100)
        let historyItem = HistoryItem(coin: coin, timestamp: Date().timeIntervalSince1970)
        let key = UserDefaultsKeys.HISTORY_OF_COINS
        userDefaults.removeObject(forKey: key)  // Clear any existing data
        
        // Act
        userDefaults.addHistoryItem(coin, historyModel: nil)
        let retrievedHistory: [HistoryItem]? = userDefaults.getHistories(key: key)
        
        // Assert
        XCTAssertNotNil(retrievedHistory)  // Verify that the history items were retrieved from UserDefaults
        XCTAssertEqual(retrievedHistory?.count, 1)  // Verify that the retrieved history has one item
        XCTAssertEqual(retrievedHistory?.first?.coin.name, historyItem.coin.name)  // Verify that the retrieved history item has the same coin name
        XCTAssertEqual(retrievedHistory?.first?.coin.rate, historyItem.coin.rate)  // Verify that the retrieved history item has the same coin symbol
    }
    
    func test_get_coin() {
        // Arrange
        let coin = Coin(name: "Bitcoin", rate: 100)
        let key = coin.name + UserDefaultsKeys.MIN_COIN
        let encodedData = try? JSONEncoder().encode(coin)
        userDefaults.set(encodedData, forKey: key)
        
        // Act
        let retrievedCoin: Coin? = userDefaults.getCoin(key: key)
        
        // Assert
        XCTAssertNotNil(retrievedCoin)  // Verify that the coin was retrieved from UserDefaults
        XCTAssertEqual(retrievedCoin?.name, coin.name)  // Verify that the retrieved coin has the same name
        XCTAssertEqual(retrievedCoin?.rate, coin.rate)  // Verify that the retrieved coin has the same symbol
    }
    
    func test_get_histories() {
        // Arrange
        let coin = Coin(name: "Bitcoin", rate: 100)
        let historyItem = HistoryItem(coin: coin, timestamp: Date().timeIntervalSince1970)
        let key = UserDefaultsKeys.HISTORY_OF_COINS
        let historyItems: [HistoryItem] = [historyItem]
        let encodedData = try? JSONEncoder().encode(historyItems)
        userDefaults.set(encodedData, forKey: key)
        
        // Act
        let retrievedHistories: [HistoryItem]? = userDefaults.getHistories(key: key)
        
        // Assert
        XCTAssertNotNil(retrievedHistories)  // Verify that the history items were retrieved from UserDefaults
        XCTAssertEqual(retrievedHistories?.count, 1)  // Verify that the retrieved histories have one item
        XCTAssertEqual(retrievedHistories?.first?.coin.name, historyItem.coin.name)  // Verify that the retrieved history item has the same coin name
        XCTAssertEqual(retrievedHistories?.first?.coin.rate, historyItem.coin.rate)  // Verify that the retrieved history item has the same coin symbol
    }
    
    override func tearDown() {
        userDefaults = nil
        super.tearDown()
    }
}

// TestObject struct for testing purposes
struct TestObject: Codable, Equatable {
    let name: String
    let age: Int
}
