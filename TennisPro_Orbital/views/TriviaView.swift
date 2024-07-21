//
//  TriviaView.swift
//  TennisPro_Orbital
//
//  Created by Yuexi Song on 19/7/24.
//

import SwiftUI

struct TriviaView: View {
    @Environment(\.openURL) var openURL
    @Binding var currentShowingView: String
    var body: some View {
        ZStack{
            backgroundGradient
            VStack{
                Text("Time for more tennis knowledge!")
                    .font(.system(size: 25, weight: .light, design: .serif)).frame(alignment:.center)
                
                Text("Test your knowledge of tennis here")
                    .font(.system(size: 20, weight: .light, design: .serif)).frame(alignment:.center)
                Button(action: {
                    currentShowingView = "QuizView"
                }, label: {
                    Text("Tennis Trivia")
                        .font(.system(size: 20))
                })
                .frame(width: 200,height: 20)
                .padding()
                .background(greener)
                .cornerRadius(20.0)
                .foregroundColor(.white)
                
                
                Text("Check out the tennis news here")
                    .font(.system(size: 20, weight: .light, design: .serif)).frame(alignment:.center)
                
                Button(action: {
                    openURL(URL(string: "http://www.tennisnews.com/category/tennis-news/")!)
                }, label: {
                    Text("Tennis News")
                        .font(.system(size: 20))
                })
                .frame(width: 200,height: 20)
                .padding()
                .background(greener)
                .cornerRadius(20.0)
                .foregroundColor(.white)
            }
        }
    }
}


