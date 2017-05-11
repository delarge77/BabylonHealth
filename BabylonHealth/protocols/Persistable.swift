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
//    func addObjects<T>(items: T, update:Bool) where T : Object
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
    
//    func addObjects<T>(items: T, update:Bool) where T : Object {
//        return realm?.objects(item)
//        realm?.add(items, update: update)
//    }
}
