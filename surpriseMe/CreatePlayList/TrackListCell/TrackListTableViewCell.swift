//
//  TrackListTableViewCell.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 13/12/2021.
//

import UIKit
import AVFAudio

class TrackListTableViewCell: UITableViewCell {
    lazy var trackImage: UIImageView = UIImageView()
    lazy var trackName: UILabel = UILabel()
    lazy var bandName: UILabel = UILabel()
    lazy var playStopButton: UIButton = UIButton()
    lazy var playStopImage: UIImageView = UIImageView()
    var isPlaying: Bool = false
    var urlSong: String = ""
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(trackWithImage: TrackWithImage) {
        setPlayStopButton(isPlayed: trackWithImage.track.isPlayable ?? false, urlString: trackWithImage.track.previewUrl ?? "")
        setPlayStopImage(isPlayed: trackWithImage.track.isPlayable ?? false)
        setTrackImage(image: trackWithImage.imageTrack)
        setTrackName(text: trackWithImage.track.name ?? "")
        setBandName(band: trackWithImage.track.artists.first??.name ?? "")
    }
    
    //MARK: SetPlayStopButton
    func setPlayStopButton(isPlayed: Bool, urlString: String ) {
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
    
    @objc func playStopButtonAction() {
        let nameImage = (isPlaying) ? "pause.circle.fill" : "play.circle.fill"
        isPlaying = !isPlaying
        playStopImage.image = UIImage(systemName: nameImage)
        contentView.reloadInputViews()
        playStopMusic(urlString: urlSong)
    }
    
    func playStopMusic(urlString: String) {
        guard let url = URL(string: urlString) else {return}
        let downloadSong: URLSessionDownloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { urlNew, resp, er in
               do {
                   guard let urlLocal = urlNew else { return }
                   try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                   try AVAudioSession.sharedInstance().setActive(true)
                   let player = try AVAudioPlayer(contentsOf: urlLocal)
                   player.prepareToPlay()
                   print(player.prepareToPlay())
                   player.volume = 1.0
                   player.play()
                   print(player.isPlaying)
               } catch let error as NSError {
                   //self.player = nil
                   print(error.localizedDescription)
               } catch {
                   print("AVAudioPlayer init failed")
               }
        })
        downloadSong.resume()
        
    }
    
    //MARK: SetPlayStopImage
    func setPlayStopImage(isPlayed: Bool) {
        playStopImage.isHidden = (isPlayed) ? false : true
        playStopImage.image = UIImage(systemName: "play.circle.fill")
        playStopImage.tintColor = .green
        playStopImage.translatesAutoresizingMaskIntoConstraints = false
        playStopButton.addSubview(playStopImage)
        
        playStopImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        playStopImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        playStopImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        playStopImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
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
        trackName.trailingAnchor.constraint(equalTo: playStopImage.leadingAnchor, constant: -20).isActive = true
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
