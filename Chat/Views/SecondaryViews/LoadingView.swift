//
//  LoadingView.swift
//  Chat
//
//  Created by Najla on 07/09/2022.
//  ✅

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            VStack{
                ProgressView()
                Text("Connecting")
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

