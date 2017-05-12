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
    
    associatedtype T
    associatedtype C
    associatedtype U
    
    func getAll() -> [T]?
    func getCommentsByPostId(postId: Int) -> [C]?
    func insert<T: Object>(item: T, update: Bool)
    func getUserById(userId: Int) -> U?
    func insertPosts(posts: [Post], update: Bool)
    func insertComments(comments: [C], update: Bool)
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
    
    func getUserById(userId: Int) -> User? {
        return (realm?.object(ofType: UserObject.self, forPrimaryKey: userId).map {$0.user})
    }
    
    func getAll() -> [Post]? {
        return realm?.objects(PostObject.self).map {$0.post}
    }
    
    func getCommentsByPostId(postId: Int) -> [Comment]? {
        return realm?.objects(CommentObject.self).filter("postId == %@", postId).map {$0.comment}
    }
    
    func insertPosts(posts: [Post], update: Bool) {
        let posts = posts.map({ PostObject(post: $0) })
        try? realm?.write {
            realm?.add(posts, update:update)
        }
    }
    
    func insertComments(comments: [Comment], update: Bool) {
        let comments = comments.map({ CommentObject(comment: $0) })
        try? realm?.write {
            realm?.add(comments, update:update)
        }
    }
}
