//
//  ChatView.swift
//  Chat
//
//  Created by Najla on 07/09/2022.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var model: ChatViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var text = ""
    @State var UserOne: String = ""
    @State var IsUserOne : Bool = false
    @State var hasStarted = false
    
    
    var body: some View {
        ZStack{
            if ((model.chat?.person2Id == "") || (model.chat == nil)) && (hasStarted == false){
                LoadingView()
            }else{

        NavigationView{
        GeometryReader { geo in
            VStack {
                Text(model.chatNotification)
                //MARK:- ScrollView
                ScrollView{
                    LazyVStack {
                        ForEach(0..<(model.chat?.arrayOfMessages.count ?? 0) , id: \.self) { index in
                            ChatBubbleView(position: ((model.chat?.arrayOfMessages[index].isPerson1)! == IsUserOne) ? .right : .left , color:(model.chat?.arrayOfMessages[index].isPerson1)! ? .blue : .green) {
                                
                                Text(model.chat?.arrayOfMessages[index].msg ?? "")
                                  
                            }
                        }
                    }
                }
                  
                //MARK:- text editor
                HStack {
                    ZStack {
                        TextEditor(text: $text )
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .foregroundColor(.gray)
                    }.frame(height: 50)
                    
                    Button("send") {

                        if text != "" {
                            model.processNewMassage(for: text)
                            text = ""
                        }
                    }
                }.padding().onAppear(){
                    hasStarted = true
                    UserOne = model.chat?.person1Id ?? ""
                if ( UserOne == model.currentUser.id){
                    IsUserOne = true
                    print("im user one \(UserOne)")
                }
            }
        }.navigationTitle("Chat").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button{
                mode.wrappedValue.dismiss()
                model.quiteChat()

            }label: {
                Image(systemName: "rectangle.portrait.and.arrow.right").foregroundColor(.red)
           }
            
    }
        }
}
}
}
}
}
