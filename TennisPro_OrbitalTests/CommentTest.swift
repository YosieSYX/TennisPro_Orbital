//
//  CommentTest.swift
//  TennisPro_OrbitalTests
//
//  Created by 杨清如 on 24/7/24.
// integration test
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

class CommentTest: XCTestCase {
    var viewModel:ForumComment!
    let testDocumentId = NSUUID().uuidString
    override func setUp() {
        super.setUp()
        viewModel = ForumComment(documentId: testDocumentId)
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
    
    func testUploadComment() async throws {
        let expectation = self.expectation(description: "Comment upload")
        let testComment = "This is a test comment"

        
        sign_in_test_user()

        viewModel.uploadComment(withComment: testComment, forDocumentId: testDocumentId)

        // Wait for the didUploadComment flag to be set before continue to execute next line
        if viewModel.didUploadComment == true{
            expectation.fulfill()
        }

        // Fetch comments to verify the upload, test fetch comment function as well
        try await viewModel.fetchComments(forDocumentId: testDocumentId)

        XCTAssertFalse(viewModel.comments.isEmpty, "Comments exist after upload")
        XCTAssertTrue(viewModel.comments.contains { $0.comment == testComment }, "Uploaded comment should be in the fetched comments")

        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 10.0)
    }
    
    
   
    
    
    
}
