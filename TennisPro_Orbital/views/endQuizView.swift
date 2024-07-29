//
//  endQuizView.swift
//  TennisPro_Orbital
//
//  Created by Yuexi Song on 21/7/24.
//

import SwiftUI
import FirebaseAuth
struct endQuizView: View {
    @Binding var currentShowingView: String
    let score: Int
    let num_questions: Int
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundGradient
                VStack{
                    LinearGradient(
                        colors: [.red, .blue, .green, .yellow],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .mask(
                        Text("Nicely Done!").font(.system(size: 45, weight: .light, design: .serif)).frame(alignment:.center)
                    )
                    Text("Here is your score").font(.system(size:30, weight: .light, design: .serif)).frame(alignment:.center)
                    LinearGradient(
                        colors: [.red, .blue, .green, .yellow],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .mask(
                        Text("\(score)/\(num_questions)").font(.system(size: 45, weight: .light, design: .serif)).frame(alignment:.center)
                    )
                }
                .toolbar {
                    Button(action: {
                        currentShowingView = "welcome"
                        signOut()
                    }, label: {
                        Text("Log out")
                    })
                    Button(action: {
                        currentShowingView = "menu"
                    }, label: {
                        Text("Menu")
                    })
                }
                .ignoresSafeArea()
            }
            
        }
    }
    func signOut(){
        do{
            try Auth.auth().signOut()
        }catch let signOutError as NSError{
            print("Error signing out:%@", signOutError)
        }
    }

}


