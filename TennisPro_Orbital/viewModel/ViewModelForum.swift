//
//  ViewModelForum.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 14/6/24.
//
import Foundation
import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import Firebase

class ViewModelForum: ObservableObject{
    @Published var videos = [FetchVideo]()
    @Published var selectedPost: PhotosPickerItem?{
        didSet{
            Task{try await uploadVideo()}
        }
    }
    
    init(){
        Task{try await fetchVideos()
        print("try to fetch video")}
        
    }
    func uploadVideo() async throws{
        guard let postItem = selectedPost else{
            return}
        
        guard let postVideoData = try await postItem.loadTransferable(type: Data.self) else{return }
        print("start to retirbe postVideourl")
        
        guard let postVideourl = try await ForumVideo.uploadVideo(withData: postVideoData)else{
            print("unsuccessful retrieve postVideourl")
            return}
        print("successful retrive postVideourl")
        print("retirive url"+postVideourl)
        // Update one field, creating the document if it does not exist.
   
       try await Firestore.firestore().collection("forum").document().setData(["videoUrl":postVideourl])
        
        
        
        print("successfully uploaded")
        
        
        
    }
    
    @MainActor
    func fetchVideos() async throws{
        let snapshot=try await Firestore.firestore().collection("forum").getDocuments()
        for doc in snapshot.documents{
            print(doc.data())
        }
        self.videos = snapshot.documents.compactMap(
            { try?$0.data(as: FetchVideo.self)
            })

        
    }
    
}

