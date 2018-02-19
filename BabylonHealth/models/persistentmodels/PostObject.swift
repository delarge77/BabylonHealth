//
//  Post.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 05/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import RealmSwift

class PostObject: Object {
	
    @objc dynamic var userId = 0
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var body = ""

	
    override class func primaryKey() -> String? {
        return "id"
    }
	
    convenience init(post: Post) {
        self.init()
        userId = post.userId
        id = post.id
        title = post.title
        body = post.body
    }
	
    var post: Post {
        return Post(userId: userId,
                    id: id,
                    title: title,
                    body: body)
    }
}

