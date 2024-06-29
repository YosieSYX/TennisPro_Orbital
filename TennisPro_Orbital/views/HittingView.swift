//
//  HittingView.swift
//  TennisPro_Orbital
//
//  Created by Yuexi Song on 26/6/24.
//

import SwiftUI
import PhotosUI

struct HittingView: View {
    @Binding var currentShowingView: String
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                Text("Hitting Analysis").font(.system(size: 45, weight: .light, design: .serif)).frame(alignment:.center)
                Text("Please take a photo of your forehand hitting position.").font(.system(size: 20, weight: .light, design: .serif))
                    .italic().frame(alignment:.center)
                Text("Photo should be taken from the front of you.").font(.system(size: 20, weight: .light, design: .serif))
                    .italic()
                Text("An example is shown below.").font(.system(size: 20, weight: .light, design: .serif))
                    .italic().frame(alignment:.center)
                Image("roger forehand")
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
                    PhotosPicker(selection: $viewModel.selectedItem, matching:.any(of: [.videos, .not(.images)])) {
                        Image(systemName: "plus.circle")
                            .frame(width: 100,height: 100)
                            .frame(alignment:.bottom)
                    }
                }
            }
        }
            
    }
        
}
