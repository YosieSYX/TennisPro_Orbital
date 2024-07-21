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
    @State private var analysisText1: String = ""
    @State private var analysisText2: String = ""
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
                        
                        Text(analysisText1)
                            .padding()
                        
                        
                    }
                    else{
                        LinearGradient(
                            colors: [.red, .blue, .green, .yellow],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .mask(
                            Text("Backswing Analysis").font(.system(size: 45, weight: .light, design: .serif)).frame(alignment:.center)
                        )
                        Text("Please take a photo of your forehand backswing position.").font(.system(size: 17, weight: .light, design: .serif))
                            .italic().frame(alignment:.center)
                        Text("Photo should be taken from the right side, where your body is facing.").font(.system(size: 17, weight: .light, design: .serif))
                            .italic()
                        Text("An example is shown below.").font(.system(size: 17, weight: .light, design: .serif))
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
                        self.analysisText1 = analysisStatement1(for: poseResults)
                        self.analysisText2 = analysisStatement2(for: poseResults)
                    } else {
                        self.poseResults = []
                        self.analysisText1 = "No poses detected or error occurred."
                        print("Image file not processed")
                    }
                }
            } else {
                print("No uploaded image to process")
            }
        }
        
    private func analysisStatement1(for poses: [Pose]) -> String {
        if poses.isEmpty {
            return "No poses detected."
        } else {
            for pose in poses{
                let rightElbow = pose.landmark(ofType: .rightElbow)
                let rightWrist = pose.landmark(ofType: .rightWrist)
                if(rightElbow.position.y - rightWrist.position.y < 5)
                {
                    return "It would be good to stretch out your right arm a bit more."
                }
            }
            return "Your right arm position looks good!"
        }
    }
private func analysisStatement2(for poses: [Pose]) -> String {
    if poses.isEmpty {
        return "No poses detected."
    } else {
        for pose in poses{
            let rightShoulder = pose.landmark(ofType: .rightShoulder)
            let leftShoulder = pose.landmark(ofType: .leftShoulder)
            let rightAnkle = pose.landmark(ofType: .rightAnkle)
            let leftAnkle = pose.landmark(ofType: .leftAnkle)
            let shoulderLength = (pow(rightShoulder.position.x - leftShoulder.position.x,2) + pow(rightShoulder.position.y - leftShoulder.position.y,2)).squareRoot()
            let AnkleDistance = (pow(leftAnkle.position.x - rightAnkle.position.x,2) + pow(leftAnkle.position.y - rightAnkle.position.y,2)).squareRoot()
            if(AnkleDistance < shoulderLength)
            {
                return "It would be good to split your feet a bit more."
            }
        }
        return "The distance between your feet looks good!"
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
