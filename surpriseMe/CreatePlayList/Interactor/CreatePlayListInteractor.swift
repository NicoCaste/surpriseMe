//
//  CreatePlayListInteractor.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 13/12/2021.
//

import UIKit
import Alamofire

struct Parameters: Codable {
    var name: String?
    var description: String?
    var uris: [String]?
    var id: String?
    var market: String?
}

class CreatePlayListInteractor: CreatePlayListInteractorProtocol {
    var presenter: CreatePlayListPresenterProtocol?
    var userId: String?
    var topTracks: [ArtistsTopTracks] = []
    let webService: WebService = AlamofireWebService()
    let repository: SurpriseMeApiRepository
    
    init() {
        self.repository = SurpriseMeApiRepository(webService: webService)
    }
    
    // MARK - CreatePlayList
    func createPlayList(completion: @escaping((CreatePlayList?) -> Void)) {
        userId = ProfileInteractor.getClientData(userData: .id)
        guard let userId = userId else { return }
        let url = ApiCaller.shared.makeURL(url: "users/\(userId)/playlists")
        let parameters = getCreatePlayListParameters()
        
        repository.createPlayList(baseUrl: url, parameters: parameters, endpoint: "", limit: 1, completion: {[weak self] result in
            switch result {
                case .success(let newPlayList):
                if newPlayList.uri == nil {
                    ShowErrorManager.showErrorView(title: "ups".localized(), description: "errorCreatePlaylist".localized())
                } else {
                    self?.addTracksToPlayList(playListId: newPlayList.id ?? "", completion: { snaptShot in
                        completion(newPlayList)
                    })
                }
            case .failure( _):
                ShowErrorManager.showErrorView(title: "ups".localized(), description: "errorCreatePlaylist".localized())
                break
            }
        })
    }
    
    // MARK: - GetCreatePlayListParameters
    private func getCreatePlayListParameters() -> Parameters {
        guard let presenter = presenter else { return Parameters()}
        return Parameters(name: FeelingCategories.getTitle(feeling: presenter.feeling ?? .IWantALightsaber), description: "createBy".localized())
    }
    
    // MARK: - AddTracksToPlayList
    private func addTracksToPlayList(playListId: String, completion: @escaping((Result<AddTracksToPlayListResponse, Error>) -> Void)) {
        let parameters = getAddTracksParameter()
        let url = ApiCaller.shared.makeURL(url: "playlists/\(playListId)/tracks")
        
        repository.addTracksToPlayList(baseUrl: url, parameters: parameters, endpoint: "", limit: 1, completion: {
            result in
            completion(result)
        })
    }
    
    // MARK: - GetAddTracksParameter
    private func getAddTracksParameter() -> Parameters {
        guard let presenter = presenter else { return Parameters()}
        var tracksId: [String] = []
        presenter.trackList.forEach({tracksId.append($0.track.id ?? "")})
        var tracksParametersList: [String] = []
        tracksId.forEach({
            let tracksParameters =  "spotify:track:\($0)"
            tracksParametersList.append(tracksParameters)
        })
        
        return  Parameters(uris: tracksParametersList)
    }
    
    func getTrackRecommendations(completion: @escaping(([ArtistsTopTracks]) -> Void)) {
        guard let presenter = presenter else { return }
        let searchArtistId = getRandomArtist(feeling: presenter.feeling ?? .IWantALightsaber)
        let parameters = getTrackRecommendartionsParameters()
        let url = ApiCaller.shared.makeURL(url: "artists/\(searchArtistId)/related-artists")
        
        repository.getTrackRecommendations(baseUrl: url, parameters: parameters, endpoint: "", limit: 1, completion: {[weak self] artistList in
            switch artistList {
            case .success(let artists):
                if artists.artists.isEmpty {
                    ShowErrorManager.showErrorView(title: "sorry".localized(), description: "errorTrackRecommendation".localized())
                    completion([])
                } else {
                    self?.getTopTracks(artists: artists.artists, completionTracks: {
                        completion(self?.topTracks ?? [])
                    })
                }
            case .failure( _):
                ShowErrorManager.showErrorView(title: "sorry".localized(), description: "errorTrackRecommendation".localized())
                completion([])
            }
        })
    }
    
    private func getTrackRecommendartionsParameters() -> Parameters {
        guard let presenter = presenter else { return Parameters()}
        let searchArtistId = getRandomArtist(feeling: presenter.feeling ?? .IWantALightsaber)
        return Parameters(id: searchArtistId)
    }
    
    private func getTopTracks(artists: [Artist?], completionTracks: @escaping()-> Void) {
        var index = 0
        for artist in artists {
            getArtistTracks(artistId: artist?.id, completion: {[weak self] trackList in
                self?.topTracks.append(trackList)
                index += 1
                if index == artists.count {
                    completionTracks()
                }
            })
        }
    }
    
    private func getArtistTracks(artistId: String?, completion: @escaping((ArtistsTopTracks)-> Void)) {
            guard let artistId = artistId else { return }
            let parameters = self.getArtistTracksParameters(artistId: artistId)
            let url = ApiCaller.shared.makeURL(url: "artists/\(artistId)/top-tracks")
            
            repository.getArtistsTopTracks(baseUrl: url, parameters: parameters, endpoint: "", limit: 1, completion: { tracks in
                switch tracks {
                case .success(let topTraks):
                    completion(topTraks)
                case .failure( _):
                    ShowErrorManager.showErrorView(title: "sorry".localized(), description: "errorTrackRecommendation".localized())
                    break
                }
            })
    }
    
    private func getArtistTracksParameters(artistId: String) -> Parameters {
        Parameters(id: artistId, market: "ar")
    }
    
    private func getRandomArtist(feeling: SurpriseMeFeeling ) -> String {
        guard let artistsList = presenter?.artists else { return "" }
        let index = Int.random(in: 0...artistsList.count - 1)
        return artistsList[index]?.id ?? ""
    }
}
