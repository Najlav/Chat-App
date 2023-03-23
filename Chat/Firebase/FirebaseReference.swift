//
//  FirebaseReference.swift
//  Chat
//
//  Created by Najla on 07/09/2022.
//  ✅

import Firebase

enum FCollectionReference: String {
    case Chat
}


func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
