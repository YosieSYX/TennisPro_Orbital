//
//  BackswingView.swift
//  TennisPro_Orbital
//
//  Created by Yuexi Song on 26/6/24.
//

import SwiftUI
import PhotosUI
import FirebaseStorage


struct BackswingView: View {
    @Binding var currentShowingView: String
    @StateObject var viewModel = PhotoViewModel()
    var body: some View {
        NavigationStack{
            
            VStack{
                Text("Backswing Analysis").font(.system(size: 45, weight: .light, design: .serif)).frame(alignment:.center)
                Text("Please take a photo of your forehand backswing position.").font(.system(size: 20, weight: .light, design: .serif))
                    .italic().frame(alignment:.center)
                Text("Photo should be taken from the right side, where your body is facing.").font(.system(size: 20, weight: .light, design: .serif))
                    .italic()
                Text("An example is shown below.").font(.system(size: 20, weight: .light, design: .serif))
                    .italic().frame(alignment:.center)
                Image("Djokovic")
                    .resizable()
                    .scaledToFit()
                    .frame(width:300, height: 200)
                    .toolbar{
                        Button(action: {
                            currentShowingView="welcome"
                        }, label: {
                            Text("Log out")
                        })
                    }
                    .toolbar{
                        Button(action: {
                            currentShowingView="menu"
                        }, label: {
                            Text("menu")
                        })
                    }
                Spacer()
                
                Button(action: {
                }){
                    PhotosPicker(selection: $viewModel.selectedItem, matching:.images) {
                        Image(systemName: "plus.circle")
                            .frame(width: 100,height: 100)
                        .frame(alignment:.bottom)}
                }
                Button(action: {
                    currentShowingView="backswingAnalysis"
                }, label: {
                   Text("Get results")
               })
               .frame(width: 250,height: 20)
               .padding()
               .cornerRadius(10.0)
               .foregroundColor(.black)
                
            }
        }
    }
}

 
    /*func uploadPhoto(){
        guard selectedImage != nil else{
            return
        }
        let storageRef = Storage.storage().reference()
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        guard imageData != nil else {
            return
        }
        
        let fileRef = storageRef.child("images/\(UUID().uuidString).jpg")
    }*/
