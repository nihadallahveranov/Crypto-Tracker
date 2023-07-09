//
//  HomeVC+SetupNavigation.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 06.07.23.
//

import UIKit

extension HomeVC {
    func setupNavigationController() {
        self.title = "Default Portfolio"
        
        // UIImage for the leading icon
        let leadingIcon = UIImage(named: "graph")?.withRenderingMode(.alwaysTemplate)
        let leadingBarButtonItem = UIBarButtonItem(image: leadingIcon, style: .plain, target: self, action: #selector(leadingIconTapped))

        // UIImage for the trailing icon
        let trailingIcon = UIImage(systemName: "ellipsis")?.withRenderingMode(.alwaysTemplate)
        let trailingBarButtonItem = UIBarButtonItem(image: trailingIcon, style: .plain, target: self, action: #selector(trailingIconTapped))
        
        // Set the tint color for the icons
        leadingBarButtonItem.tintColor = .white
        trailingBarButtonItem.tintColor = .white

        
        // Set the leading and trailing bar button items in the navigation bar
        navigationItem.leftBarButtonItem = leadingBarButtonItem
        navigationItem.rightBarButtonItem = trailingBarButtonItem
    }
    
    @objc func leadingIconTapped() {
        print("leadingIconTapped")
    }

    @objc func trailingIconTapped() {
        print("trailingIconTapped")
    }
}
