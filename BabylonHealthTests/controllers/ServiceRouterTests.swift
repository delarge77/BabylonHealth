//
//  ServiceRouterTests.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 10/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import XCTest
import OHHTTPStubs
import UIKit
@testable import BabylonHealth

class ServiceRouterTests: XCTestCase {
    
    func testConnection() {
        
        let expec = expectation(description: "")
        
        Provider.shared.loadPosts { posts in
            XCTAssertNotNil(posts, "must not be nil")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    
}
