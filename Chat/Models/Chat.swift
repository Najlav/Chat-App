//
//  Chat.swift
//  Chat
//
//  Created by Najla on 07/09/2022.
//  ✅

import Foundation

struct ChatModel: Codable{
    let id: String
    var person1Id: String
    var person2Id: String
    var arrayOfMessages : [Massege] // [person:Massage]
  
    
    public init(id: String , person1Id: String , person2Id: String ,arrayOfMessages : [Massege]){
        self.id = id
        self.person1Id = person1Id
        self.person2Id = person2Id
        self.arrayOfMessages = arrayOfMessages
    }
    
}

struct Massege: Codable {
    let isPerson1: Bool
    var msg:String
    
}

struct User: Codable {
    var id = UUID().uuidString
}
