//
//  TennisPro_OrbitalTests.swift
//  TennisPro_OrbitalTests
//
//  Created by Yuexi Song on 24/5/24.
//

import XCTest
import UIKit
@testable import TennisPro_Orbital

class DetectionTests: XCTestCase {

    func testImageOrientation() {
        let detection = Detection()
        
        let portraitFront = detection.imageOrientation(deviceOrientation: .portrait, cameraPosition: .front)
        XCTAssertEqual(portraitFront, .leftMirrored)
        
        let landscapeLeftBack = detection.imageOrientation(deviceOrientation: .landscapeLeft, cameraPosition: .back)
        XCTAssertEqual(landscapeLeftBack, .up)
    }

       
}
