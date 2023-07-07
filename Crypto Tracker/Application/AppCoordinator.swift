//
//  AppCoordinator.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 06.07.23.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeVC()
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(vc, animated: false)
    }

}
