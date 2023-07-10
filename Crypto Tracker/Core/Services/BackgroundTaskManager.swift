//
//  BackgroundTaskManager.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 09.07.23.
//

import Foundation
import BackgroundTasks
import UserNotifications

// https://developer.apple.com/documentation/backgroundtasks/bgtaskschedulererrorcode/bgtaskschedulererrorcodeunavailable?language=objc

protocol BackgroundTaskDelegate: AnyObject {
    func didFetchCoinRates(_ coinRates: [Double])
}

class BackgroundTaskManager {
    static let shared = BackgroundTaskManager()
    
    private let currencies = ["Bitcoin", "Ethereum", "Ripple"]
    private let backgroundTaskIdentifier: String = "com.Crypto-Tracker.backgroundTask"
    private let repo = CryptoRepository()
    weak var delegate: BackgroundTaskDelegate?
    
    internal func scheduleBackgroundTask() {
        let taskRequest = BGAppRefreshTaskRequest(identifier: backgroundTaskIdentifier)
        taskRequest.earliestBeginDate = Date(timeIntervalSinceNow: 60) // Run the task every 60 seconds
        
        do {
            try BGTaskScheduler.shared.submit(taskRequest)
        } catch {
            print("Failed to schedule background task: \(error)")
        }
    }
    
    private func performBackgroundTask(task: BGAppRefreshTask) {
        fetchCoinRate { [weak self] coinRates in
            guard let self = self else { return }

            for (index, coinRate) in coinRates.enumerated() {
                // Compare the coin rate with the saved min and max values
                var minCoinModel: Coin?
                guard let minCoin = UserDefaults.standard.getObject(class: minCoinModel, key: self.currencies[index] + UserDefaultsKeys.MIN_COIN) else {
                    return
                }
                
                var maxCoinModel: Coin?
                guard let maxCoin = UserDefaults.standard.getObject(class: maxCoinModel, key: self.currencies[index] + UserDefaultsKeys.MAX_COIN) else {
                    return
                }

                if coinRate > maxCoin.rate {
                    // Coin rate exceeds the maximum, trigger a local notification
                    self.triggerNotification(title: "Coin Rate Alert", message: "The rate of \(coinRate) has exceeded the maximum value.")
                } else if coinRate < minCoin.rate {
                    // Coin rate falls below the minimum, trigger a local notification
                    self.triggerNotification(title: "Coin Rate Alert", message: "The rate of \(coinRate) has fallen below the minimum value.")
                }
            }

            task.setTaskCompleted(success: true)
            self.scheduleBackgroundTask()
        }
    }
    
    private func fetchCoinRate(completion: @escaping (_ coinRates: [Double]) -> ()) {
        repo.getCurrencyRates() { response, error in
            guard let bitcoin = response?.bitcoin.usd,
                    let ethereum = response?.ethereum.usd,
                    let ripple = response?.ripple.usd else
            {
                return
            }
            self.delegate?.didFetchCoinRates([bitcoin, ethereum, ripple])
            completion([bitcoin, ethereum, ripple])
        }
    }
    
    private func triggerNotification(title: String, message: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    internal func handleBackgroundTask(task: BGAppRefreshTask) {
        performBackgroundTask(task: task)
    }
}
