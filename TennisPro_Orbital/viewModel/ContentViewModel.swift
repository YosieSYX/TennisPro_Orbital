//
//  ContentViewModel.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 13/6/24.
//

import Foundation
import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseAuth

class ContentViewModel: ObservableObject{
    
    @Published var selectedItem: PhotosPickerItem?{
        didSet{ 
            Task{try await uploadVideo()}
        }
    }
    func uploadVideo() async throws{
        guard let item = selectedItem else{return}
        
        guard let videoData = try await item.loadTransferable(type: Data.self) else{return }
        
        guard let videourl = try await UploadVideo.uploadVideo(withData: videoData)else{return}
        
        let userId = Auth.auth().currentUser?.uid
        
        let userIdString = userId?.description ?? ""
        
         
        
        try await Firestore.firestore().collection("users").document(userIdString).collection("videos").document().setData(["videourl": videourl])
        
        print("successfully uploaded")
        
        
        
    }
    
}
