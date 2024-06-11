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
    @State private var name: String=""
    @State private var showAlert: Bool=false
    @State private var errorMessage: String = ""
    var body: some View {
       
        VStack(spacing:30){
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
                
                HStack{
                    Image(systemName: "lock")
                    TextField("name",text: $name)
                    Spacer()
                    if(name.count != 0){
                        Image(systemName:"checkmark")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
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
                Button{
                    print("enter create user")
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error=error{
                        print ("there is an error: ", error.localizedDescription)
                        showAlert=true
                        errorMessage=error.localizedDescription
                        return
                    }
                        else{
                        
                        withAnimation{self.currentShowingView = "login"}
                        
                    }
                    
                }} label: {
                    
                    Text("Create New Account")
                        .foregroundStyle(.white)
                }
                .alert(isPresented: $showAlert){
                    Alert(title: Text("Error"),message: Text(errorMessage),dismissButton: .default(Text("Dismiss")))
                }
                    
                
                 
                .frame(width: 800,height: 50)
                .background(Color.black)
                .cornerRadius(5)
                
            }
        
        
        
        
        
        
    }
}


