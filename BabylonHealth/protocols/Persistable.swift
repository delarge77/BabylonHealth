//
//  Persistable.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 08/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import RealmSwift

protocol Persistable {
    
    func getAll() -> Results<Post>?
    func getCommentsByPostId(postId: Int) -> Results<Comment>?
    func insert<T: Object>(item: T, update: Bool)
    func getUserById<T>(userId: Int) -> T? where T : Object
}

extension Persistable {
    
    var realm: Realm? {
        return try? Realm()
    }
    
    func insert<T>(item: T, update: Bool) where T : Object {
        try? realm?.write {
            realm?.add(item.self, update:update)
        }
    }
    
    func getUserById<T>(userId: Int) -> T? where T : Object {
        return realm?.object(ofType: User.self, forPrimaryKey: userId) as? T
    }
    
    func getAll() -> Results<Post>? {
        return realm?.objects(Post.self)
    }
    
    func getCommentsByPostId(postId: Int) -> Results<Comment>? {
        return realm?.objects(Comment.self).filter("postId == %@", postId)
    }
}
