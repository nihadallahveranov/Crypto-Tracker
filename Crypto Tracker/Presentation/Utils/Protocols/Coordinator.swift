//
//  Coordinator.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 06.07.23.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    init(navigationController: UINavigationController)

    func start()
}
