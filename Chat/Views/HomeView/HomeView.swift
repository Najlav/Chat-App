//
//  ContentView.swift
//  Chat
//
//  Created by Najla on 07/09/2022.
//  ✅

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @ObservedObject var model = ChatViewModel()
    
    var body: some View {
        VStack {
            Button {
                 model.getTheChat()
                 viewModel.isChatViewPresented = true
            } label: {
               Text("Start")
            }
        }.navigationTitle("Chat").navigationBarTitleDisplayMode(.inline).fullScreenCover(isPresented: $viewModel.isChatViewPresented) {
                ChatView(model: self.model)
        }
    }
}
