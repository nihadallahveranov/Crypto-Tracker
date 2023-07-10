//
//  CryptoRepo.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 07.07.23.
//

import Foundation

class CryptoRepository {
    let networkManager: NetworkManager<CryptoAPI>
    
    init() {
        networkManager = NetworkManager()
    }
    
    func getCurrencyRates(completion: @escaping (_ response: CurrencyRatesResponse?, _ error: String?) -> ()) {
        networkManager.request(endpoint: .currencyRates) { (response: CurrencyRatesResponse?, error: String?) in
            if let error = error {
                completion(nil, error)
            } else {
                completion(response, nil)
            }
        }
    }
}
