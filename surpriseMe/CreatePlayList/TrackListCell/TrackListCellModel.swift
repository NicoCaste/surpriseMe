//
//  TrackListCellModel.swift
//  surpriseMe
//
//  Created by nicolas castello on 23/03/2022.

import UIKit
import AVFAudio

class TrackListCellModel {
    var player: AVAudioPlayer?
    var viewInstance: TrackListTableViewCell
    
    init(viewIntance: TrackListTableViewCell) {
        self.viewInstance = viewIntance
    }
    
    func playStopMusic(urlString: String) {
        guard let url = URL(string: urlString) else {return}
        downloadFileFromURL(url: url)
    }
    
    private func downloadFileFromURL(url:URL){
        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { [weak self](URL, response, error) -> Void in
            if let url = URL {
                self?.play(url: url)
            }
        })
        downloadTask.resume()
    }
    
    private func play(url:URL) {
        print("playing \(url)")
        
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            self.viewInstance.delegate?.newPlayer(cellPlayer: viewInstance)
            player?.delegate = viewInstance
            player?.prepareToPlay()
            player?.volume = 1.0
            player?.play()
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            self.viewInstance.showPlayImage()
            print("AVAudioPlayer init failed")
        }
    }
}
