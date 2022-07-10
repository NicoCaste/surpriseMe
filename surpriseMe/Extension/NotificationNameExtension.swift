//
//  NotificationNameExtension.swift
//  surpriseMe
//
//  Created by nicolas castello on 25/03/2022.

import Foundation

extension Notification.Name {
    static var playBackPaused: Notification.Name {
        return .init(rawValue: "AudioPlayer.playbackPaused")
    }
    
    static var showErrorView: Notification.Name {
        return .init(rawValue: "showErrorView")
    }
    
    static var reloadArtistsMatch: Notification.Name {
        return .init(rawValue: "reloadArtistsMatch")
    }
    
    static var recibeData: Notification.Name {
        return .init(rawValue: "recibeData")
    }
    
    static var withoutData: NSNotification.Name {
        return .init(rawValue: "whithoutData")
    }
}
