//
//  ProviderTests.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 10/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import XCTest
import OHHTTPStubs
import UIKit
@testable import BabylonHealth

import XCTest

class ProviderTests: XCTestCase {
    
    let provider = Provider()
    
    func testConnection() {
        
        let expec = expectation(description: "")
        
        provider.loadPosts {  (posts) in
            XCTAssertNotNil(posts, "must not be nil")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    func testReturnsPostsWhenResponseStatusIs200() {
        
        let expec = expectation(description: "")
        
        stub(condition: isHost("jsonplaceholder.typicode.com")) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("posts.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
        }
        
        provider.loadPosts {  (posts) in
            XCTAssertNotNil(posts, "must be nil")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 15) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    func testReturnsSavedPostsWhenResponseStatusIsNot200() {
        let expec = expectation(description: "")
        
        stub(condition: isHost("jsonplaceholder.typicode.com")) { _ in
            return OHHTTPStubsResponse(jsonObject:[], statusCode:404, headers:nil)
        }
        
        provider.loadPosts {  (posts) in
            XCTAssertNotNil(posts, "must be nil")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    func testConnectionForRequestingDetails() {
        let expec = expectation(description: "")
        
        let post = Post(userId: 1, id: 1, title: "hsduhaduh", body: "sdjaisajdisajd")
        
        provider.loadDetailsFrom(post: post) { response in
            XCTAssertNotNil(response, "must not be nil")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    func testReturnsSavedDetailsWhenResponseStatusIsNot200() {
        let expec = expectation(description: "")
        
        stub(condition: isHost("jsonplaceholder.typicode.com")) { _ in
            return OHHTTPStubsResponse(jsonObject:[], statusCode:404, headers:nil)
        }
        
        let post = Post(userId: 1, id: 1, title: "hsduhaduh", body: "sdjaisajdisajd")
        
        provider.loadDetailsFrom(post: post) { response in
            XCTAssertNotNil(response, "must not be nil")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    func testShouldFailRequestingSavedDetailsWhenUserIdIsNotCorrect() {
        let expec = expectation(description: "")
        
        stub(condition: isHost("jsonplaceholder.typicode.com")) { _ in
            return OHHTTPStubsResponse(jsonObject:[], statusCode:404, headers:nil)
        }
        
        let post = Post(userId: 0, id: 1, title: "hsduhaduh", body: "sdjaisajdisajd")
        
        provider.loadDetailsFrom(post: post) { response in
            XCTAssertNil(response, "must be nil")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }

    func testShouldFailRequestingSavedDetailsWhenPostIdIsNotCorrect() {
        let expec = expectation(description: "")
        
        stub(condition: isHost("jsonplaceholder.typicode.com")) { _ in
            return OHHTTPStubsResponse(jsonObject:[], statusCode:404, headers:nil)
        }
		
		let post = Post(userId: 1, id: 0, title: "hsduhaduh", body: "sdjaisajdisajd")
		
        provider.loadDetailsFrom(post: post) { response in
            XCTAssertEqual(response?.comments.count, 0, "Value must be 0")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    override func tearDown() {
        super.tearDown()
        
        //remove all stubs on tear down
        OHHTTPStubs.removeAllStubs()
    }
}
