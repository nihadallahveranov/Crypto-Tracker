//
//  HomeVC.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 06.07.23.
//

import UIKit

class HomeVC: UIViewController {
    
    private lazy var tokenAmountLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "$14,634.06"
        lbl.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        return lbl
    }()
    
    private lazy var changedTokenAmountLbl: UILabel = {
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
        stack.addArrangedSubview(tokenAmountLbl)
        stack.addArrangedSubview(changedTokenAmountLbl)
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
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(table)
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
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
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "indexPath.row - \(indexPath.row)"
        cell.contentConfiguration = content
        return cell
    }
    
    
}
