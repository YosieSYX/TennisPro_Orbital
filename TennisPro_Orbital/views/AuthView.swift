//
//  AuthView.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 28/5/24.
//

import SwiftUI

struct AuthView: View {
    @State private var currentShowingView : String = "welcome"
    @State private var userName: String=""
    var body: some View {
        if(currentShowingView=="welcome"){
            WelcomeView(currentShowingView:$currentShowingView)
        }else{
            if(currentShowingView ==  "login"){
                loginPage(currentShowingView: $currentShowingView)
            }else{
                if(currentShowingView=="sign up"){
                    signUp(currentShowingView: $currentShowingView)
                }else if(currentShowingView=="main"){
                    mainPage(currentShowingView: $currentShowingView)
                   
                }else if (currentShowingView=="upload"){
                    uploadView(currentShowingView: $currentShowingView)
                }
                
                
            }
        }
    }
}

#Preview {
    AuthView()
}
