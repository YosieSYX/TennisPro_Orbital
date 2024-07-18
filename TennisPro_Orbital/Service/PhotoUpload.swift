//
//  PhotoUpload.swift
//  TennisPro_Orbital
//
//  Created by Yuexi Song on 27/6/24.
//
import Foundation
import FirebaseStorage
import FirebaseAuth

struct UploadPhoto{
    static func uploadPhoto(withData photoData: Data) async throws -> String?{
        let userId = Auth.auth().currentUser?.uid
        let userIdString = userId?.description ?? ""
        let ref = Storage.storage().reference().child(userIdString).child("backswing.jpeg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        do{
            let _ = try await ref.putDataAsync(photoData,metadata: metadata)
            let url = try await ref.downloadURL()
            return url.absoluteString
        }catch{
            print("BUG: Failed to upload videos \(error.localizedDescription)")
            return nil
        }
    }
}
