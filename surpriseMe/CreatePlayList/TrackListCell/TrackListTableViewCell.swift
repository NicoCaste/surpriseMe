//
//  TrackListTableViewCell.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 13/12/2021.
//

import UIKit
import AVFAudio

class TrackListTableViewCell: UITableViewCell, AVAudioPlayerDelegate {
    lazy var trackImage: UIImageView = UIImageView()
    lazy var trackName: UILabel = UILabel()
    lazy var bandName: UILabel = UILabel()
    lazy var playStopButton: UIButton = UIButton()
    lazy var playStopImage: UIImageView = UIImageView()
    var isPlaying: Bool = false
    var urlSong: String = ""
    var player: AVAudioPlayer?
  
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
        isPlaying = !isPlaying
        let nameImage = (isPlaying) ? "pause.circle.fill" : "play.circle.fill"
        playStopImage.image = UIImage(systemName: nameImage)
        contentView.reloadInputViews()
        if let player = player {
            if player.isPlaying {
                player.stop()
                self.player = nil
            }
        } else {
            playStopMusic(urlString: urlSong)
        }
        
    }
    
    func playStopMusic(urlString: String) {
        guard let url = URL(string: urlString) else {return}
        downloadFileFromURL(url: url)
    }
    
    func downloadFileFromURL(url:URL){

        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { [weak self](URL, response, error) -> Void in
            if let url = URL {
                self?.play(url: url)
            }
        })
        downloadTask.resume()
    }
    
    func play(url:URL) {
        print("playing \(url)")
        
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.volume = 1.0
            player?.play()
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playStopImage.image = UIImage(systemName: "play.circle.fill")
        contentView.reloadInputViews()
        player.stop()
        self.player = nil
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
