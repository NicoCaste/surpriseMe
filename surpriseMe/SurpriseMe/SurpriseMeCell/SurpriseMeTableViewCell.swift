//
//  SurpriseMeTableViewCell.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 12/12/2021.
//

import UIKit
import ImageIO
class SurpriseMeTableViewCell: UITableViewCell {
    lazy private var feelingImage = UIImageView()
    lazy private var feelingText = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(feeling: SurpriseMeFeeling) {
        var imageName: String = ""
        var TextFeeling: String = ""
        switch feeling {
        case .IWantALightsaber:
            imageName = "IWantALightsaber"
        case .ImDown:
            imageName = "sadMode"
        case .SuitUp:
            imageName = "Suitup"
        case .ImThirsty:
            imageName = "thirsty"
        case .IWantToParty:
            imageName = "iWantToParty"
        }
        TextFeeling = FeelingCategories.getTitle(feeling: feeling)
        if let image = UIImage(named: imageName) {
            setFeelingImage(image: image)
        }
        setFeelingText(text: TextFeeling)
    }
    
    func populate(image: UIImage, text: String) {
        setFeelingImage(image: image)
        setFeelingText(text: text)
    }
    
    func setFeelingImage(image: UIImage ) {
        feelingImage.image = image
        feelingImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(feelingImage)
        feelingImage.contentMode = .scaleAspectFill
        feelingImage.layer.masksToBounds = true
        feelingImage.layer.cornerRadius = 8
        feelingImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        feelingImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        feelingImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        feelingImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        feelingImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setFeelingText(text: String) {
        feelingText.text = text
        feelingText.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(feelingText)
        feelingText.numberOfLines = 0
        feelingText.font = UIFont(name: "Noto Sans Myanmar Bold", size: 15)
        feelingText.centerYAnchor.constraint(equalTo: feelingImage.centerYAnchor).isActive = true
        feelingText.leadingAnchor.constraint(equalTo: feelingImage
                                                .trailingAnchor, constant: 20).isActive = true
        feelingText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true 
    }
}
