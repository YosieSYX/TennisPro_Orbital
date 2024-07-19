//
//  ProfileFilterViewModel.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 10/7/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

enum ProfileFilterViewModel:Int,CaseIterable{
    case forumPost
    case history
    
    var title:String{
        switch self{
        case.forumPost:return "Post"
        case.history:return "history"
        }
    }
}

class ForumPost:ObservableObject{
    @Published var posts = [FetchPost]()
    @Published var document = FetchUser()

    
    init(){
        Task{
            do{
                try await fetchUser()
                print("posts successfully fetched")
                try await fetchPost()
                
            }catch{
                print("Failed to fetch posts:\(error.localizedDescription)")
            }
        }
        
    }
    
    @MainActor
    func fetchUser() async  throws{
        let userId = Auth.auth().currentUser?.uid
        let userIdString = userId?.description ?? ""
        let ref = Firestore.firestore().collection("users_Profile").document(userIdString)
        
        ref.getDocument{ [weak self] (document,error) in
            if let document = document, document.exists{
                do{
                    self?.document = try document.data(as: FetchUser.self) 
                    
                }catch{
                    print("DEBUG:error when mapping:\(error.localizedDescription)")
                }
            }else{
                print("user not initialize his profile ")
                self?.document = FetchUser()
            }
        }
        
    }

    
    
    @MainActor
    func fetchPost() async throws{
        let userId = Auth.auth().currentUser?.uid
        let _ = userId?.description ?? ""
        let ref = Firestore.firestore().collection("forum")
        print("here1")
        ref.whereField("userId", isEqualTo: userId).getDocuments(){snapshot,error in
            if let error = error{
                print("error getting posts\(error.localizedDescription)")
                return
            }
            print("here2")
            guard let documentFetched = snapshot?.documents else{
                print("No post")
                return
            }
           print("here3")
            self.posts=documentFetched.compactMap(
                {try?$0.data(as: FetchPost.self)
            })
        }
        print("here2")
        
    }
}
