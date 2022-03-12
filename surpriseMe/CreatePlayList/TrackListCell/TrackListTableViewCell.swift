//
//  TrackListTableViewCell.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 13/12/2021.
//

import UIKit

class TrackListTableViewCell: UITableViewCell {
    lazy var trackImage: UIImageView = UIImageView()
    lazy var trackName: UILabel = UILabel()
    lazy var bandName: UILabel = UILabel()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(trackWithImage: TrackWithImage) {
        setTrackImage(image: trackWithImage.imageTrack)
        setTrackName(text: trackWithImage.track.name ?? "")
        setBandName(band: trackWithImage.track.artists.first??.name ?? "")
    }
    
    //MARK: SetTrackName
    func setTrackName(text: String) {
        trackName.text = text
        trackName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(trackName)
        trackName.font = UIFont(name: "Noto Sans Myanmar Bold", size: 15)
        trackName.numberOfLines = 0
        trackName.topAnchor.constraint(equalTo: trackImage.topAnchor).isActive = true
        trackName.leadingAnchor.constraint(equalTo: trackImage
                                                .trailingAnchor, constant: 20).isActive = true
        trackName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
    
    //MARK: SetBandName
    func setBandName(band: String ) {
        bandName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bandName)
        bandName.text = band
        bandName.font = UIFont(name: "Noto Sans Myanmar semi Bold", size: 15)
        bandName.leadingAnchor.constraint(equalTo: trackImage.trailingAnchor, constant: 20).isActive = true
        bandName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        bandName.topAnchor.constraint(equalTo: trackName.bottomAnchor, constant: 10).isActive = true
        bandName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        bandName.bottomAnchor.constraint(equalTo: trackImage.bottomAnchor).isActive = true
    }
    
    //MARK: SetTrackImage
    func setTrackImage(image: UIImage) {
        trackImage.image = image
        trackImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(trackImage)
        trackImage.contentMode = .scaleAspectFill
        trackImage.layer.masksToBounds = true
        trackImage.layer.cornerRadius = 4
        trackImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        trackImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        trackImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        trackImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
