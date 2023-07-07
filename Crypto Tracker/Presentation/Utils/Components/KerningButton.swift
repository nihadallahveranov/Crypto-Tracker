//
//  KerningButton.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 07.07.23.
//

import UIKit

class KerningButton: UIButton {
    
    func setAttributedTitle(title: String, kern: Float) {
        let attributedTitle = NSAttributedString(string: "\(title)", attributes: [NSAttributedString.Key.kern: kern])
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    func setSystemFont(size: CGFloat, weight: UIFont.Weight = .regular) {
        self.titleLabel?.font = UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .primaryDark
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 4
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
