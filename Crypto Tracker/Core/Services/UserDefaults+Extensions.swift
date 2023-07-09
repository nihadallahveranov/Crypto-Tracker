//
//  UserDefaultsHelper.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 08.07.23.
//

import Foundation

enum UserDefaultsKeys {
    static let MIN_COIN = "_min"
    static let MAX_COIN = "_max"
}

extension UserDefaults {
    
    func saveObject<T: Codable>(_ object: T?, key: String) {
        if let object = object {
            if let data = try? JSONEncoder().encode(object) {
                UserDefaults.standard.set(data, forKey: key)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    func getObject<T: Codable>(class: T?, key: String) -> T? {
        if let data = UserDefaults.standard.data(forKey: key),
           let object = try? JSONDecoder().decode(T.self, from: data) {
            return object
        } else {
            return nil
        }
    }
}
