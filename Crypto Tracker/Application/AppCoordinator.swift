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
        vc.overrideUserInterfaceStyle = .dark
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(vc, animated: false)
    }

}
