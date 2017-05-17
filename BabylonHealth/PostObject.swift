//
//  Post.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 05/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class PostObject: Object, Mappable {
    
    dynamic var userId = 0
    dynamic var postId = 0
    dynamic var title = ""
    dynamic var body = ""

    required convenience init?(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "postId"
    }
    
    convenience init(post: Post) {
        self.init()
        userId = post.userId
        postId = post.postId
        title = post.title
        body = post.body
    }
    
    var post: Post {
        return Post(userId: userId,
                    postId: postId,
                    title: title,
                    body: body)
    }
    
    func mapping(map: Map) {
        userId <- map["userId"]
        postId <- map["id"]
        title <- map["title"]
        body <- map["body"]
    }
}
