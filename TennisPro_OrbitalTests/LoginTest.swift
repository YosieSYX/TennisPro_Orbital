//
//  LoginTest.swift
//  TennisPro_OrbitalTests
//
//  Created by 杨清如 on 25/7/24.
//integration test
import Foundation
import XCTest
import SwiftUI
import FirebaseAuth
@testable import TennisPro_Orbital

class LoginTest: XCTestCase {
    
    var sut: loginPage!
    @State var currentShowingView: String = "login"
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = loginPage(currentShowingView: $currentShowingView)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testSuccessfulLogin() {
        let expectation = XCTestExpectation(description: "Successful login")
        
            //provide user information
        let testEmail = "Trail@outlook.com"
        let testPassword = "1234567890"
        
        
        sut.email = testEmail
        sut.password = testPassword
        
        // Simulate button tap
        Auth.auth().signIn(withEmail: testEmail, password: testPassword) { authResult, error in
           
            XCTAssertNil(error)
            XCTAssertNotNil(authResult)
            XCTAssertEqual(self.currentShowingView, "menu")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFailedLogin() {
        let expectation = XCTestExpectation(description: "Failed login")
        
       
        let testEmail = "nonexistent@example.com"
        let testPassword = "wrongPassword"
        
        
        sut.email = testEmail
        sut.password = testPassword
        
        // Simulate button tap
        Auth.auth().signIn(withEmail: testEmail, password: testPassword) { authResult, error in
           
            XCTAssertNotNil(error)
            XCTAssertNil(authResult)
            XCTAssertTrue(self.sut.showAlert)
            XCTAssertFalse(self.sut.errorMessage.isEmpty)
            XCTAssertEqual(self.currentShowingView, "login")
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
    // test if sign up button work
    func testNavigationToSignUp() {
        // Given
        XCTAssertEqual(currentShowingView, "login")
        
       
        sut.currentShowingView = "sign up"
        
       
        XCTAssertEqual(currentShowingView, "sign up")
    }
}
