//
//  HomeViewModel.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 07.07.23.
//

import Foundation

class HomeViewModel {
    private let repo: CryptoRepository
    let currencies = ["Bitcoin", "Ethereum", "Ripple"]
    let currencyValues = ["0.1000000 BTC ($645.64)", "24 ETH ($190.19)", "2500 XRP ($230.44)"]
    let currencyExchanges = ["+$74.36 (+1.15%)", "+$0.01 (+3.07%)", "-$3.86 (-1.9%)"]
    var currencyRates: CurrencyRatesResponse?
    var error: String?
    
    init() {
        repo = CryptoRepository()
    }
    
    func getCurrencyRates(callback: @escaping () -> ()) {
        repo.getCurrencyRates { response, error in
            self.currencyRates = response
            self.error = error
            DispatchQueue.main.async {
                callback()
            }
        }
    }
}
