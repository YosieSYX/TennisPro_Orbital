//
//  ProfileTest.swift
//  TennisPro_OrbitalTests
//
//  Created by 杨清如 on 24/7/24.
//integration test

import Foundation

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



class ProfileTest: XCTestCase {
    var viewModel: EditProfileViewModel!
   
    override func setUp() {
        super.setUp()
        viewModel = EditProfileViewModel()
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        sign_in_test_user()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func sign_in_test_user() {
        let expectation = self.expectation(description: "sign in test user")
        Auth.auth().signIn(withEmail:"Trail@outlook.com", password: "1234567890") { _, error in
            XCTAssertNil(error, "Failed to sign in test user: \(error?.localizedDescription ?? "")")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testEditProfile() async throws {
        
        guard let testImage = UIImage(named: "tennis") else {
            XCTFail("Test image not found")
            return
        }
        let testUserName = NSUUID().uuidString
        let testIntroduction = "This is a test introduction"
        
        let expectation = self.expectation(description: "edit profile")
        
      
        viewModel.uploadProfile(testImage, user_name: testUserName, introduction: testIntroduction)
        
       
        await fulfillment(of: [expectation], timeout: 30.0)
        
        // Verify the data was uploaded correctly
        let userId = Auth.auth().currentUser?.uid
        guard let userId = userId else {
            XCTFail("User ID not found")
            return
        }
        
        do {
            let document = try await Firestore.firestore().collection("users_Profile").document(userId).getDocument()
            
            XCTAssertTrue(document.exists, "Document should exist in Firestore")
            
            let data = document.data()
            XCTAssertEqual(data?["user_name"] as? String, testUserName, "Username should match")
            XCTAssertEqual(data?["introduction"] as? String, testIntroduction, "Introduction should match")
            XCTAssertNotNil(data?["imageUrl"], "Image URL should exist")
            
            // You might want to add more specific checks for the image URL here
            
            expectation.fulfill()
        } catch {
            XCTFail("Failed to fetch document: \(error)")
        }
    }
}
