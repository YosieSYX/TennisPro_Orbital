//
//  FetchPost.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 10/7/24.
//

import Foundation
import FirebaseFirestoreSwift

struct FetchPost: Identifiable,Codable{
    let videoId: String
    let videoUrl: String
    var id:String{
        return NSUUID().uuidString
    }
}

