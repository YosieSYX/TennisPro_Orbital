//
//  EditProfileViewModel.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 11/7/24.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth

class EditProfileViewModel:ObservableObject{
    func uploadProfile(_ image:UIImage, user_name:String,introduction:String){
        let userId = Auth.auth().currentUser?.uid
        let userIdString = userId?.description ?? ""
        
        ProfilePhotoUpload.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users_Profile").document(userIdString).setData(["user_name":user_name,"introduction":introduction,"imageUrl":profileImageUrl])
            print("successfully upload profile image to firestore")
        }
    }
    
    
    
    
}
