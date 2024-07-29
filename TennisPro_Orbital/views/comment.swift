//
//  comment.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 29/6/24.
//

import SwiftUI
import PhotosUI
import AVKit
import Kingfisher

struct comment: View {
   
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
                    VStack(alignment:.leading){
                        HStack{
                            if let imageUrl=comment.user?.imageUrl,!imageUrl.isEmpty{
                                KFImage(URL(string:imageUrl))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .frame(width:40, height: 40)
                                    .overlay(Circle().stroke(Color.black,lineWidth: 1))
                            }else{
                                Image(systemName: "person")
                                    .frame(width:10,height:10)
                            }
                            
                            Text(comment.user?.user_name ?? "user123456")
                            Spacer()
                        }
                        .padding()

                        Text(comment.comment)
                    }
                    .padding()
                    
                    Divider()
                        .frame(height: 5)
                        .padding()
                }
            }
            
            HStack{
                Spacer()
                
               
                Button(action: {
                    isTextfieldVisible = true
                }, label: {
                    HStack{
                        Image(systemName: "text.bubble")
                            .foregroundColor(.gray)
                            .opacity(5)
                        Text("\(viewModel.comments.count)")
                            .foregroundColor(.gray)
                            .opacity(5)
                    }
                    .padding()
                })
                .sheet(isPresented: $isTextfieldVisible, content: {
                    textBox(isTextfieldVisible: $isTextfieldVisible, id:id )
                })
            }
        }
       
    }
}



