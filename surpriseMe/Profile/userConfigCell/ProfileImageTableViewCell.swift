//
//  ProfileImageTableViewCell.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 12/12/2021.
//

import UIKit

protocol ProfileImageDelegate: AnyObject {
    func imageAllreadyLoad(id: Int, url: String)
}

class ProfileImageTableViewCell: UITableViewCell {
    lazy var profileImage: UIImageView = UIImageView()
    lazy var loading: UIActivityIndicatorView = UIActivityIndicatorView()
    weak var delegate: ProfileImageDelegate?
    var id = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(urlImage: String, image: UIImage?, id: Int ) {
        self.id = id
        setLoadling()
        setProfileImage(url: urlImage, image: image)
    }
    
    func setProfileImage(url: String, image: UIImage?) {
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(profileImage)
        if url.isEmpty {
            loading.removeFromSuperview()
            profileImage.image = UIImage(systemName: "person.circle.fill")
        } else {
            if let image = image {
                profileImage.image = image
                loading.removeFromSuperview()
            } else {
                delegate?.imageAllreadyLoad(id: id, url: url)
            }
        }
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 60
        profileImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

    }
    
    func setLoadling() {
        loading.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loading)
        loading.startAnimating()
        loading.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        loading.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        loading.widthAnchor.constraint(equalToConstant: 120).isActive = true
        loading.heightAnchor.constraint(equalToConstant: 120).isActive = true
        loading.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
