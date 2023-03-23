//
//  ChatViewModel.swift
//  Chat
//
//  Created by Najla on 07/09/2022.
//  ✅

import Foundation
import SwiftUI
import Combine

final class ChatViewModel: ObservableObject {
    
    @AppStorage("user") private var userData: Data? //⭐️
    @Published var chatNotification = ChatNotification.waiting
    @Published var currentUser: User!
    private var cancellables: Set<AnyCancellable> = []
    
    
    @Published var chat: ChatModel? { //⭐️
        didSet {
            if chat == nil { updateNotificationFor(.finished) } else{
                chat?.person2Id == "" ? updateNotificationFor(.waiting) : updateNotificationFor(.started)
            }
        }
    }
    
    init() {
        retriveUser()
        if currentUser == nil {
            saveUser()
        }
    }
    
    func updateNotificationFor(_ state: chatState ) {
        switch state {
        case .started:
            chatNotification = ChatNotification.ChatStarted
        case .waiting:
            chatNotification = ChatNotification.waiting
        case .finished:
            chatNotification = ChatNotification.ChatFinished
        }
    }
    
    func retriveUser() {
        guard let userData = userData else { return }
        do {
            print("decoding user")
            currentUser = try JSONDecoder().decode(User.self, from: userData)
        } catch {
            print("no user saved")
        }
    }
    
    func saveUser() {
        currentUser = User()
        do {
            print("encoding user object")
            let data = try JSONEncoder().encode(currentUser)
            userData = data
        } catch {
            print("couldnt same user object")
        }
    }
    
    func getTheChat() {
        print("running")
        FirebaseService.shared.startChat(with: currentUser.id)
        
        FirebaseService.shared.$chat
            .assign(to: \.chat, on: self)
            .store(in: &cancellables)
    }
    
    func quiteChat() {
        FirebaseService.shared.quiteTheChat()
    }
    
    func processNewMassage(for Msg: String) {
        guard chat != nil else { return }
        chat!.arrayOfMessages.append(Massege(isPerson1: isPersonOne(), msg: Msg))
        FirebaseService.shared.updateChat(chat!)
    }
    
    func isPersonOne() -> Bool {
        return chat != nil ? chat!.person1Id == currentUser.id : false
    }
}

