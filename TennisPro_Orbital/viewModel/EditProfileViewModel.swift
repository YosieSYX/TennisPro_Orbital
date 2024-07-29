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
    func uploadProfile(userId:String,_ image:UIImage, user_name:String,introduction:String){
        
        
        ProfilePhotoUpload.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users_Profile").document(userId).setData(["user_name":user_name,"introduction":introduction,"imageUrl":profileImageUrl])
            print("successfully upload profile image to firestore")
        }
    }
    
    
    
    
}
