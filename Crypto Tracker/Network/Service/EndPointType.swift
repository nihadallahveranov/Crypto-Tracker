//
//  EndPointType.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 06.07.23.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
