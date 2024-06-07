//
//  WelcomeView.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 5/6/24.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var currentShowingView: String
    @State var degreesRotating = 0.0
    
    var body: some View {
        NavigationStack{
                VStack(alignment: .center){
                    Group{
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
                        
                        Button(action: {
                            withAnimation{self.currentShowingView = "login"}
                        }, label: {
                            Text("Continue")
                                .foregroundColor(.blue)
                                .frame(width: 200, height: 40)
                                .background(Color.white)
                                .cornerRadius(15)
                                .padding()
                        })
                    }.frame(maxHeight: .infinity, alignment: .bottom)
                }
               
            }
    }
}


