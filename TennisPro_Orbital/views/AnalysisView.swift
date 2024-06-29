//
//  AnalysisView.swift
//  TennisPro_Orbital
//
//  Created by Yuexi Song on 26/6/24.
//

import SwiftUI

struct AnalysisView: View {
    @Binding var currentShowingView: String
    var body: some View {
        VStack(spacing:50){
            
            Text("Which position do you want to analyse first?").font(.system(size: 20, weight: .light, design: .serif))
                .italic()
                .frame(alignment:.center)

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
   
}


