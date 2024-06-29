//
//  ForumComment.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 29/6/24.
//

import Foundation
import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import Firebase

class ForumComment: ObservableObject{
    @Published var comments = [FetchComment]()
    @Published var didUploadComment = false
    let service = UploadComment()
    var documentId:String
    
    
    init(documentId: String){
        self.documentId=documentId
        Task{
            do{
                try await fetchComments(forDocumentId: documentId)
                print("comments successfully fetched")
            }catch{
                print("Failed to fetch comments:\(error.localizedDescription)")
            }
        }
        
    }
    
    
    
    func uploadComment(withComment comment: String, forDocumentId documentId: String){
        service.uploadComment(comment: comment, documentId: documentId){success in
            if success{//dismiss screen
                self.didUploadComment = true
                print("successfully upload comment")
            }else{//show error message to user
                
            }
        }
    }
    
    
    @MainActor
    func fetchComments(forDocumentId documentId:String) async throws{
        let snapshot=try await Firestore.firestore().collection("forum").document(documentId).collection("comments").getDocuments()
        for doc in snapshot.documents{
            print(doc.data())
        }
        self.comments = snapshot.documents.compactMap(
            { try?$0.data(as:FetchComment.self)
            })

        
    }
    
}
