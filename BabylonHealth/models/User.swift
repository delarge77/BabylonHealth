//
//  User.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 08/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import Mapper

struct User: Mappable {
    
    let email: String
    let userId: Int
    let name: String
    let phone: String
    let username: String
    let website: String
    
    init(map: Mapper) throws {
        try email = map.from("email")
        try userId = map.from("id")
        try name = map.from("name")
        try phone = map.from("phone")
        try username = map.from("username")
        try website = map.from("website")
    }
}

extension User: Persistable {
    public init(managedObject: UserPersistence) {
        email = managedObject.email
        userId = managedObject.userId
        name = managedObject.name
        phone = managedObject.phone
        username = managedObject.username
        website = managedObject.website
    }
    public func managedObject() -> UserPersistence {
        let user = UserPersistence()
        user.email = email
        user.userId = userId
        user.name = name
        user.phone = phone
        user.username = username
        user.website = website
        return user
    }
}
