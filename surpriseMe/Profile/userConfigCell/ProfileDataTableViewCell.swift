//
//  ProfileDataTableViewCell.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 12/12/2021.
//

import UIKit

class ProfileDataTableViewCell: UITableViewCell {
    lazy var profileDataLabel: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(text: String) {
        setProfileDataLabel(text: text)
    }
    
    func setProfileDataLabel(text: String) {
        profileDataLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(profileDataLabel)
        profileDataLabel.text = text
        profileDataLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        profileDataLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        profileDataLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        profileDataLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        profileDataLabel.font = UIFont(name: "Noto Sans Myanmar Bold", size: 15)
        
    }
}
