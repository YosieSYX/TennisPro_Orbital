//
//  UploadVideo.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 13/6/24.
//

import Foundation
import FirebaseStorage
import FirebaseAuth

struct UploadVideo{
    static func uploadVideo(withData videoData: Data) async throws -> String?{
        let userId = Auth.auth().currentUser?.uid
        let userIdString = userId?.description ?? ""
        let ref = Storage.storage().reference().child(userIdString).child("video.mp4")

        let metadata = StorageMetadata()
        metadata.contentType = "video/quicktime"
        do{
            let _ = try await ref.putDataAsync(videoData,metadata: metadata)
            let url = try await ref.downloadURL()
            return url.absoluteString
        }catch{
            print("BUG: Failed to upload videos \(error.localizedDescription)")
            return nil
        }
    }
}
