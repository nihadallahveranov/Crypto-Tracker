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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .primaryBlue
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        self.view.addSubview(button)
        
        return button
    }()
    
    private lazy var pushButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go to history", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .primaryDark
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(pushButtonTapped), for: .touchUpInside)
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
    private func saveButtonTapped() {
        let minText = minTextInputView.currentText
        let maxText = maxTextField.currentText
        
        guard let min = Double(minText), let max = Double(maxText) else {
            showAlert(title: "Invalid Input", message: "Please enter valid minimum and maximum values.")
            return
        }
        
        saveMinMaxValues(min: min, max: max)
        showAlert(title: "Successfully saved.")
    }
    
    @objc
    private func pushButtonTapped() {
        let vc = CoinHistoryVC()
        vc.selectedCoinName = self.selectedCoinName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func saveMinMaxValues(min: Double, max: Double) {
        let minCoin: Coin = Coin(name: selectedCoinName, rate: min)
        let maxCoin: Coin = Coin(name: selectedCoinName, rate: max)
        UserDefaults.standard.saveObject(minCoin, key: selectedCoinName + UserDefaultsKeys.MIN_COIN)
        UserDefaults.standard.saveObject(maxCoin, key: selectedCoinName + UserDefaultsKeys.MAX_COIN)
    }
    
    private func showAlert(title: String, message: String? = nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func setupViews() {
        setupBackButton()
        
        NSLayoutConstraint.activate([
            inputStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24),
            inputStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            inputStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            inputStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            saveButton.topAnchor.constraint(equalTo: inputStackView.bottomAnchor, constant: 24),
            saveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 187),
            saveButton.heightAnchor.constraint(equalToConstant: 48),
            
            pushButton.topAnchor.constraint(equalTo: self.saveButton.bottomAnchor, constant: 12),
            pushButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            pushButton.widthAnchor.constraint(equalToConstant: 187),
            pushButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}
