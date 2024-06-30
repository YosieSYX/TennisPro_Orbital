//
//  BackswingResultsView.swift
//  TennisPro_Orbital
//
//  Created by Yuexi Song on 27/6/24.
//

import SwiftUI
import FirebaseStorage
import FirebaseAuth
import MLKitPoseDetection

struct BackswingResultsView: View {
    @State private var detection = Detection()
    @State private var uploadedImage: UIImage?
    @State private var poseResults: [Pose] = []
    @State private var analysisText: String = ""
    @Binding var currentShowingView: String
    
    var body: some View {
        VStack {
            if let image = uploadedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
                
                Button("Process Image") {
                    processImage()
                }
                .padding()
                
                Text(analysisText)
                    .padding()
                Button(action: {
                    currentShowingView="menu"
                }, label: {
                    Text("Go back to menu page.")
                })
            } else {
                Button("Fetch Uploaded Photo") {
                    fetchPhoto()
                }
                .padding()
            }
        }
        .padding()
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
                var rightElbow = pose.landmark(ofType: .rightElbow)
                var rightWrist = pose.landmark(ofType: .rightWrist)
                if(rightElbow.position.y - rightWrist.position.y < 5)
                {
                    return "Stretch out your right arm a bit more!"
                }
            }
            return "Your position looks good!"
        }
    }
}
