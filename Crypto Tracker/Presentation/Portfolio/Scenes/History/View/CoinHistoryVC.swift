//
//  CoinHistoryVC.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 11.07.23.
//

import UIKit

class CoinHistoryVC: UIViewController {
    
    var selectedCoinName: String = ""
    private let viewModel = CoinHistoryViewModel()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(table)
        
        return table
    }()
    
    private lazy var noDataLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "No history available"
        lbl.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        self.view.addSubview(lbl)
        
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getCoinHistory(coinName: selectedCoinName)
        setupViews()
    }
    
    private func addTrailingDeleteBtn() {
        // Create a UIBarButtonItem with a desired button type
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))
        deleteButton.tintColor = .red
        
        // Assign the UIBarButtonItem to the navigationItem's rightBarButtonItem
        navigationItem.rightBarButtonItem = deleteButton
    }
    
    @objc func deleteButtonTapped() {
        
        // Break that function when no available history
        guard viewModel.histories.count != 0 else {
            let alertController = UIAlertController(title: "No history available", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        // Delete all histories
        let alertController = UIAlertController(title: "Delete", message: "Are you sure you want to delete?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            self.viewModel.deleteAllHistories()
            self.tableView.reloadData()
        }
        alertController.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    
    private func setupViews() {
        self.navigationController?.navigationBar.tintColor = .white
        self.view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            noDataLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            noDataLbl.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
        
        addTrailingDeleteBtn()
    }

}

extension CoinHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // show noDataLbl when histories are empty
        noDataLbl.isHidden = viewModel.histories.count == 0 ? false : true
        return viewModel.histories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.histories[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
}
