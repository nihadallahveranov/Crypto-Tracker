//
//  NumericTextInputView.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 08.07.23.
//

import UIKit

class NumericTextInputView: UIView, UITextFieldDelegate {
    
    var currentText: String = ""
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.keyboardType = .decimalPad
        self.addSubview(textField)
        
        return textField
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        self.addSubview(view)
        
        return view
    }()
    
    func configure(placeholder: String? = nil) {
        textField.placeholder = placeholder
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            dividerView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 12),
            dividerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789.") // Allow digits and dot (for decimal values)
        let replacementStringCharacterSet = CharacterSet(charactersIn: string)
        let isCharacterAllowed = allowedCharacterSet.isSuperset(of: replacementStringCharacterSet)
        let currentText = textField.text ?? ""
        self.currentText = isCharacterAllowed ? (currentText as NSString ).replacingCharacters(in: range, with: string) : currentText
        return isCharacterAllowed
    }
}
