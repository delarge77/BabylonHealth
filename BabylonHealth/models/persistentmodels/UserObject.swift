//
//  User.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 08/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import RealmSwift

class UserObject: Object {
	
    @objc dynamic var email = ""
    @objc dynamic var userId = 0
    @objc dynamic var name = ""
    @objc dynamic var phone = ""
    @objc dynamic var username = ""
    @objc dynamic var website = ""
	
    convenience init(user: User) {
        self.init()
        email = user.email
        userId = user.id
        name = user.name
        phone = user.phone
        username = user.username
        website = user.website
    }
	
    var user: User {
        return User(email: email,
                    id: userId,
                    name: name,
                    phone: phone,
                    username: username,
                    website: website)
    }

    override class func primaryKey() -> String? {
        return "userId"
    }
}

