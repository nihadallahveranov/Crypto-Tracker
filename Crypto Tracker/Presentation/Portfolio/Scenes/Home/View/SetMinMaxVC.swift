//
//  SetMinMaxVC.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 08.07.23.
//

import UIKit

class SetMinMaxVC: UIViewController {
    
    // Properties to hold the selected coin's information
    var selectedCoinName: String = ""
    var selectedCoinRate: Double = 0.0
    
    private lazy var minTextInputView: NumericTextInputView = {
        let view = NumericTextInputView()
        view.configure(placeholder: "Minimum")
        
        return view
    }()
    
    private lazy var maxTextField: NumericTextInputView = {
        let view = NumericTextInputView()
        view.configure(placeholder: "Maximum")
        
        return view
    }()
    
    private lazy var inputStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        stack.addArrangedSubview(minTextInputView)
        stack.addArrangedSubview(maxTextField)
        self.view.addSubview(stack)
        
        return stack
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .primaryBlue
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        self.view.addSubview(button)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc
    private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc
    private func saveButtonTapped(_ sender: UIButton) {
        let minText = minTextInputView.currentText
        let maxText = maxTextField.currentText
        
        guard let min = Double(minText), let max = Double(maxText) else {
            let alertController = UIAlertController(title: "Invalid Input", message: "Please enter valid minimum and maximum values.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        saveMinMaxValues(min: min, max: max)
   }
    
    private func saveMinMaxValues(min: Double, max: Double) {
        let minCoin: Coin = Coin(name: selectedCoinName, rate: min)
        let maxCoin: Coin = Coin(name: selectedCoinName, rate: max)
        UserDefaults.standard.saveObject(minCoin, key: selectedCoinName + UserDefaultsKeys.MIN_COIN)
        UserDefaults.standard.saveObject(maxCoin, key: selectedCoinName + UserDefaultsKeys.MAX_COIN)
    }
    
    private func setupViews() {
        setupBackButton()
        
        NSLayoutConstraint.activate([
            inputStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24),
            inputStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            inputStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            inputStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            saveButton.topAnchor.constraint(equalTo: inputStackView.bottomAnchor, constant: 24),
            saveButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48),
            saveButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -48),
            saveButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }

}
