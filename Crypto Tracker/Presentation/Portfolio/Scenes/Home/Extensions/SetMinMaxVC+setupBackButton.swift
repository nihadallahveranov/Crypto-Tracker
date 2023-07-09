//
//  SetMinMaxVC+setupBackButton.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 08.07.23.
//

import UIKit

extension SetMinMaxVC {
    func setupBackButton() {
        let backButtonImage = UIImage(named: "arrow.left")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
