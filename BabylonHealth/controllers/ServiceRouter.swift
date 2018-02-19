//
//  RouterCases.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 06/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import Alamofire

enum ServiceRouter: URLRequestConvertible {

    case loadPosts
    case searchUser(userId: Int)
    case comments(postId: Int)
    
    var path: String {
        
        switch self {
            
        case .loadPosts:
            return APIEndpoints.posts
            
        case .searchUser:
            return APIEndpoints.users
            
        case .comments:
            return APIEndpoints.comments
        }
    }
    
    var parameters: [String: Any] {
        
        var params: [String: Any] = [:]
        
        switch self {
            
        case let .searchUser(userId):
            params["id"] = userId
            
        case let .comments(postId):
            params["postId"] = postId
            
        default:
            break
        }
        
        return params
    }
    
    var method: HTTPMethod {
        switch self {
        case  .loadPosts, .searchUser, .comments:
            return .get
        }
    }

    func asURLRequest() throws -> URLRequest {
        
        let url = try APIEndpoints.baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 5.0
        return try URLEncoding.methodDependent.encode(urlRequest, with: parameters)
    }
}

struct APIEndpoints {
    static let baseUrl = "http://jsonplaceholder.typicode.com/"
    static let users = "users"
    static let comments = "comments"
    static let posts = "posts"
}
