//
//  Comments.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 08/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class CommentObject: Object, Mappable {
    
    dynamic var postId = 0
    dynamic var userId = 0
    dynamic var name = ""
    dynamic var email = ""
    dynamic var body = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    convenience init(comment: Comment) {
        self.init()
        postId = comment.postId
        userId = comment.userId
        name = comment.name
        email = comment.email
        body = comment.body
    }
    
    var comment: Comment {
        return Comment(postId: postId,
                    userId: userId,
                    name: name,
                    email: email,
                    body: body)
    }
    
    /*
        Would be better if each comment had a id. Otherwise
        each comment will be inserted everytime. Here we are 
        using name as a primary key, not ideal =(
     */
    
    override class func primaryKey() -> String? {
        return "name"
    }
    
    func mapping(map: Map) {
        postId <- map["postId"]
        userId <- map["id"]
        name <- map["name"]
        email <- map["email"]
        body <- map["body"]
    }
}
