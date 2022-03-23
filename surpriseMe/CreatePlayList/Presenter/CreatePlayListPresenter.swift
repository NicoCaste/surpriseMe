//
//  CreatePlayListPresenter.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 13/12/2021.
//

import Foundation
import UIKit
import AVFAudio

class CreatePlayListPresenter: CreatePlayListPresenterProtocol {
    var feeling: SurpriseMeFeeling?
    var artists: [Artist?] = []
    var view: CreatePlayListViewProtocol?
    var interactor: CreatePlayListInteractorProtocol?
    var router: CreatePlayListRouterProtocol?
    var playList: CreatePlayList?
    var selectedTracks: [Track] = []
    var trackList: [TrackWithImage] = []
    var currentPlayer: TrackListTableViewCell?
    var currentPlayerImage: UIImageView?
    
    func createPlayList() {
        interactor?.createPlayList(completion: {[weak self] newPlayList in
            guard let newPlayList = newPlayList else { return }
            self?.playList = newPlayList
            self?.openUrlInBrowser(url: newPlayList.uri ?? "")
            })
    }
    
    func getTrackRecommendation() {
        interactor?.getTrackRecommendations(completion: { [weak self] trackList in
            for newTracks in trackList {
                for track in newTracks.tracks {
                    self?.selectedTracks.append(track)
                }
            }
            guard let allTracks = self?.selectedTracks else { return }
            let shuffledTracks = allTracks.shuffled()
            self?.selectedTracks = Array(shuffledTracks.prefix(99))
            self?.setTrackImage(tracks: self?.selectedTracks ?? [], completion: {
                self?.view?.tableView.reloadData()
                self?.view?.activityIndicator?.removeFromSuperview()
                self?.view?.tableView.isHidden = false
            })
        })
    }
    
    func openUrlInBrowser(url: String) {
        let urlOpen = URL(string: url)
        if let urlOpen = urlOpen {
            UIApplication.shared.open(urlOpen)
        }
    }
    
    func newPlayer(cellPlayer: TrackListTableViewCell) {
            DispatchQueue.main.async {
                if cellPlayer.index != self.currentPlayer?.index {
                    if let index = self.currentPlayer?.index {
                        let indexPath = IndexPath(row: index, section: 0)
                        self.view?.tableView.reloadRows(at: [indexPath], with: .none)
                    }
                    self.currentPlayer?.showPlayImage()
                }
                cellPlayer.showPuaseImage()
                self.currentPlayer?.viewModel?.player?.stop()
                self.currentPlayer = cellPlayer
            }
    }
    
    private func setTrackImage(tracks: [Track], completion: @escaping() -> Void) {
        trackList = []
        var tracksWithImagen: [TrackWithImage] = []
        var index = 1
        for track in tracks {
            ApiCaller.shared.getImage(url: track.album?.images.first?.url ?? "", completion: { [weak self] trackImageLoad in
                let trackWithImage = TrackWithImage(track: track, image: trackImageLoad ?? UIImage())
                tracksWithImagen.append(trackWithImage)
                index += 1
                if tracks.count == index {
                    self?.trackList = tracksWithImagen
                    completion()
                }
            })
        }
    }
}
