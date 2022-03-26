//
//  MyPlayListsPresenter.swift
//  surpriseMe
//
//  Created by nicolas castello on 26/03/2022.
//

import Foundation
import UIKit

class MyPlaylistsPresenter: MyPlaylistsPresenterProtocol {
    var view: MyPlaylistsViewProtocol?
    var interactor: MyPlaylistsInteractorProtocol?
    var router: MyPlaylistsRouterProtocol?
    var playlists: [PlayListWithImage?] = []
    
    func getPlaylists() {
        interactor?.getPlaylists(completion: { [weak self] playLists in
            self?.setImagePlayLists(playlists: playLists, completionTask: { playlistsWithImage in
                self?.playlists = playlistsWithImage
                self?.view?.tableView?.isHidden = false 
                self?.view?.tableView?.reloadData()
                self?.view?.activityIndicator?.removeFromSuperview()
            })
            
        })
    }
    
    func setImagePlayLists(playlists: [Playlist?], completionTask: @escaping(([PlayListWithImage?]) -> Void)) {
        var playListsWithImage: [PlayListWithImage?] = []
        var index = 0
        for plist in playlists {
            ApiCaller.shared.getImage(url: plist?.images?.first?.url ?? "", completion: { playListImage in
                var image: UIImage?
                if let playListImage = playListImage {
                    image = playListImage
                } else {
                    image = UIImage(systemName: "camera")
                }
                
                let playListWithImage: PlayListWithImage = PlayListWithImage(playlist: plist ?? Playlist(), image: image ?? UIImage())
                playListsWithImage.append(playListWithImage)
                index += 1
                
                if index == playlists.count {
                    completionTask(playListsWithImage)
                }
            })
        }
    }
    
    func unfollowPlaylists(playListUri: String, name: String) {
        let playlistId = getplayListId(playListUri: playListUri)
        interactor?.unfollowPlayList(playListId: playlistId, completion: { [weak self] wasDeleted in
            guard let wasDeleted = wasDeleted else {
                self?.showAlert(title: name, message: "we cant remove this playlist. Please try again", style: .cancel)
                return
            }
            if wasDeleted {
                self?.showAlert(title: name, message: "it was deleted", style: .default)
            } else {
                self?.showAlert(title: name, message: "we cant remove this playlist. Please try again", style: .cancel)
            }
            self?.getPlaylists()
        })
    }
    
    func getplayListId(playListUri: String) -> String {
        return playListUri.replacingOccurrences(of: "https://open.spotify.com/playlist/", with: "")
    }
    
    func showAlert(title: String, message: String, style: UIAlertAction.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cerrar", style: style)
        alert.dismiss(animated: true)
        alert.addAction(action)
        self.view?.showAlert(alert: alert)
    }
}
