//
//  AnalysisView.swift
//  TennisPro_Orbital
//
//  Created by Yuexi Song on 26/6/24.
//

import SwiftUI
let yellow = UIColor(named: "yellow") ?? UIColor.yellow
let Yellow = Color(yellow)

struct AnalysisView: View {
    @Binding var currentShowingView: String
    var body: some View {
        NavigationView{
            ZStack{
                backgroundGradient
                VStack(spacing:50){
                    
                    Text("Choose 1 of the options below to boost your").font(.system(size: 25, weight: .light, design: .serif))
                        .italic()
                        .foregroundColor(Yellow)
                    HStack{
                        
                        Image("tennis 1")
                            .resizable()
                            .scaledToFit()
                            .frame(width:75, height: 40)
                        Text("performance")
                            .font(.system(size: 25, weight: .light, design: .serif))
                            .italic()
                            .foregroundColor(Yellow)
                    }
                    
                    
                    Button(action: {
                        currentShowingView="backswing"
                    }, label: {
                        Text("Backswing Analysis")
                    })
                    .frame(width: 250,height: 20)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10.0)
                    .foregroundColor(.white)
                    
                    
                    Button(action: {
                        currentShowingView="hitting"
                    }, label: {
                        Text("Hitting position Analysis")
                    })
                    .frame(width: 250,height: 20)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10.0)
                    .foregroundColor(.white)
                }
            }
            .ignoresSafeArea()
        }
    }
}


