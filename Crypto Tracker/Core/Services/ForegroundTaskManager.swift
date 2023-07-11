//
//  ForegroundTaskManager.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 10.07.23.
//

import UIKit
import UserNotifications

protocol ForegroundTaskDelegate: AnyObject {
    func didFetchCoinRatesFromForeground(_ currencyRates: CurrencyRatesResponse?)
}

class ForegroundTaskManager {
    
    static let shared = ForegroundTaskManager()
    private let repo = CryptoRepository()
    let currencies = ["Bitcoin", "Ethereum", "Ripple"]
    var coinRates: [Double] = []
    weak var delegate: ForegroundTaskDelegate?
    
    internal func fetchCoinRates(completion: @escaping (_ coinRates: [Double]) -> ()) {
        repo.getCurrencyRates() { response, error in
            self.delegate?.didFetchCoinRatesFromForeground(response)
            
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
            
            // Get min and max coins from local data storage.
            guard let minCoin = UserDefaults.standard.getCoin(key: self.currencies[index] + UserDefaultsKeys.MIN_COIN) else {
                continue
            }
            
            guard let maxCoin = UserDefaults.standard.getCoin(key: self.currencies[index] + UserDefaultsKeys.MAX_COIN) else {
                continue
            }
            
            let currentCoin = Coin(name: self.currencies[index], rate: coinRate)
            
            if coinRate > maxCoin.rate {
                // Coin rate exceeds the maximum, trigger a alert controller
                message = "The rate of \(coinRate) has exceeded the maximum value."
                
                // Add currentCoin to history
                UserDefaults.standard.addHistoryItem(currentCoin)
            } else if coinRate < minCoin.rate {
                // Coin rate falls below the minimum, trigger a alert controller
                message = "The rate of \(coinRate) has fallen below the minimum value."
                
                // Add currentCoin to history
                UserDefaults.standard.addHistoryItem(currentCoin)
            }
            
            let content = UNMutableNotificationContent() // content for foreground notification
            content.title = "Coin Rate Alert"
            content.body = message
            content.sound = .default
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
}
