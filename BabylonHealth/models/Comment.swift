//
//  Comments.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 08/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import Mapper

struct Comment: Mappable {
    
    let postId: Int
    let userId: Int
    let name: String
    let email: String
    let body: String
    
    init(map: Mapper) throws {
        try postId = map.from("postId")
        try userId = map.from("id")
        try name = map.from("name")
        try email = map.from("email")
        try body = map.from("body")
    }
}

extension Comment: Persistable {
    public init(managedObject: CommentPersistence) {
        postId = managedObject.postId
        userId = managedObject.userId
        name = managedObject.name
        email = managedObject.email
        body = managedObject.body
    }
    public func managedObject() -> CommentPersistence {
        let comment = CommentPersistence()
        comment.postId = postId
        comment.userId = userId
        comment.name = name
        comment.email = email
        comment.body = body
        return comment
    }
}
