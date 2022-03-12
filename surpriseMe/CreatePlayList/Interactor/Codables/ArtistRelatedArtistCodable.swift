//
//  TrackRecommendationCodable.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 13/12/2021.
//

import Foundation

struct ArtistRelatedArtists: Codable {
    var artists: [Artist?]
}

struct EditFeeling: Codable {
    var artists: EditFeelingData
}

struct EditFeelingData: Codable {
    var href: String?
    var items: [Artist?]
}

struct Artist: Encodable, Decodable {
    var externalUrl: ExternalUrl?
    var followers: Followers?
    var genres: [String?]? = []
    var href: String?
    var id: String?
    var images: [ProfileImage]? = []
    var name: String?
    var popularity: Int?
    var type: String?
    var uri: String?
    
    enum CodingKeys: String, CodingKey {
        case externalUrl = "external_url"
        case followers
        case genres
        case href
        case id
        case images
        case name
        case popularity
        case type
        case uri
    }
}

