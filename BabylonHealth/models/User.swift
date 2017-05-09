//
//  User.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 08/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class User: Object, Mappable {
    
    dynamic var email = ""
    dynamic var userId = 0
    dynamic var name = ""
    dynamic var phone = ""
    dynamic var username = ""
    dynamic var website = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "userId"
    }
    
    func mapping(map: Map) {
        email <- map["email"]
        userId <- map["id"]
        name <- map["name"]
        phone <- map["phone"]
        username <- map["username"]
        website <- map["website"]
    }
}
