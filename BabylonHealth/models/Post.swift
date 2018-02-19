//
//  Post.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 09/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation

struct Post:Codable {
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
