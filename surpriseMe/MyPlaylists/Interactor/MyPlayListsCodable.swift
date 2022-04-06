//
//  MyPlayListsCodable.swift
//  surpriseMe
//
//  Created by nicolas castello on 26/03/2022.
//

import Foundation
import UIKit

struct MyPlayList: Codable {
    var href: String?
    var items: [Playlist]? = []
    var limit: Int?
    var next: String?
    var offset: Int?
    var previous: String?
    var total: Int?
}

struct Playlist: Codable {
    var collaborative: Bool?
    var description: String?
    var externalUrls: ExternalUrl?
    var images: [ProfileImage]? = []
    var name: String?
    var owner: Owner?
    var publicList: Bool?
    var snapshotId: String?
    var tracks: Tracks?
    var type: String?
    var uri: String?
    
    enum CodingKeys: String, CodingKey {
        case collaborative
        case description
        case externalUrls = "external_urls"
        case images
        case name
        case owner
        case publicList = "public"
        case snapshotId = "snapshot_id"
        case tracks
        case type
        case uri
    }
}
class PlayListWithImage {
    var playlist: Playlist
    var imagePlaylist: UIImage
    
    init(playlist: Playlist, image: UIImage) {
        self.playlist = playlist
        self.imagePlaylist = image
    }
}
