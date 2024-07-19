//
//  FetchPost.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 10/7/24.
//

import Foundation
import FirebaseFirestoreSwift

struct FetchPost: Identifiable,Codable{
    @DocumentID var id: String?
    let videoUrl: String
    let userId:String
    
}

