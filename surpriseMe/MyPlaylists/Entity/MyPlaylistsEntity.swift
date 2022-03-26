//
//  MyPlaylistsEntity.swift
//  surpriseMe
//
//  Created by nicolas castello on 26/03/2022.
//

import Foundation
import UIKit


protocol MyPlaylistsViewProtocol {
    var tableView: UITableView? { get }
    var activityIndicator: UIActivityIndicatorView? { get }
    func showAlert(alert: UIAlertController)
}


protocol MyPlaylistsInteractorProtocol {
    func getPlaylists(completion: @escaping(([Playlist?]) -> Void))
    func unfollowPlayList(playListId: String, completion: @escaping((Bool?)-> Void ))
}

protocol MyPlaylistsPresenterProtocol {
    var playlists: [PlayListWithImage?] { get }
    func getPlaylists()
    func unfollowPlaylists(playListUri: String, name: String)
}

protocol MyPlaylistsRouterProtocol {
    
}

