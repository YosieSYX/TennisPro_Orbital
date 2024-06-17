//
//  mainPage.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 28/5/24.
//

import SwiftUI

struct mainPage: View {
 @Binding var currentShowingView: String
    var body: some View {
        NavigationStack{
            Text("Hi, welcome to TennisPro")
            ScrollView{
                List{
                    
                    
                }
            }
                  
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
            
                  Button(action: {
                    currentShowingView="upload"
                  }, label: {
                      Image(systemName: "plus.circle")
                          .font(.system(size: 50))
                  })
            .navigationTitle("History")
        }
     
        
    }
}
