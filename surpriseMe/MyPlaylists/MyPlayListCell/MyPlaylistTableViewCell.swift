//
//  MyPlaylistTableViewCell.swift
//  surpriseMe
//
//  Created by nicolas castello on 26/03/2022.
//

import UIKit
import Foundation

class MyPlaylistTableViewCell: UITableViewCell {
    lazy private var playListImage: UIImageView = UIImageView()
    lazy private var playListName: UILabel = UILabel()
    lazy private var playlistDetail: UILabel = UILabel()

    func populate(playlistWithImage: PlayListWithImage ) {
        setPlayListImage(image: playlistWithImage.imagePlaylist)
        setPlaylistName(text: playlistWithImage.playlist.name ?? "test")
        setPlayListDetail(detail: playlistWithImage.playlist.description ?? "")
    
    }
    
    //MARK: SetPlaylistImage
    private func setPlayListImage(image: UIImage) {
        playListImage.image = image
        playListImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(playListImage)
        playListImage.contentMode = .scaleAspectFill
        playListImage.layer.masksToBounds = true
        playListImage.layer.cornerRadius = 4
        playListImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        playListImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        playListImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        playListImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }

    //MARK: SetPlaylistName
    private func setPlaylistName(text: String) {
        playListName.text = text
        playListName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(playListName)
        
        playListName.font = UIFont(name: "Noto Sans Myanmar Bold", size: 15)
        playListName.numberOfLines = 0
        playListName.topAnchor.constraint(equalTo: playListImage.topAnchor).isActive = true
        playListName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        playListName.leadingAnchor.constraint(equalTo: playListImage.trailingAnchor, constant: 20).isActive = true
    }
    
    //MARK: SetPlaylistDetail
    private func setPlayListDetail(detail: String ) {
        playlistDetail.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(playlistDetail)
        playlistDetail.text = detail
        playlistDetail.numberOfLines = 0
        playlistDetail.font = UIFont(name: "Noto Sans Myanmar semi Bold", size: 15)
        playlistDetail.leadingAnchor.constraint(equalTo: playListImage.trailingAnchor, constant: 20).isActive = true
        playlistDetail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        playlistDetail.topAnchor.constraint(equalTo: playListName.bottomAnchor, constant: 10).isActive = true
        playlistDetail.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        playlistDetail.bottomAnchor.constraint(equalTo: playListImage.bottomAnchor).isActive = true
    }
}
