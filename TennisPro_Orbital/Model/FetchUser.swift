//
//  FetchUser.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 12/7/24.
//

import Foundation
import FirebaseFirestoreSwift

struct FetchUser:Identifiable,Codable{
    var user_name:String = "User12345"
    var introduction:String = "This user doesn't have an introduction"
    var imageUrl:String = "default"
    
    var id:String{
        return NSUUID().uuidString
    }
    
}
