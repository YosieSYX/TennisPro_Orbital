//
//  Detection.swift
//  TennisPro_new
//
//  Created by Yuexi Song on 14/6/24.
//

import SwiftUI
import AVFoundation
import MLKitPoseDetection
import MLKitVision

class Detection {
    let options: PoseDetectorOptions
    let poseDetector: PoseDetector
    
    init() {
        // Initialize the options
        options = PoseDetectorOptions()
        options.detectorMode = .singleImage
        
        // Initialize the pose detector with the options
        poseDetector = PoseDetector.poseDetector(options: options)
    }
    /*
    // make sure to call this from a background queue
    func imageFromVideo(url: URL, at time: TimeInterval) async throws -> UIImage {
        let asset = AVURLAsset(url: url)

        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImageGenerator.appliesPreferredTrackTransform = true
        assetImageGenerator.apertureMode = AVAssetImageGenerator.ApertureMode.encodedPixels

        let cmTime = CMTime(seconds: time, preferredTimescale: 60)
        let thumbnailImage = try await assetImageGenerator.image(at: cmTime).image
        return UIImage(cgImage: thumbnailImage)
    }
    
    func processVideo(url: URL, at time: TimeInterval) async {
        do {
            let image = try await imageFromVideo(url: url, at: time)
            // Assume VisionImage is a part of your project and initialize it with the image
            let visionImage = VisionImage(image: image)
            visionImage.orientation = image.imageOrientation
            // Now you can use visionImage with poseDetector
            getResults(from: visionImage)
        } catch {
            print("Failed to generate image from video: \(error)")
        }
    }*/
    func imageOrientation(
      deviceOrientation: UIDeviceOrientation,
      cameraPosition: AVCaptureDevice.Position
    ) -> UIImage.Orientation {
      switch deviceOrientation {
      case .portrait:
        return cameraPosition == .front ? .leftMirrored : .right
      case .landscapeLeft:
        return cameraPosition == .front ? .downMirrored : .up
      case .portraitUpsideDown:
        return cameraPosition == .front ? .rightMirrored : .left
      case .landscapeRight:
        return cameraPosition == .front ? .upMirrored : .down
      case .faceDown, .faceUp, .unknown:
        return .up
      }
    }
    func getResults(from image: UIImage, completion: @escaping ([Pose]?) -> Void) {
            DispatchQueue.global(qos: .userInitiated).async {
                var results: [Pose]?
                do {
                    let visionImage = VisionImage(image: image)
                    visionImage.orientation = image.imageOrientation
                    results = try self.poseDetector.results(in: visionImage)
                } catch let error {
                    print("Failed to detect pose with error: \(error.localizedDescription).")
                    results = nil
                }
                
                DispatchQueue.main.async {
                    completion(results)
                }
            }
        }
    /*func getResults(from image: UIImage) -> [Pose]?{
        var results: [Pose]
        do {
            let visionImage = VisionImage(image: image)
            visionImage.orientation = image.imageOrientation
            results = try poseDetector.results(in: visionImage)
            return results
        } catch let error {
            print("Failed to detect pose with error: \(error.localizedDescription).")
            return nil
        }
        guard !results.isEmpty else {
            print("Pose detector returned no results.")
            return nil
        }
        
        // Success. Get pose landmarks here.

    }*/
   
     
    /*
    func getResults(from image: UIImage, completion: @escaping ([Pose]?) -> Void) {
            DispatchQueue.global().async {
                var results: [Pose]?
                do {
                    // Assume VisionImage is a part of your project and initialize it with the image
                    let visionImage = VisionImage(image: image)
                    visionImage.orientation = image.imageOrientation
                    results = try self.poseDetector.results(in: visionImage)
                } catch let error {
                    print("Failed to detect pose with error: \(error.localizedDescription).")
                }
                
                if let results = results, results.isEmpty {
                    print("Pose detector returned no results.")
                }
                
                // Success. Get pose landmarks here.
                if let results = results {
                    for pose in results {
                        for landmark in pose.landmarks {
                            print("Landmark: \(landmark.type), Position: \(landmark.position)")
                        }
                    }
                }

                // Call completion handler with results
                DispatchQueue.main.async {
                    completion(results)
                }
            }
        }*/
    // Additional methods can be added here if needed
}

