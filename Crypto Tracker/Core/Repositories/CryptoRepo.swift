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
    
    // Add more functions for interacting with other API endpoints as needed
    
    // Example function for setting min and max values
//    func setMinMaxValue(coin: String, min: Double, max: Double, completion: @escaping (Result<SetMinMaxValueResponse>) -> Void) {
//        let endpoint = CryptoAPI.setMinMaxValue(coin: coin, min: min, max: max)
//        networkManager.request(endpoint: endpoint) { (response: SetMinMaxValueResponse?, error) in
//            if let error = error {
//                completion(.failure(error))
//            } else if let response = response {
//                completion(.success(response))
//            } else {
//                completion(.failure("Unknown error occurred"))
//            }
//        }
//    }
    
    // Example function for retrieving coin history
//    func getCoinHistory(coin: String, completion: @escaping (Result<CoinHistoryResponse>) -> Void) {
//        let endpoint = CryptoAPI.coinHistory(coin: coin)
//        networkManager.request(endpoint: endpoint) { (response: CoinHistoryResponse?, error) in
//            if let error = error {
//                completion(.failure(error))
//            } else if let response = response {
//                completion(.success(response))
//            } else {
//                completion(.failure("Unknown error occurred"))
//            }
//        }
//    }
}
