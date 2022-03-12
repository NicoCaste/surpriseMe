//
//  ArtistTopTracksCodable.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 13/12/2021.
//

import Foundation
import UIKit

struct ArtistsTopTracks: Codable {
    var tracks: [Track] = []
}

struct Track: Codable {
    var album: Album?
    var artists: [Artist?] = []
    var durationMs: Int?
    var explicit: Bool?
    var href: String?
    var id: String?
    var isPlayable: Bool?
    var name: String?
    var previewUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case album
        case artists
        case durationMs = "duration_ms"
        case explicit
        case href
        case id
        case isPlayable = "is_playable"
        case name
        case previewUrl = "preview_url"
    }
}

struct Album: Codable {
    var albumType: String?
    var images: [ProfileImage] = []
    var id: String?
    
    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case images
        case id
    }
}

class TrackWithImage {
    var track: Track
    var imageTrack: UIImage
    
    init(track: Track, image: UIImage) {
        self.track = track
        self.imageTrack = image
    }
}
