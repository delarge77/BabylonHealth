//
//  User.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 09/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation

struct User:Codable {
    
    let email: String
    let id: Int
    let name: String
    let phone: String
    let username: String
    let website: String
}
