//
//  FirebaseService.swift
//  Chat
//
//  Created by Najla on 07/09/2022.
//  ✅

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine

final class FirebaseService: ObservableObject {
    static let shared = FirebaseService()
    @Published var chat: ChatModel!
    
    init() {}
    
    // create a Chat document in firebase
    func createChat(){
        do {
            print("running2")
            try FirebaseReference(.Chat).document(self.chat.id).setData(from: self.chat)
        } catch {
            print("Error creating online game", error.localizedDescription)
        }

    }
    
    // check if there is a Room to join, if no, we create new Room. If yes, we will join and start listening for any changes in the Room
    func startChat(with userId: String) {
        FirebaseReference(.Chat).whereField("person2Id", isEqualTo: "").whereField("person1Id", isNotEqualTo: userId).getDocuments { querySnapshot, error in
            print("running3")
            if error != nil {
                print("Error starting chat", error?.localizedDescription)
                //create new chat room
                self.createNewChat(with: userId)
                return
            }
            
            if let chatData = querySnapshot?.documents.first {
                self.chat = try? chatData.data(as: ChatModel.self)
                self.chat.person2Id = userId
                
                self.updateChat(self.chat)
                self.listenForChatChanges()
            } else {
                self.createNewChat(with: userId)
            }
        }
    }
    
    // listen for New massages and notifie the user when he is connected
    func listenForChatChanges() {
        FirebaseReference(.Chat).document(self.chat.id).addSnapshotListener { documentSnapshot, error in
            print("changes received from firebase")
            
            if error != nil {
                print("Error listening to changes", error?.localizedDescription)
                return
            }
            
            if let snapshot = documentSnapshot {
                self.chat = try? snapshot.data(as: ChatModel.self)
            }
        }
    }
    
    // create new chat Object
    func createNewChat(with userId: String) {
        print("creating chat room for userid", userId)
        
        self.chat = ChatModel(id: UUID().uuidString, person1Id: userId, person2Id: "", arrayOfMessages: [])
        self.createChat()
        self.listenForChatChanges()
    }
    
    // when changes happen update the view
    func updateChat(_ chat: ChatModel) {
        do {
            try FirebaseReference(.Chat).document(chat.id).setData(from: chat)
        } catch {
            print("Error updating online game", error.localizedDescription)
        }
    }
    
    // quite the chat
    func quiteTheChat() {
        guard chat != nil else { return }
        FirebaseReference(.Chat).document(self.chat.id).delete()
    }
    
}
