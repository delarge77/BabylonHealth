//
//  Post.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 05/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import Mapper

struct Post: Mappable {
    
    let userId: Int
    let postId: Int
    let title: String
    let body: String
    
    init(map: Mapper) throws {
        try userId = map.from("userId")
        try postId = map.from("id")
        try title = map.from("title")
        try body = map.from("body")
    }
}
