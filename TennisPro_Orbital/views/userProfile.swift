//
//  userProfile.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 10/7/24.
//

import SwiftUI

import PhotosUI
import AVKit
import Kingfisher
struct userProfile: View {
    @Binding var currentShowingView: String
    @State private var selectedItem:ProfileFilterViewModel = .forumPost
    @StateObject var viewModel = ForumPost()
    @State private var emptyPost:Bool = false
    
    
    var body: some View {
        NavigationStack{
            VStack{
                informationView
                
                toolbarView
                
                if selectedItem == .forumPost{
                    postView
                }
                if selectedItem == .history{
                    Text("yet to complete")
                }
                
                Spacer()
            }
            .toolbar{
                
                ToolbarItem{
                    Button(action: {
                        currentShowingView="menu"
                    }, label: {
                        Text("menu")
                            .foregroundColor(.white)
                            
                    })
                }
            }
            
        }
        
    }
    
}
extension userProfile{
    var toolbarView:some View{
        HStack{
            ForEach(ProfileFilterViewModel.allCases, id:\.rawValue){item in
                VStack{
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedItem == item ? .bold :.regular)
                    
                    if selectedItem == item{
                        Capsule()
                            .foregroundColor(.blue)
                            .frame(height: 3)
                    }
                    else{
                        Capsule()
                            .foregroundColor(.clear)
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.selectedItem = item
                    }
                }
            }
        }
    }
    var informationView:some View{
        ZStack(alignment:.top){
            Color(.systemBlue)
                .ignoresSafeArea()
            VStack{
                
                Spacer()
                KFImage(URL(string: viewModel.document.imageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width:100, height: 100)
                    .overlay(Circle().stroke(Color.black,lineWidth: 1))
                
                Text(viewModel.document.user_name)
                    .font(.title)
                Text(viewModel.document.introduction)
                    .padding()
                    .frame(maxWidth: .infinity)
                   
                Spacer()
                NavigationLink(destination: editProfile(userName: viewModel.document.user_name, introduction: viewModel.document.introduction,ImageUrl: viewModel.document.imageUrl)) {
                    HStack{
                        Image(systemName:"pencil.line")
                            .foregroundColor(.black)
                        Text("Edit")
                            .foregroundColor(.black)
                             
                    }
                    .frame(width: 100,height: 30)
                    .cornerRadius(20)
                    .background(Color.white)
                    .padding()
                    
                }
               
            }
            
        }
        .frame(height: 300)
        
    }
    
    var postView:some View{
        
        ScrollView{
            LazyVStack{
                ForEach(viewModel.posts){post in
                  
                        NavigationLink {
                            comment(videoUrl: post.videoUrl, id: post.id ?? "None")
                        } label: {
                            HStack{
                                VideoPlayer(player: AVPlayer(url: URL(string: post.videoUrl)!))
                                    .frame(width:100,height:100)
                                    .padding(10)
                                Text("my post")
                                    .frame(width: 150,height: 100)
                                    .foregroundColor(.black)
                            
                                Image(systemName: "chevron.forward")
                                    .foregroundColor(.gray)
                                    .opacity(10)
                            }
                           
                        }
                        .padding()
                    
                    Divider()
                    
                }
                
                
            }
        }
        
        
    }
    
    
    
}
