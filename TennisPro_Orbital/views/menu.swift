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

            Text("Welcome to TennisPro!").font(.system(size: 45, weight: .light, design: .serif))
                .italic()
                .frame(alignment:.center)
                
            Image("tennis")
                .resizable()
                .scaledToFit()
                .frame( width:150, height: 100)
                .rotationEffect(.degrees(degreesRotating))
                .onAppear {
                    withAnimation(.easeInOut(duration: 1)
                        .speed(0.1).repeatForever(autoreverses: false)) {
                            degreesRotating = 360.0
                        }
                }
            
           
           Spacer()
            Spacer()
        
            Button(action: {
                currentShowingView="main"
            }, label: {
               Text("History")
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
           Spacer()
            }
        }
    }


