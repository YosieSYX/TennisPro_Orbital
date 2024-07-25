//
//  SignUpTest.swift
//  TennisPro_OrbitalTests
//
//  Created by 杨清如 on 25/7/24.
//integration test
import Foundation
import XCTest
import SwiftUI
import FirebaseAuth
@testable import TennisPro_Orbital 

class SignUpIntegrationTests: XCTestCase {
    
    var sut: signUp!
    @State var currentShowingView: String = "signup"
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = signUp(currentShowingView: $currentShowingView)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testSuccessfulSignUp() {
        let expectation = XCTestExpectation(description: "Successful sign up")
        
        // Given
        let testEmail = "newuser@example.com"
        let testPassword = "ValidPass123!"
        let testName = "New User"
        
        // When
        sut.email = testEmail
        sut.password = testPassword
        sut.name = testName
        
        // Simulate button tap
        Auth.auth().createUser(withEmail: testEmail, password: testPassword) { authResult, error in
            // Then
            XCTAssertNil(error)
            XCTAssertNotNil(authResult)
            XCTAssertEqual(self.currentShowingView, "login")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFailedSignUp() {
        let expectation = XCTestExpectation(description: "Failed sign up")
        
        // Given
        let testEmail = "invalid_email"
        let testPassword = "weak"
        
        // When
        sut.email = testEmail
        sut.password = testPassword
        
        // Simulate button tap
        Auth.auth().createUser(withEmail: testEmail, password: testPassword) { authResult, error in
            // Then
            XCTAssertNotNil(error)
            XCTAssertNil(authResult)
            XCTAssertTrue(self.sut.showAlert)
            XCTAssertFalse(self.sut.errorMessage.isEmpty)
            XCTAssertEqual(self.currentShowingView, "signup")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testEmailValidation() {
        // Test valid email
        sut.email = "valid@example.com"
        XCTAssertTrue(sut.email.isValidEmail())
        
        // Test invalid email
        sut.email = "invalid_email"
        XCTAssertFalse(sut.email.isValidEmail())
    }
    
    func testPasswordValidation() {
        // Test valid password
        sut.password = "ValidPass123!"
        XCTAssertTrue(sut.password.isValidPassword(_password: sut.password))
        
        // Test invalid password
        sut.password = "weak"
        XCTAssertFalse(sut.password.isValidPassword(_password: sut.password))
    }
    
    func testNavigationToLogin() {
        // Given
        XCTAssertEqual(currentShowingView, "signup")
        
        // When
        sut.currentShowingView = "login"
        
        // Then
        XCTAssertEqual(currentShowingView, "login")
    }
}
