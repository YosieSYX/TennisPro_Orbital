//
//  BackswingView.swift
//  TennisPro_Orbital
//
//  Created by Yuexi Song on 26/6/24.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseAuth
import MLKitPoseDetection



struct BackswingView: View {
    @Binding var currentShowingView: String
    @State private var detection = Detection()
    @State private var uploadedImage: UIImage?
    @State private var poseResults: [Pose] = []
    @State private var analysisText: String = ""
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundGradient
                VStack{
                    if let image = uploadedImage{
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding()
                        
                        Text(analysisText)
                            .padding()
                        
                        
                    }
                    else{
                        Text("Backswing Analysis").font(.system(size: 45, weight: .light, design: .serif)).frame(alignment:.center)
                        Text("Please take a photo of your forehand backswing position.").font(.system(size: 20, weight: .light, design: .serif))
                            .italic().frame(alignment:.center)
                        Text("Photo should be taken from the right side, where your body is facing.").font(.system(size: 20, weight: .light, design: .serif))
                            .italic()
                        Text("An example is shown below.").font(.system(size: 20, weight: .light, design: .serif))
                            .italic().frame(alignment:.center)
                        Image("Djokovic")
                            .resizable()
                            .scaledToFit()
                            .frame(width:300, height: 200)
                        Spacer()
                        Text("Upload photo here for analysis")
                        PhotosPicker(selection: $viewModel.selectedItem, matching: .images) {
                            Image(systemName: "plus.circle")
                                .frame(width: 200,height: 100)
                        }
                        .onChange(of: viewModel.selectedItem) { newItem in
                            Task {
                                if let newItem = newItem {
                                    if let data = try? await newItem.loadTransferable(type: Data.self),
                                       let image = UIImage(data: data) {
                                        uploadedImage = image
                                        // Process image and navigate to menu
                                        processImage()
                                    }
                                }
                            }
                        }
                    }
                }
                .toolbar {
                    Button(action: {
                        currentShowingView = "welcome"
                    }, label: {
                        Text("Log out")
                    })
                    Button(action: {
                        currentShowingView = "menu"
                    }, label: {
                        Text("Menu")
                    })
                }
            }
        }
        .ignoresSafeArea()
    }
        private func fetchPhoto() {
            guard let userId = Auth.auth().currentUser?.uid else {
                print("User not authenticated")
                return
            }
            
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let photoRef = storageRef.child(userId).child("backswing.jpeg") // Adjust path as per your Firebase Storage structure
            
            Task {
                do {
                    let imageData = try await downloadImageData(from: photoRef)
                    self.uploadedImage = UIImage(data: imageData)
                } catch {
                    print("Error downloading image: \(error.localizedDescription)")
                }
            }
        }
    
        private func downloadImageData(from reference: StorageReference) async throws -> Data {
            let maxDownloadSizeBytes: Int64 = 10 * 1024 * 1024 // 10 MB (adjust as per your needs)
            
            // Using async/await with completion handler
            let data = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Data, Error>) in
                reference.getData(maxSize: maxDownloadSizeBytes) { data, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let data = data {
                        continuation.resume(returning: data)
                    } else {
                        // Handle unexpected cases where data is nil without error
                        continuation.resume(throwing: NSError(domain: "FirebaseError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to download data."]))
                    }
                }
            }
            
            return data
        }
        private func processImage() {
            fetchPhoto()
            if let image = uploadedImage {
                detection.getResults(from: image) { poseResults in
                    if let poseResults = poseResults {
                        self.poseResults = poseResults
                        self.analysisText = analysisStatement(for: poseResults)
                    } else {
                        self.poseResults = []
                        self.analysisText = "No poses detected or error occurred."
                        print("Image file not processed")
                    }
                }
            } else {
                print("No uploaded image to process")
            }
        }
        
        private func analysisStatement(for poses: [Pose]) -> String {
            if poses.isEmpty {
                return "No poses detected."
            } else {
                for pose in poses{
                    let rightElbow = pose.landmark(ofType: .rightElbow)
                    let rightWrist = pose.landmark(ofType: .rightWrist)
                    if(rightElbow.position.y - rightWrist.position.y < 5)
                    {
                        return "Stretch out your right arm a bit more!"
                    }
                }
                return "Your position looks good!"
            }
        }
    
}



 
    /*func uploadPhoto(){
        guard selectedImage != nil else{
            return
        }
        let storageRef = Storage.storage().reference()
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        guard imageData != nil else {
            return
        }
        
        let fileRef = storageRef.child("images/\(UUID().uuidString).jpg")
    }*/
