//
//  FetchComment.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 29/6/24.
//


import Foundation
import FirebaseFirestoreSwift

struct FetchComment: Identifiable, Codable{
    var comment: String
    var uid: String
    var id: String{
        return NSUUID().uuidString
    }
    var user: FetchUser?
}
