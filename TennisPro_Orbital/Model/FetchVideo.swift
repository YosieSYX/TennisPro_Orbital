//
//  FetchVideo.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 15/6/24.
//

import Foundation
import FirebaseFirestoreSwift

struct FetchVideo: Identifiable,Codable{
    @DocumentID var id: String?
    let videoUrl: String
   
}
