//
//  ForumTest.swift
//  TennisPro_OrbitalTests
//
//  Created by 杨清如 on 23/7/24.
//integration test
import AVKit

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase
import Foundation
import XCTest
import PhotosUI
import FirebaseAuth
import UniformTypeIdentifiers
@testable import TennisPro_Orbital

class ForumTest: XCTestCase {
    var viewModel:ViewModelForum!
    override func setUp() {
        super.setUp()
        viewModel = ViewModelForum()
        if FirebaseApp.app() == nil{
            FirebaseApp.configure()
        }
        
    }
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    func sign_in_test_user() {
        let expectation = self.expectation(description: "sign in test user")
        Auth.auth().signIn(withEmail:"Trail@outlook.com", password: "1234567890") {_, error in
            XCTAssertNil(error,"Failed to sign in test user:\(error?.localizedDescription)")
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 10)
    }
    
    
    func test_upload_forum_video() async throws{
        let expectation = self.expectation(description: "video upload forum part")
        let mockData = MockPhotosPickerItem()
        let testId = NSUUID().uuidString
        viewModel.selectedPost = mockData
        viewModel.testId = testId
        
                let cancellable = viewModel.$videos.sink { videos in
                    if !videos.isEmpty {
                        expectation.fulfill()
                    }
                }
        try await viewModel.uploadVideo()
        
        await fulfillment(of: [expectation], timeout: 30.0)
              
              cancellable.cancel()
            // look for the video the test user update
        let querySnapshot = try await Firestore.firestore().collection("forum").whereField("userId", isEqualTo: Auth.auth().currentUser!.uid).whereField("testId", isEqualTo: testId).getDocuments()
            // see if it exist
        XCTAssertFalse(querySnapshot.documents.isEmpty, "No document found for the uploaded video")
            // see if videoUrl and userId of the latest uploaded video exist
        if let document = querySnapshot.documents.last {
            
            XCTAssertNotNil(document.get("videoUrl"), "Video URL should exist in Firestore")
            XCTAssertNotNil(document.get("userId"), "User ID should exist in Firestore")
        }
}
    
   
    
    
    class MockPhotosPickerItem: PhotoPickerProtocol {
        var itemIdentifier: String? {
            return "mock-identifier"
        }

        func loadTransferable(type: Data.Type) async throws -> Data? {
            return Data(repeating: 0, count: 1024)
        }
    }
}
