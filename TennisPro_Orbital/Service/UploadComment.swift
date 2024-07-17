//
//  UploadComment.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 29/6/24.
//


import Foundation
import Firebase
import FirebaseAuth

struct UploadComment {
    func uploadComment(comment:String, documentId:String, completion:@escaping(Bool) ->Void){
        guard let uid = Auth.auth().currentUser? .uid else{return}
        
        let data = ["uid": uid,"comment":comment] as [String : Any]
        
        print("In servicd UploadComment: documentId receivd:\(documentId)")
        
        Firestore.firestore().collection("forum").document(documentId).collection("comments").document().setData(data) {error in
            if let error = error {
                print("DEBUG:Failed to upload tweet with error:\(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    
    
}
