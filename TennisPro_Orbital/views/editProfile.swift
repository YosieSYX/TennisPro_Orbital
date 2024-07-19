//
//  editProfile.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 11/7/24.
//

import SwiftUI
import PhotosUI
import AVKit
import Kingfisher

struct editProfile: View {
    @State var userName:String
    @State var introduction:String 
    @State var ImageUrl:String
    @State private var selectedImage:UIImage?
    @State private var profileImage:Image?
    @State private var isPhotoPickerPresented = false
    @StateObject var viewModel = EditProfileViewModel()
    var body: some View {
        VStack(){
            HStack{
                Spacer()
                Text("Edit profile")
                    .font(.title)
                Spacer()
            }
            Spacer()
            Text("User name:")
                .font(.subheadline)
           
                TextField("Choose a user name!" , text: $userName)
                    .padding()
                    .frame(width: 390, height: 50)
                    .border(Color.black)
            
            Text("Introdution:")
                .font(.subheadline)
            TextField("Talk about yourself!",text: $introduction)
                .padding()
                .frame(width: 390, height: 80)
                .border(Color.black)
           Spacer()
            Text("Profile picture:")
             .font(.subheadline)
            
            Button(action: {
               isPhotoPickerPresented = true
                
            }, label: {
                HStack{
                    Spacer()
                    if let profileImage = profileImage{
                        profileImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width:150,height: 150)
                            .overlay(Circle().stroke(Color.black,lineWidth: 2))
                    }else{
                        KFImage(URL(string: ImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width:150,height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.black,lineWidth: 1))
                    }
                   
                        Spacer()
                    
                    }
                
                   
            })
            .sheet(isPresented: $isPhotoPickerPresented,onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
            Spacer()
            Spacer()
            if let selectedImage = selectedImage {
                HStack{
                    Spacer()
                    Button(action: {
                        viewModel.uploadProfile(selectedImage, user_name: userName, introduction: introduction)
                    }, label: {
                        Text("Finish")
                            .foregroundStyle(.white)
                    })
                    .frame(width:400, height: 20)
                    .background(Color(.black))
                    Spacer()
                }
            }
         
        }
           
    }
    func loadImage(){
        guard let selectedImage = selectedImage else{return}
        profileImage = Image(uiImage: selectedImage)
    }
}

