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
}
