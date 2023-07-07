//
//  CryptoTableViewCell.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 07.07.23.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    
    private lazy var cryptoImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imgView)
        
        return imgView
    }()
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        return lbl
    }()
    
    private lazy var subTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = .darkGray
        
        return lbl
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 6
        stack.addArrangedSubview(titleLbl)
        stack.addArrangedSubview(subTitleLbl)
        self.contentView.addSubview(stack)
        
        return stack
    }()
    
    private lazy var amountLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    private lazy var exchangedAmountLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = .primaryGreen
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    private lazy var amountStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 6
        stack.addArrangedSubview(amountLbl)
        stack.addArrangedSubview(exchangedAmountLbl)
        self.contentView.addSubview(stack)
        
        return stack
    }()
    
    func configure(
        cryptoTitle: String,
        cryptoSubTitle: String,
        cryptoAmount: String,
        cryptoExchangeAmount: String,
        cryptoImgName: String
    ) {
        self.titleLbl.text = cryptoTitle
        self.subTitleLbl.text = cryptoSubTitle
        self.amountLbl.text = "$\(cryptoAmount)"
        self.exchangedAmountLbl.text = "\(cryptoExchangeAmount)"
        self.cryptoImage.image = UIImage(named: "\(cryptoImgName)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupViews() {
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cryptoImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            cryptoImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            cryptoImage.heightAnchor.constraint(equalToConstant: 25),
            cryptoImage.widthAnchor.constraint(equalToConstant: 25),
            
            mainStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: cryptoImage.trailingAnchor, constant: 8),

            amountStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            amountStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24),
            amountStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
        ])
    }

}
