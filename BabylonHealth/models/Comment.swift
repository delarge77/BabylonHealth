//
//  Comment.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 09/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation

struct Comment:Codable {
    
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
