//
//  ForumVideo.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 14/6/24.
//


import Foundation
import FirebaseStorage
import FirebaseAuth

struct ForumVideo{
    static func uploadVideo(withData postVideoData: Data) async throws -> String?{
        let filename=NSUUID().uuidString+".mp4"
        
        let ref = Storage.storage().reference().child("forum").child("video").child(filename)

        let metadata = StorageMetadata()
        metadata.contentType="video/quicktime"
        do{
            let _ = try await ref.putDataAsync(postVideoData,metadata: metadata)
            let forumurl = try await ref.downloadURL()
            return forumurl.absoluteString
        }catch{
            print("BUG: Failed to upload videos \(error.localizedDescription)")
            return nil
        }
    }
}
