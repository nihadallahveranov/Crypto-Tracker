//
//  CryptoEndpoint.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 07.07.23.
//

import Foundation

enum CryptoAPI {
    case currencyRates
    case setMinMaxValue(coin: String, min: Double, max: Double)
    case coinHistory(coin: String)
}

extension CryptoAPI: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.coingecko.com/api/v3") else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .currencyRates:
            return "/simple/price"
        case .setMinMaxValue, .coinHistory:
            return "/your/path/here" // Replace with your specific API endpoint paths
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .currencyRates, .coinHistory:
            return .get
        case .setMinMaxValue:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .currencyRates, .coinHistory:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["ids": "bitcoin,ethereum,ripple",
                                                      "vs_currencies": "usd"])
        case .setMinMaxValue(let coin, let min, let max):
            let parameters: Parameters = [
                "coin": coin,
                "min": min,
                "max": max
            ]
            return .requestParameters(bodyParameters: parameters, bodyEncoding: .jsonEncoding, urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
