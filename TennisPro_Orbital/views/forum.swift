//
//  forum.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 14/6/24.
//

import SwiftUI
import PhotosUI
import AVKit

struct forum: View {
    @StateObject var viewModel = ViewModelForum()
    @Binding var currentShowingView: String
    
    var body: some View {
        NavigationStack{
           
              
            ScrollView{
                ForEach(viewModel.videos){videos in
                    VideoPlayer(player: AVPlayer(url: URL(string: videos.videoUrl)!))
                       .frame(height:250)
                    
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        currentShowingView = "menu"
                    }, label: {
                        Text("menu")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        currentShowingView = "welcome"
                    }, label: {
                        Text("Log out")
                    })
                }
            }
        }
        }
        
    }


