//
//  UserDefaultsHelper.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 08.07.23.
//

import Foundation

enum UserDefaultsKeys {
    static let MIN_COIN = "_min"
    static let MAX_COIN = "_max"
    static let HISTORY_OF_COINS = "history"
}

extension UserDefaults {
    
    func saveObject<T: Codable>(_ object: T?, key: String) {
        if let object = object {
            if let data = try? JSONEncoder().encode(object) {
                UserDefaults.standard.set(data, forKey: key)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    private func getObject<T: Codable>(class: T?, key: String) -> T? {
        if let data = UserDefaults.standard.data(forKey: key),
           let object = try? JSONDecoder().decode(T.self, from: data) {
            return object
        } else {
            return nil
        }
    }
    
    func addHistoryItem(_ coin: Coin, historyModel: [HistoryItem]? = nil) {
        var histories: [HistoryItem] = []
        if let result = UserDefaults.standard.getObject(class: historyModel, key: UserDefaultsKeys.HISTORY_OF_COINS) {
            histories = result
        }
        let historyItem = HistoryItem(coin: coin, timestamp: Date().timeIntervalSince1970)
        histories.append(historyItem)
        UserDefaults.standard.saveObject(histories, key: UserDefaultsKeys.HISTORY_OF_COINS)
    }
    
    func getCoin(key: String, coinModel: Coin? = nil) -> Coin? {
        return UserDefaults.standard.getObject(class: coinModel, key: key)
    }
    
    func getHistories(key: String, historyModel: [HistoryItem]? = nil) -> [HistoryItem]? {
        return UserDefaults.standard.getObject(class: historyModel, key: key)
    }

}
