//
//  menu.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 14/6/24.
//

import SwiftUI

struct menu: View {
    @Binding var currentShowingView: String
    @State var degreesRotating = 0.0
    var body: some View {
        VStack(spacing:50){
           Spacer()
            Spacer()
            Image("Tennisbackground")
                .resizable()
                .scaledToFit()
                .frame( width:300, height: 200)
            
            Spacer()
            Text("Choose one of the options below to boost your tennis performance!").font(.system(size:25, weight: .light, design: .serif))
                .italic()
                .frame(alignment:.center)
                
        
            Button(action: {
                currentShowingView="analysis"
            }, label: {
               Text("Analysis")
           })
           .frame(width: 250,height: 20)
           .padding()
           .background(Color.black)
           .cornerRadius(10.0)
           .foregroundColor(.white)
            
           
            
            
            Button(action: {
                currentShowingView="forum"
            }, label: {
               Text("Forum")
           })
           .frame(width: 250,height: 20)
           .padding()
           .background(Color.black)
           .cornerRadius(10.0)
           .foregroundColor(.white)
            
            
            
             Button(action: {
                 currentShowingView="profile"
             }, label: {
                Text("profile")
            })
            .frame(width: 250,height: 20)
            .padding()
            .background(Color.black)
            .cornerRadius(10.0)
            .foregroundColor(.white)
            
           Spacer()
            }
        }
    }


