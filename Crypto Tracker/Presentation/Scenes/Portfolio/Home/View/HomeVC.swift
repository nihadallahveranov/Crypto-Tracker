//
//  HomeVC.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 06.07.23.
//

import UIKit

class HomeVC: UIViewController {
    
    private let viewModel = HomeViewModel()
    
    private lazy var amountLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "$14,634.06"
        lbl.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        return lbl
    }()
    
    private lazy var exchangedAmountLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "+ $248.23 (+0.35)"
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .primaryGreen
        
        return lbl
    }()
    
    private lazy var headStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 7
        stack.addArrangedSubview(amountLbl)
        stack.addArrangedSubview(exchangedAmountLbl)
        self.view.addSubview(stack)
        
        return stack
    }()
    
    private lazy var filterHoldingBtn: KerningButton = {
        let btn = KerningButton()
        btn.setAttributedTitle(title: "Highest holdings", kern: 0.5)
        btn.setSystemFont(size: 12, weight: .bold)
        
        return btn
    }()
    
    private lazy var filterTimeBtn: KerningButton = {
        let btn = KerningButton()
        btn.setAttributedTitle(title: "24 Hours", kern: 0.5)
        btn.setSystemFont(size: 12, weight: .bold)
        
        return btn
    }()
    
    private lazy var filterStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.addArrangedSubview(filterHoldingBtn)
        stack.addArrangedSubview(filterTimeBtn)
        self.view.addSubview(stack)
        
        return stack
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.register(CryptoTableViewCell.self, forCellReuseIdentifier: "CryptoTableViewCell")
        self.view.addSubview(table)
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        viewModel.getCurrencyRates { [weak self] in
            guard let self = self else { return }
            self.setupViews()
            self.tableView.reloadData()
        }
    }
    
    private func setupViews() {
        self.setupNavigationController()
        
        NSLayoutConstraint.activate([
            headStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32),
            headStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            headStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            
            filterHoldingBtn.widthAnchor.constraint(equalToConstant: 130),
            filterHoldingBtn.heightAnchor.constraint(equalToConstant: 30),
            filterTimeBtn.widthAnchor.constraint(equalToConstant: 85),
            filterTimeBtn.heightAnchor.constraint(equalToConstant: 30),
            
            filterStackView.topAnchor.constraint(equalTo: headStackView.bottomAnchor, constant: 29),
            filterStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            filterStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            filterStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: filterStackView.bottomAnchor, constant: 32),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }

}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = viewModel.currencyRates { return viewModel.currencies.count }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoTableViewCell", for: indexPath) as? CryptoTableViewCell else { return UITableViewCell() }
        var amount = String()
        switch indexPath.row {
        case 0:
            if let usd = viewModel.currencyRates?.bitcoin.usd {
                amount = "\(usd)"
            }
        case 1:
            if let usd = viewModel.currencyRates?.ethereum.usd {
                amount = "\(usd)"
            }
        case 2:
            if let usd = viewModel.currencyRates?.ripple.usd {
                amount = "\(usd)"
            }
        default:
            return UITableViewCell()
        }
        cell.configure(cryptoTitle: viewModel.currencies[indexPath.row],
                       cryptoSubTitle: viewModel.currencyValues[indexPath.row],
                       cryptoAmount: amount,
                       cryptoExchangeAmount: viewModel.currencyExchanges[indexPath.row],
                       cryptoImgName: viewModel.currencies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    
}
