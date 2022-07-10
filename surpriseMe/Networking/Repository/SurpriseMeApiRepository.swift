//
//  SurpriseMeApiRepository.swift
//  surpriseMe
//
//  Created by nicolas castello on 09/07/2022.
//

import Foundation

final class SurpriseMeApiRepository {
    var webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    // MARK - CreatePlayList
    func createPlayList(baseUrl: String? = nil, parameters:  Parameters, endpoint: String, limit: Int, completion:@escaping(Result<CreatePlayList, Error>) -> Void) {
        
        webService.post(baseUrl ?? "", parameters: parameters, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let playList = try JSONDecoder().decode(CreatePlayList.self, from: data)
                    completion(.success(playList))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - AddTracksToPlayList
    func addTracksToPlayList(baseUrl: String? = nil, parameters: Parameters, endpoint: String, limit: Int, completion:@escaping(Result<AddTracksToPlayListResponse, Error>) -> Void) {
        
        webService.post(baseUrl ?? "", parameters: parameters, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let playList = try JSONDecoder().decode(AddTracksToPlayListResponse.self, from: data)
                    completion(.success(playList))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getTrackRecommendations(baseUrl: String? = nil, parameters: Parameters, endpoint: String, limit: Int, completion:@escaping(Result<ArtistRelatedArtists, Error>) -> Void) {
        
        webService.get(baseUrl ?? "", parameters: parameters, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let playList = try JSONDecoder().decode(ArtistRelatedArtists.self, from: data)
                    completion(.success(playList))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getArtistsTopTracks(baseUrl: String? = nil, parameters: Parameters, endpoint: String, limit: Int, completion:@escaping(Result<ArtistsTopTracks, Error>) -> Void) {
        webService.get(baseUrl ?? "", parameters: parameters, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let topTracks = try JSONDecoder().decode(ArtistsTopTracks.self, from: data)
                    completion(.success(topTracks))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
