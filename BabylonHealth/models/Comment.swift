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

class Comment: Object, Mappable {
    
    dynamic var postId = 0
    dynamic var userId = 0
    dynamic var name = ""
    dynamic var email = ""
    dynamic var body = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "postId"
    }
    
    func mapping(map: Map) {
        postId <- map["postId"]
        userId <- map["id"]
        name <- map["name"]
        email <- map["email"]
        body <- map["body"]
    }
}
