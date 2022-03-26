//
//  ProfileCodable.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 12/12/2021.
//

import UIKit

struct Profile: Codable {
    var country: String?
    var displayName: String?
    var email: String?
    var explicitContent: ExplicitContent?
    var externalUrls: ExternalUrl?
    var followers: Followers?
    var href: String?
    var id: String?
    var images: [ProfileImage?] = []
    var product: String?
    var type: String?
    var uri: String?
    
    enum CodingKeys: String, CodingKey{
        case country
        case displayName = "display_name"
        case email
        case explicitContent = "explicit_content"
        case externalUrls = "external_urls"
        case followers
        case href
        case id
        case images
        case product
        case type
        case uri
    }
}

struct ExplicitContent: Codable {
    var filterEnabled: Bool?
    var filterLocked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case filterEnabled = "filter_enabled"
        case filterLocked = "filter_locked"
    }
}

struct ExternalUrl: Codable {
    var spotify: String?
    var id: String?
    var href: String?
}

struct Followers: Codable {
    var href: String?
    var total: Int?
}

struct ProfileImage: Codable {
    var url: String?
    var height: Int?
    var width: Int?
}
