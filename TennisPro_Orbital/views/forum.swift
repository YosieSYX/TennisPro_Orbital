//
//  forum.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 14/6/24.
//

import SwiftUI
import PhotosUI
import AVKit
import Kingfisher

struct forum: View {
    @StateObject var viewModel = ViewModelForum()
    @Binding var currentShowingView: String

    
    var body: some View {
        NavigationStack{
           
              
            ScrollView{
                ForEach(viewModel.videos){videos in
                    
                        
                        NavigationLink(destination: comment(videoUrl: videos.videoUrl, id: videos.id ?? "defaultId")) {
                            ZStack{
                                Rectangle()
                                    .fill(Color.clear)
                                VStack{
                                    HStack{
                                        if let imageUrl=videos.user?.imageUrl,!imageUrl.isEmpty{
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
                                        Text(videos.user?.user_name ?? "user123456")
                                        Spacer()
                                    }
                                    .padding([.top, .horizontal])
                                    HStack{
                                        VideoPlayer(player: AVPlayer(url: URL(string: videos.videoUrl)!))
                                            .frame(width:250,height:150)
                                            .padding(10)
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(.gray)
                                            .opacity(10)
                                            
                                    }
                                }
                            }
                            .frame(width:350, height:200)
                            .padding()
                         
                        }
                    
                    Divider()
                }
            }
            .refreshable {
                Task{
                    try await viewModel.fetchVideos()
                    
                }
            }
            
            

            
            .navigationTitle("Forum")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    PhotosPicker(selection: $viewModel.selectedPost, matching: .any(of: [.videos, .not(.images)])){
                        Image(systemName: "plus")
                    }
                    
                }
                ToolbarItem(placement:.navigationBarLeading) {
                    Button(action: {
                        currentShowingView = "menu"
                    }, label: {
                        HStack{
                            Image(systemName: "chevron.left")
                            Text("menu")
                        }
                    })
                }
                
            }
        }
        }
        
    }


