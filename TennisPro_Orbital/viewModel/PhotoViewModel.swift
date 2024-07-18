//
//  PhotoViewModel.swift
//  TennisPro_Orbital
//
//  Created by Yuexi Song on 27/6/24.
//
/*
import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class PhotoViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? = nil
    @Published var uploadStatus: String = ""
    @Published var imageUrls: [String] = []

    private let storage = Storage.storage()
    private let db = Firestore.firestore()

    func uploadPhoto() {
        guard let selectedItem = selectedItem else { return }
        selectedItem.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    self.uploadImageToFirebase(imageData: data)
                }
            case .failure(let error):
                print("Failed to load photo: \(error.localizedDescription)")
            }
        }
    }

    private func uploadImageToFirebase(imageData: Data) {
            guard let user = Auth.auth().currentUser else {
                print("User not logged in")
                return
            }

            let userId = user.uid
            let storageRef = storage.reference()
            let imageRef = storageRef.child("users/\(userId)/images/\(UUID().uuidString).jpg")
            
            imageRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    self.uploadStatus = "Upload Failed"
                } else {
                    print("Image uploaded successfully")
                    self.uploadStatus = "Upload Successful"
                    imageRef.downloadURL { url, error in
                        if let error = error {
                            print("Error getting download URL: \(error.localizedDescription)")
                        } else if let url = url {
                            self.saveImageMetadata(downloadURL: url, userId: userId)
                        }
                    }
                }
            }
    }

    private func saveImageMetadata(downloadURL: URL, userId: String) {
            let docRef = db.collection("users").document(userId).collection("images").document()
            docRef.setData([
                "url": downloadURL.absoluteString,
                "timestamp": Timestamp()
            ]) { error in
                if let error = error {
                    print("Error saving metadata: \(error.localizedDescription)")
                } else {
                    print("Metadata saved successfully")
                    self.fetchImageUrls()
                }
            }
        }

    func fetchImageUrls() {
            guard let user = Auth.auth().currentUser else {
                print("User not logged in")
                return
            }

            let userId = user.uid
            db.collection("users").document(userId).collection("images").order(by: "timestamp", descending: true).getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching documents: \(error.localizedDescription)")
                } else if let snapshot = snapshot {
                    self.imageUrls = snapshot.documents.compactMap { document in
                        document.data()["url"] as? String
                    }
                }
            }
        }
}*/
/*
import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class PhotoViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task { try await uploadPhoto() }
        }
    }
    
    func uploadPhoto() async throws {
        guard let item = selectedItem else { return }
        
        guard let photoData = try await item.loadTransferable(type: Data.self) else { return }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        try await uploadPhotoToStorage(photoData: photoData, userId: userId)
        
        print("Photo uploaded successfully")
    }
    
    private func uploadPhotoToStorage(photoData: Data, userId: String) async throws {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let photoRef = storageRef.child("users/\(userId)/photos/\(UUID().uuidString).jpg")
        
        let uploadTask = photoRef.putData(photoData, metadata: nil)
        
        do {
                _ = try await uploadTask
                print("Photo uploaded to storage successfully")
            } catch let error {
                print("Error uploading photo to storage: \(error.localizedDescription)")
                throw error
            }
            
        print("Photo uploaded to storage")
    }
}*/


//
//  ContentViewModel.swift
//  TennisPro_Orbital
//
//  Created by 宋玥溪 on 13/6/24.
//

import Foundation
import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseAuth

class PhotoViewModel: ObservableObject{
    
    @Published var selectedItem: PhotosPickerItem?{
        didSet{
            Task{try await uploadPhoto()}
        }
    }
    func uploadPhoto() async throws{
        guard let item = selectedItem else{return}
        
        guard let photoData = try await item.loadTransferable(type: Data.self) else{return }
        
        guard let photoUrl = try await UploadPhoto.uploadPhoto(withData: photoData)else{return}
        
        let userId = Auth.auth().currentUser?.uid
        
        let userIdString = userId?.description ?? ""
        
         
        
        try await Firestore.firestore().collection("users").document(userIdString).collection("videos").document().setData(["videourl": photoUrl])
        
        print("successfully uploaded")
        
        
        
    }
    
}
