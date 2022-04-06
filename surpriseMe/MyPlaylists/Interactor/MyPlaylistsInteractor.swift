//
//  MyPlayListsInteractor.swift
//  surpriseMe
//
//  Created by nicolas castello on 26/03/2022.
//

import Foundation
import Alamofire

class MyPlaylistsInteractor: MyPlaylistsInteractorProtocol {
    var presenter: MyPlaylistsPresenterProtocol?
    
    func getPlaylists(completion: @escaping(([Playlist?]) -> Void)) {
        let userId = ProfileInteractor.getClientData(userData: .id)
        guard let userId = userId else { return }
        AuthorizationInteractor.getToken(completion: { token in
            guard let token = token else { return }
            
            let headers: HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
            let url = ApiCaller.shared.makeURL(url: "users/\(userId)/playlists")
            let playListParameters: [String: Int] = ["limit": 50]
            
            AF.request(url,  parameters: playListParameters, headers: headers).responseDecodable(of: MyPlayList.self){ playlists in
                guard let playlists  = playlists.value else { return }
                completion(playlists.items ?? [])
            }
        })
    }
    
    func unfollowPlayList(playListId: String, completion: @escaping((Bool?)-> Void )) {
        
        AuthorizationInteractor.getToken(completion: { token in
            guard let token = token else { return }
            let headers: HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
            let url = ApiCaller.shared.makeURL(url: "playlists/\(playListId)/followers")
            
            AF.request(url,method: .delete, headers: headers).response(completionHandler: { data in
                switch data.result {
                case .success(nil):
                    completion(true)
                case .failure(nil):
                    completion(false)
                default:
                    completion(nil)
                }
                
            })
        })
    }
}
