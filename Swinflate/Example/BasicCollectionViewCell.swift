//
//  BasicCollectionViewCell.swift
//  Example
//
//  Created by Vlad on 1/7/19.
//  Copyright © 2019 Vlad Iacob. All rights reserved.
//

import UIKit

class BasicCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    let label = UILabel()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        contentView.addSubview(label)
        contentView.contentMode = .scaleAspectFit
        contentView.clipsToBounds = false
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = UIColor.appleRed
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 20
        contentView.layer.shadowOpacity = 0.2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textColor = .white
    }
}
