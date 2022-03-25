//
//  CreatePlayListEntity.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 13/12/2021.
//

import Foundation
import UIKit
import AVFAudio

protocol CreatePlayListViewProtocol {
    var tableView: UITableView { get }
    var createPlayListButton: UIButton { get }
    var activityIndicator: UIActivityIndicatorView? { get }
}

protocol CreatePlayListInteractorProtocol {
    func getTrackRecommendations(completion: @escaping (([ArtistsTopTracks]) -> Void)) 
    func createPlayList(completion: @escaping((CreatePlayList?) -> Void))
}

protocol CreatePlayListPresenterProtocol: TrackListTableViewCellDelegate {
    var trackList: [TrackWithImage] { get set }
    var feeling: SurpriseMeFeeling? { get }
    var artists: [Artist?] { get }
    func createPlayList()
    func getTrackRecommendation()
}

protocol CreatePlayListRouterProtocol {
    func goToSorpriseMe()
}
