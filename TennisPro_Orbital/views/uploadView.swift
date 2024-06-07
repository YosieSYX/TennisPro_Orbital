//
//  uploadView.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 6/6/24.
//

import SwiftUI

struct uploadView: View {
    @Binding var currentShowingView: String
    var body: some View {
        VStack{
            Text("Upload new video!")
                .font(.system(size: 30))
            Spacer()
            Button(action: {}, label: {
                VStack{
                    Image(systemName: "plus.circle")
                        .font(.system(size: 100))
                }
            })
            .frame(width: 400,height: 400)
            .background(.quaternary)
            
            Spacer()
            Spacer()
            Button(action: {
                currentShowingView="main"
            }, label: {
                Text("View history of progress")
            })
            
        }
        
        
    }
}

  
