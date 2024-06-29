//
//  FetchComment.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 29/6/24.
//


import Foundation

struct FetchComment: Identifiable, Decodable{
    let uid: String
    let comment: String
    let timestamp: String
   
    var id: String{
        return NSUUID().uuidString
    }
}
