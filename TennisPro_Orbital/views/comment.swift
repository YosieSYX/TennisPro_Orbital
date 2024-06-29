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
    
    @ObservedObject var viewModel : ForumComment
    let videoUrl:String
    let id: String
    
    
    init(videoUrl:String,id:String){
        self.videoUrl = videoUrl
        self.id = id
        self.viewModel = ForumComment(documentId: id)
    }
    
    
    var body: some View {
        VStack{
            VideoPlayer(player: AVPlayer(url: URL(string: videoUrl)!))
                .frame(height: 300)
            
            ScrollView{
                Text("TESTING: this is the video id: " + id)
                ForEach(viewModel.comments){comment in
                    
                    VStack{
                        Text(comment.uid)
                        Text(comment.comment)
                        Text(comment.timestamp)
                    }
                }
            }
            HStack{
                Spacer()
                Button(action: {
                    isLiked.toggle()
                }, label: {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                    
                })
                .sheet(isPresented: $isTextfieldVisible, content: {
                    textBox(isTextfieldVisible: $isTextfieldVisible, id:id )
                })
                Button(action: {
                    isTextfieldVisible = true
                }, label: {
                    Image(systemName: "text.bubble")
                })
            }
        }
       
    }
}



