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
                }else if(currentShowingView=="menu"){
                    menu(currentShowingView: $currentShowingView)
                }else if(currentShowingView=="forum"){
                    forum(currentShowingView: $currentShowingView)
                }
                else if (currentShowingView=="profile"){
                    userProfile(currentShowingView: $currentShowingView)
                }
                else if(currentShowingView=="analysis"){
                    AnalysisView(currentShowingView: $currentShowingView)
                }
                else if(currentShowingView=="backswing"){
                    BackswingView(currentShowingView: $currentShowingView)
                }
                else if(currentShowingView=="hitting"){
                    HittingView(currentShowingView: $currentShowingView)
                }
                else if(currentShowingView=="backswingAnalysis"){
                    BackswingResultsView(currentShowingView: $currentShowingView)
                }
                
                
                
                
                
            }
        }
    }
}

#Preview {
    AuthView()
}
