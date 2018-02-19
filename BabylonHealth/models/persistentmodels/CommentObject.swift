//
//  Comments.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 08/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import RealmSwift

class CommentObject: Object {
    
    @objc dynamic var postId = 0
    @objc dynamic var userId = 0
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var body = ""
	
    
    convenience init(comment: Comment) {
        self.init()
        postId = comment.postId
        userId = comment.id
        name = comment.name
        email = comment.email
        body = comment.body
    }
    
    var comment: Comment {
        return Comment(postId: postId,
                    id: userId,
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
}
