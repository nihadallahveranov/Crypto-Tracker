//
//  ForegroundTaskManager.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 10.07.23.
//

import UIKit
import UserNotifications

class ForegroundTaskManager {
    
    static let shared = ForegroundTaskManager()
    private let repo = CryptoRepository()
    let currencies = ["Bitcoin", "Ethereum", "Ripple"]
    var coinRates: [Double] = []
    
    internal func fetchCoinRates(completion: @escaping (_ coinRates: [Double]) -> ()) {
        repo.getCurrencyRates() { response, error in
            guard let bitcoin = response?.bitcoin.usd,
                    let ethereum = response?.ethereum.usd,
                    let ripple = response?.ripple.usd else
            {
                return
            }
            self.coinRates = [bitcoin, ethereum, ripple]
            completion(self.coinRates)
        }
    }
    
    internal func performForeground() {
        var message = ""
        for (index, coinRate) in coinRates.enumerated() {
            var minCoinModel: Coin?
            guard let minCoin = UserDefaults.standard.getObject(class: minCoinModel, key: self.currencies[index] + UserDefaultsKeys.MIN_COIN) else {
                continue
            }
            
            var maxCoinModel: Coin?
            guard let maxCoin = UserDefaults.standard.getObject(class: maxCoinModel, key: self.currencies[index] + UserDefaultsKeys.MAX_COIN) else {
                continue
            }
            
            if coinRate > maxCoin.rate {
                // Coin rate exceeds the maximum, trigger a alert controller
                message = "The rate of \(coinRate) has exceeded the maximum value."
            } else if coinRate < minCoin.rate {
                // Coin rate falls below the minimum, trigger a alert controller
                message = "The rate of \(coinRate) has fallen below the minimum value."
            }
            let content = UNMutableNotificationContent()
            content.title = "Coin Rate Alert"
            content.body = message
            content.sound = .default
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
}
