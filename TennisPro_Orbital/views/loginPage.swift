//
//  loginPage.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 27/5/24.
//

import SwiftUI
import FirebaseAuth

struct loginPage: View {
    @Binding var currentShowingView: String
    @State private var email:String=""
    @State private var password:String=""
    var body: some View {
        VStack{
            Text("TennisPro")
            Spacer()
            HStack{
                Image(systemName: "mail")
                TextField("Email",text: $email)
                Spacer()
                if(email.count != 0){
                    Image(systemName: email.isValidEmail() ? "checkmark": "xmark")
                        .fontWeight(.bold)
                        .foregroundColor(email.isValidEmail() ? .green: .red )
                }
            }
            .padding()
            .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .foregroundColor(.black))
            HStack{
                Image(systemName: "lock")
                SecureField("password",text: $password)
                Spacer()
            }
            .padding()
            .overlay(
               RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .foregroundColor(.black)
               )
            
            
            Button(action: {
                withAnimation{self.currentShowingView = "sign up"}
            }){
                Text("Don't have an account?")
            }
            Spacer()
            Spacer()
            Button{
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error{
                        print(error)
                        return
                    }
                    if let authResultt=authResult{
                        print(authResult?.user.uid)
                    }
                    mainPage()
                }
            } label: {
                Text("Sign In")
            }
            
        }
        
    }
        
        
}