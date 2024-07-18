//
//  UserService.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 16/7/24.
//

import Foundation
import FirebaseFirestore
struct UserService{
    func fetchUser(WithUid uid:String, completion:@escaping(FetchUser)->Void){
        Firestore.firestore().collection("users_Profile").document(uid).getDocument { snapshot,error in
            guard let snapshot =  snapshot else{
                return
            }
            guard let user = try? snapshot.data(as:FetchUser.self)else {return}
            completion(user)
        }
    }
}
