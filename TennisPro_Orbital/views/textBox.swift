//
//  textBox.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 29/6/24.
//


import SwiftUI

struct textBox: View {
    @Binding var isTextfieldVisible: Bool
    @State var comment:String = ""
    @ObservedObject var viewModel:ForumComment
    
    let id:String
    
    init(isTextfieldVisible: Binding<Bool>,id: String){
        self._isTextfieldVisible = isTextfieldVisible
        self.id = id
        self.viewModel = ForumComment(documentId: id)
    }
    
    
    var body: some View {
        NavigationView{
            VStack{

             TextField("Enter your comment here", text: $comment)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .lineLimit(10)
                    .multilineTextAlignment(.leading)
                Spacer()
                    .toolbar{
                        ToolbarItem(placement:.navigationBarTrailing) {
                            Button(action: {
                                isTextfieldVisible = false
                            }, label: {
                                Image(systemName: "xmark")
                            })
                            
                        }
                        ToolbarItem(placement: .bottomBar) {
                            Button(action: {
                                viewModel.uploadComment(withComment: comment, forDocumentId: id)
                            }, label: {
                                HStack{
                                    Image(systemName: "checkmark.circle")
                                    Text("Submit")
                                }
                            })
                        }
                    }
            }
            .onReceive(viewModel.$didUploadComment){ success in
                if success{
                    isTextfieldVisible = false
                }
                
            }
            .navigationTitle("Comment")
        }
    }
}

