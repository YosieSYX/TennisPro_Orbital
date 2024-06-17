//
//  FetchVideo.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 15/6/24.
//

import Foundation

struct FetchVideo: Identifiable, Decodable{
    let videoUrl: String
    var id: String{
        return NSUUID().uuidString
    }
}
