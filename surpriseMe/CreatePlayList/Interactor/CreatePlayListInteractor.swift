//
//  CreatePlayListInteractor.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 13/12/2021.
//

import UIKit
import Alamofire

class CreatePlayListInteractor: CreatePlayListInteractorProtocol {
    var presenter: CreatePlayListPresenterProtocol?
    var userId: String?
    var topTracks: [ArtistsTopTracks] = []
    
    func createPlayList(completion: @escaping((CreatePlayList?) -> Void)) {
        userId = ProfileInteractor.getClientData(userData: .id)
        guard let userId = userId else { return }
        
        AuthorizationInteractor.getToken(completion: {[weak self] token in
            guard let token = token else { return }
            guard let self = self else { return }
            guard let presenter = self.presenter else { return }
            
            let headers: HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
            let playListParameters: [String: String] = ["name": FeelingCategories.getTitle(feeling: presenter.feeling ?? .IWantALightsaber),
                                                  "description": "Create by SorpriseMe! app."]
            let url = ApiCaller.shared.makeURL(url: "users/\(userId)/playlists")
            AF.request( url, method: .post, parameters: playListParameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: CreatePlayList.self) {[weak self] newPlayList in
                switch newPlayList.result {
                case .success:
                    self?.addTracksToPlayList(playListId: newPlayList.value?.id ?? "", completion: { snaptShot in
                        completion(newPlayList.value)
                    })
                case .failure:
                    completion(nil)
                }
            }
        })
    }
    
    
    private func addTracksToPlayList(playListId: String, completion: @escaping((DataResponse<AddTracksToPlayListResponse, AFError>) -> Void)) {
        var tracksId: [String] = []
        presenter?.trackList.forEach({tracksId.append($0.track.id ?? "")})
        AuthorizationInteractor.getToken(completion: { token in
            guard let token = token else { return }
            let headers: HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
            var tracksParametersList: [String] = []
            tracksId.forEach({
                let tracksParameters =  "spotify:track:\($0)"
                tracksParametersList.append(tracksParameters)
            })
            
            let url = ApiCaller.shared.makeURL(url: "playlists/\(playListId)/tracks")
            AF.request(url, method: .post, parameters: ["uris" : tracksParametersList], encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: AddTracksToPlayListResponse.self) { snapShot in
                completion(snapShot)
            }
        })
    }
    
    func getTrackRecommendations(completion: @escaping(([ArtistsTopTracks]) -> Void)) {
        guard let presenter = presenter else { return }
        
        let searchArtistId = getRandomArtist(feeling: presenter.feeling ?? .IWantALightsaber)
        AuthorizationInteractor.getToken(completion: {[weak self] token in
            guard let token = token else { return }
            let headers: HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
            let searchParameters = [ "id" : searchArtistId ]
            let url = ApiCaller.shared.makeURL(url: "artists/\(searchArtistId)/related-artists")
            
            AF.request(url, parameters: searchParameters, headers: headers).responseDecodable(of: ArtistRelatedArtists.self) { artistList in
                guard let artists = artistList.value else { return }
                self?.getTopTracks(artists: artists.artists, completionTracks: {
                    completion(self?.topTracks ?? [])
                })
            }
        })
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
        AuthorizationInteractor.getToken(completion: { token in
            guard let token = token else { return }
            guard let artistId = artistId else { return }
            let headers: HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
            let artistParameters = [ "id" : artistId,
                                     "market": "ar"]
            let url = ApiCaller.shared.makeURL(url: "artists/\(artistId)/top-tracks")
            AF.request(url, parameters: artistParameters, headers: headers).responseDecodable(of: ArtistsTopTracks.self){ tracks in
                switch tracks.result {
                case .success:
                    guard let topTracks = tracks.value else { return }
                    completion(topTracks)
                case .failure:
                    break
                }
            }
        })
    }
    
    private func getRandomArtist(feeling: SurpriseMeFeeling ) -> String {
        guard let artistsList = presenter?.artists else { return "" }
        let index = Int.random(in: 0...artistsList.count - 1)
        return artistsList[index]?.id ?? ""
    }
}

