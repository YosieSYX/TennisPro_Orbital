//
//  ProfileEditViewModel.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 11/7/24.
//

import Foundation
import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import Firebase

class ProfileEditViewModel:ObservableObject{
    @Published var selectedPhoto:PhotosPickerItem?{
        didSet{
            Task{
                
            }
        }
    }
    
    func uploadUserPicture(){
        
    }
    
    
    
}
