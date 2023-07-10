//
//  CryptoEndpoint.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 07.07.23.
//

import Foundation

enum CryptoAPI {
    case currencyRates
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
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .currencyRates:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .currencyRates:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["ids": "bitcoin,ethereum,ripple",
                                                      "vs_currencies": "usd"])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
