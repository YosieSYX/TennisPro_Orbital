//
//  uploadView.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 6/6/24.
//

import SwiftUI
import PhotosUI

struct uploadView: View {
    @Binding var currentShowingView: String
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        VStack{
            Text("Upload new video!")
                .font(.system(size: 30))
            Spacer()
            Button(action: {
            }){
                PhotosPicker(selection: $viewModel.selectedItem, matching:.any(of: [.videos, .not(.images)])) {
                    Image(systemName: "plus.circle")
                }
            }
            .frame(width: 800,height: 600)
            .background(.quaternary)
            
            Spacer()
            Spacer()
            Button(action: {
                currentShowingView="main"
            }, label: {
                Text("View history of progress")
                    .font(.system(size: 30))
            })
            
        }
        
        
    }
}

  
