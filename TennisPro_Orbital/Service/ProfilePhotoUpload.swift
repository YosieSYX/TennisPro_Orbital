//
//  ProfilePhotoUpload.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 11/7/24.
//

import Foundation
import UIKit
import FirebaseAuth
import PhotosUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase
import FirebaseStorage


struct ProfilePhotoUpload{
    static func uploadImage(image:UIImage,completion:@escaping(String)->Void){
        guard let imageData = image.jpegData(compressionQuality: 0.5) else{ return }
        
        let userId = Auth.auth().currentUser?.uid
        let userIdString = userId?.description ?? ""
        let ref = Storage.storage().reference().child("users_Profile").child(userIdString).child("profile_Photo")
        ref.putData(imageData,metadata: nil){_,error in
            if let error = error{
                print("DEBUG: fail to upload profile picture\(error.localizedDescription)")
                return
            }
            ref.downloadURL { imageUrl,_ in
                guard let imageUrl = imageUrl?.absoluteString else{return }
                completion(imageUrl)
            }
            
        }
        
    }
}
