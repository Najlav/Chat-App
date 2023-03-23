//
//  ChatNotification.swift
//  Chat
//
//  Created by Najla on 07/09/2022.
//  ✅

import Foundation

struct ChatNotification {
    static let waiting = "Waiting"
    static let ChatStarted = "started"
    static let ChatFinished = "Finished"
}

enum chatState {
    case started
    case waiting
    case finished
}
