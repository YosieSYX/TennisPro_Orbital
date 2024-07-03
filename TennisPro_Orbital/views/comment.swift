//
//  comment.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 29/6/24.
//

import SwiftUI
import PhotosUI
import AVKit

struct comment: View {
    @State private var isLiked = false
    @State private var isTextfieldVisible = false
    
    @StateObject var viewModel : ForumComment
    let videoUrl:String
    let id: String
    
    
    init(videoUrl:String,id:String){
        self.videoUrl = videoUrl
        self.id = id
        _viewModel = StateObject(wrappedValue: ForumComment(documentId: id))
            }
    
    
    var body: some View {
        VStack{
            VideoPlayer(player: AVPlayer(url: URL(string: videoUrl)!))
                .frame(height: 300)
            
            ScrollView{
                
                ForEach(viewModel.comments){comment in
                    Text("user: \(comment.uid)")
                    Text(comment.comment)
                    Divider()
                        .frame(height: 5)
                        .padding()
                }
            }
            
            HStack{
                Spacer()
                Button(action: {
                    isLiked.toggle()
                }, label: {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                    
                })
               
                Button(action: {
                    isTextfieldVisible = true
                }, label: {
                    Image(systemName: "text.bubble")
                })
                .sheet(isPresented: $isTextfieldVisible, content: {
                    textBox(isTextfieldVisible: $isTextfieldVisible, id:id )
                })
            }
        }
       
    }
}



