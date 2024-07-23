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

             
}

