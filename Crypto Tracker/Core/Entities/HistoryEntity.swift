//
//  HistoryEntity.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 08.07.23.
//

import Foundation

struct HistoryItem: Codable {
    let coin: Coin
    let timestamp: TimeInterval
}
