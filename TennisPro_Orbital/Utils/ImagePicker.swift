//
//  ImagePicker.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 11/7/24.
//

import Foundation
import SwiftUI
struct ImagePicker:UIViewControllerRepresentable{
    @Binding var selectedImage:UIImage?
    @Environment(\.presentationMode) var presentationMode
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker=UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    
    
    
}

extension ImagePicker{
    class Coordinator: NSObject,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
        let parent:ImagePicker
         
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image=info[.originalImage]as? UIImage else{return}
            parent.selectedImage = image
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
