//
//  TrackListTableViewCell.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 13/12/2021.
//

import UIKit
import AVFAudio

protocol TrackListTableViewCellDelegate {
    func newPlayer(cellPlayer: TrackListTableViewCell)
}

class TrackListTableViewCell: UITableViewCell, AVAudioPlayerDelegate  {
    lazy private var trackImage: UIImageView = UIImageView()
    lazy private var trackName: UILabel = UILabel()
    lazy private var bandName: UILabel = UILabel()
    lazy private var playStopButton: UIButton = UIButton()
    lazy private var playStopImage: UIImageView = UIImageView()
    var urlSong: String = ""
    var viewModel: TrackListCellModel?
    var delegate: TrackListTableViewCellDelegate?
    var index: Int?
    var notificationCenter = NotificationCenter.default
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(trackWithImage: TrackWithImage, index: Int) {
        viewModel = TrackListCellModel(viewIntance: self)
        self.index = index
        setPlayStopButton(isPlayed: trackWithImage.track.isPlayable ?? false, urlString: trackWithImage.track.previewUrl ?? "")
        setPlayStopImage(isPlayed: trackWithImage.track.isPlayable ?? false)
        setTrackImage(image: trackWithImage.imageTrack)
        setTrackName(text: trackWithImage.track.name ?? "")
        setBandName(band: trackWithImage.track.artists.first??.name ?? "")
        
        notificationCenter.addObserver(self, selector: #selector(pauseMusic), name: Notification.Name.playBackPaused, object: nil)
    }
    
    @objc func pauseMusic() {
        guard let model = viewModel else {return}
        model.player?.stop()
        model.player = nil
    }
    
    //MARK: SetPlayStopButton
    private func setPlayStopButton(isPlayed: Bool, urlString: String ) {
        playStopButton.isHidden = (isPlayed) ? false : true
        urlSong = urlString
        playStopButton.addTarget(self, action: #selector(playStopButtonAction), for: .touchUpInside)
        playStopButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(playStopButton)
        
        playStopButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        playStopButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playStopButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        playStopButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    @objc private func playStopButtonAction() {
        guard let model = viewModel else {return}
        if ((model.player?.isPlaying) != nil) {
            model.player?.stop()
            showPlayImage()
            model.player = nil
        } else {
            showPuaseImage()
            model.playStopMusic(urlString: urlSong)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        showPlayImage()
        viewModel?.player?.stop()
        viewModel?.player = nil
    }
    
    func showPlayImage() {
        playStopImage.image = UIImage(systemName: "play.circle.fill")
    }
    
    func showPuaseImage() {
        playStopImage.image = UIImage(systemName: "pause.circle.fill")
    }
    
    //MARK: SetPlayStopImage
    private func setPlayStopImage(isPlayed: Bool) {
        playStopImage.isHidden = (isPlayed) ? false : true
        showPlayImage()
        playStopImage.tintColor = .green
        playStopImage.translatesAutoresizingMaskIntoConstraints = false
        playStopButton.addSubview(playStopImage)
        
        playStopImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        playStopImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        playStopImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        playStopImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
    }
    
    //MARK: SetTrackName
    private func setTrackName(text: String) {
        trackName.text = text
        trackName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(trackName)
        trackName.font = UIFont(name: "Noto Sans Myanmar Bold", size: 15)
        trackName.numberOfLines = 0
        trackName.topAnchor.constraint(equalTo: trackImage.topAnchor).isActive = true
        trackName.leadingAnchor.constraint(equalTo: trackImage
                                                .trailingAnchor, constant: 20).isActive = true
        trackName.trailingAnchor.constraint(equalTo: playStopImage.leadingAnchor, constant: -20).isActive = true
    }
    
    //MARK: SetBandName
    private func setBandName(band: String ) {
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
    private func setTrackImage(image: UIImage) {
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
