//
//  CoinHistoryViewModelTests.swift
//  Crypto TrackerTests
//
//  Created by Nihad Allahveranov on 12.07.23.
//

import XCTest
@testable import Crypto_Tracker

class CoinHistoryViewModelTests: XCTestCase {
    var coinHistoryViewModel: CoinHistoryViewModel!

    override func setUp() {
        super.setUp()
        coinHistoryViewModel = CoinHistoryViewModel()
    }

    func test_get_coin_history_with_histories_available() {
        // Arrange
        let coinName = "Bitcoin"
        let history1 = HistoryItem(coin: Coin(name: "Bitcoin", rate: 10000), timestamp: 1626969600) // July 22, 2021 20:00:00
        let histories = [history1]
        UserDefaults.standard.mockHistories = histories

        // Act
        coinHistoryViewModel.getCoinHistory(coinName: coinName)

        // Assert
        XCTAssertEqual(coinHistoryViewModel.histories, ["10000.0$ - 2021, 22 Jul 20:00:00",])
    }

    override func tearDown() {
        coinHistoryViewModel = nil
        super.tearDown()
    }
}

extension UserDefaults {
    var mockHistories: [HistoryItem]? {
        get {
            return getHistories(key: UserDefaultsKeys.HISTORY_OF_COINS)
        }
        set {
            saveObject(newValue, key: UserDefaultsKeys.HISTORY_OF_COINS)
        }
    }
}
