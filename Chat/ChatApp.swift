//
//  ChatApp.swift
//  Chat
//
//  Created by Najla on 07/09/2022.
//  ✅

import SwiftUI
import Firebase
import FirebaseCore

@main
struct ChatApp: App {
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
