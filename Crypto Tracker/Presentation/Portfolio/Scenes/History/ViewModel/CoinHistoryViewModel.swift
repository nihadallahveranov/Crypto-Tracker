//
//  CoinHistoryViewModel.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 11.07.23.
//

import Foundation

class CoinHistoryViewModel {
    
    var histories: [String] = []
    
    func getCoinHistory(coinName: String) {
        guard let histories = UserDefaults.standard.getHistories(key: UserDefaultsKeys.HISTORY_OF_COINS) else {
            self.histories = []
            return
        }
        
        for history in histories {
            guard coinName == history.coin.name else { // Add only selected coin name's history
                return
            }
            let dateFormatter = DateFormatter()

            // Set the desired date format
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

            // Convert the timestamp to a Date object
            let date = Date(timeIntervalSince1970: history.timestamp)

            // Format the date into a string
            let formattedDateString = dateFormatter.string(from: date)
            
            self.histories.append("\(history.coin.rate) - \(formattedDateString)")
        }
    }
    
    func deleteAllHistories() {
        let emptyHistory: [HistoryItem] = []
        UserDefaults.standard.saveObject(emptyHistory, key: UserDefaultsKeys.HISTORY_OF_COINS)
        self.histories = []
    }
}
