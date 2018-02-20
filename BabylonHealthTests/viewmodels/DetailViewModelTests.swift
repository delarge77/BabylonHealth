//
//  DetailViewModelTests.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 12/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import XCTest
@testable import BabylonHealth

class DetailViewModelTests: XCTestCase {
    
    func testShouldCreateDetailModel() {
        
        let expec = expectation(description: "")
		
        let post = Post(userId: 1,
                     id: 1,
                     title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                     body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        
        DetailViewModel.loadDetails(post: post) { detail in
            XCTAssertNotNil(detail, "detail can not be nil")
            print(detail!)
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    func testShouldFormatDetailInformation() {
		
		let user = User(email: "", id: 1, name: "", phone: "", username: "", website: "")
		let comment = Comment(postId: 1, id: 1, name: "", email: "", body: "")
        let detail = CompoundDetail(user, [comment])
        let formatUserName = DetailViewModel.formatUserName(detail)
        XCTAssertNotNil(formatUserName, "detail can not be nil")
        let numberOfComments = DetailViewModel.numberOfComments(detail)
        XCTAssertNotNil(numberOfComments, "detail can not be nil")
    }
    
}
