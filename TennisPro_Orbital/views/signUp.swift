//
//  signUp.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 28/5/24.
//

import SwiftUI
import FirebaseAuth

struct signUp: View {
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
                if(password.count != 0){
                    Image(systemName:password.isValidPassword(_password: password) ? "checkmark":"xmark")
                        .fontWeight(.bold)
                        .foregroundColor(password.isValidPassword(_password: password) ? .green: .red)
                }
            }
            .padding()
            .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .foregroundColor(.black))
            
            
            Button(action: {
                withAnimation{self.currentShowingView = "login"}
            }){
                Text("Already have an account? ")
            }
            Spacer()
            Spacer()
            Text(password.isValidPassword(_password: password) ? "minimum 6 char long, 1 uppercase letter, 1 special char " : "")
            Button{Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error=error{
                    print (error)
                    return
                }
                if let authResult=authResult{
                    print(authResult.user.uid)
                    loginPage(currentShowingView: self.$currentShowingView)
                }
            }} label: {
                
                Text("Create New Account")
            }
            
        }
    }
}


