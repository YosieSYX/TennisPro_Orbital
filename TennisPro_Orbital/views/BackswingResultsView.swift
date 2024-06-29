//
//  BackswingResultsView.swift
//  TennisPro_Orbital
//
//  Created by Yuexi Song on 27/6/24.
//


import SwiftUI
import FirebaseStorage
import FirebaseAuth

struct BackswingResultsView: View {
    @State private var uploadedImage: UIImage?
    @Binding var currentShowingView: String
    
    var body: some View {
        VStack {
            if let image = uploadedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
            } else {
                Button("Fetch Uploaded Photo") {
                    fetchPhoto()
                }
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
}
