//
//  CryptoEntity.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 07.07.23.
//

import Foundation

struct CurrencyRatesResponse: Codable {
    let bitcoin: CurrencyRate
    let ethereum: CurrencyRate
    let ripple: CurrencyRate
}

struct CurrencyRate: Codable {
    let usd: Double
}
