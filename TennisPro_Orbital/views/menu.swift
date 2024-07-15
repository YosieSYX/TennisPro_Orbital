//
//  menu.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 14/6/24.
//

import SwiftUI
let NewPink = UIColor(named: "Pink") ?? UIColor.pink
let green1 = UIColor(named: "green") ?? UIColor.green
let green2 = UIColor(named: "greener") ?? UIColor.green
let greenColor = Color(green1)
let greener = Color(green2)
let backgroundGradient = LinearGradient(
    colors: [Color.white, greenColor],
    startPoint: .top, endPoint: .bottom)

struct menu: View {
    @Binding var currentShowingView: String
    @State var degreesRotating = 0.0
    @Environment(\.openURL) var openURL
    var body: some View {
        ZStack{
            backgroundGradient
            VStack(spacing:50){
                Image("Tennisbackground")
                    .resizable()
                    .scaledToFit()
                    .frame( width:400, height: 275)
                Text("This is your tennis world!").font(.system(size:30, weight: .light, design: .serif))
                    .italic()
                    .frame(alignment:.center)
                    .foregroundColor(.pink)
                
                HStack{
                    Image("analysis") // Replace with your image name
                        .resizable()
                        .frame(width: 80, height: 80) // Adjust the size as needed
                        .foregroundColor(.yellow)
                    Button(action: {
                        currentShowingView="analysis"
                    }, label: {
                        Text("Analysis")
                            .font(.system(size: 20))
                    })
                    .frame(width: 200,height: 20)
                    .padding()
                    .background(greener)
                    .cornerRadius(10.0)
                    .foregroundColor(.white)
                }
                HStack{
                    Image("forum1") // Replace with your image name
                        .resizable()
                        .frame(width: 80, height: 80) // Adjust the size as needed
                        .foregroundColor(.yellow)
                    Button(action: {
                        currentShowingView="forum"
                    }, label: {
                        Text("Forum")
                            .font(.system(size: 20))
                    })
                    .frame(width: 200,height: 20)
                    .padding()
                    .background(greener)
                    .cornerRadius(10.0)
                    .foregroundColor(.white)
                }
                HStack{
                    Image("news") // Replace with your image name
                        .resizable()
                        .frame(width: 80, height: 80) // Adjust the size as needed
                        .foregroundColor(.yellow)
                    Button(action: {
                        openURL(URL(string: "http://www.tennisnews.com/category/tennis-news/")!)
                    }, label: {
                        Text("Tennis News")
                            .font(.system(size: 20))
                    })
                    .frame(width: 200,height: 20)
                    .padding()
                    .background(greener)
                    .cornerRadius(10.0)
                    .foregroundColor(.white)
                }
            }
        }
        .ignoresSafeArea()
    }

}

