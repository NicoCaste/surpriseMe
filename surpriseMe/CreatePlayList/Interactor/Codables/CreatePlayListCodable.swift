//
//  CreatePlayListCodable.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 13/12/2021.
//

import Foundation
import UIKit

struct AddTracksToPlayListResponse: Codable {
    var snapshotId: String?
    
    enum CodingKeys: String, CodingKey {
        case snapshotId = "snapshot_id"
    }
}

struct CreatePlayList: Codable {
    var collaborative: Bool?
    var description: String?
    var externalUrls: ExternalUrl?
    var followers: Followers?
    var href: String?
    var id: String?
    var images: [ProfileImage]? = []
    var name: String?
    var owner: Owner?
    var publicPlayList: Bool?
    var snapshotId: String?
    var tracks: Tracks?
    var type: String?
    var uri: String?
    
    enum CodingKeys: String, CodingKey {
        case collaborative
        case description
        case externalUrls = "external_urls"
        case followers
        case href
        case id
        case images
        case name
        case owner
        case publicPlayList = "public"
        case snapshotId = "snapshot_id"
        case tracks
        case type
        case uri
    }

}

struct Tracks: Codable {
    var href: String?
    var limit: Int?
    var next: String?
    var offset: Int?
    var previous: String?
    var total: Int?
}
struct Owner: Codable {
    var displayName: String?
    var externalUrls: ExternalUrl?
    var followers: Followers?
    var href: String?
    var id: String?
    var images: [ProfileImage]? = []
    var type: String?
    var uri: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case followers
        case href
        case id
        case type
        case uri
    }
}

