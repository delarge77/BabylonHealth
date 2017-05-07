//
//  PostsController.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 05/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import Alamofire

struct BabylonHealthServiceAPI {
    typealias postsCompletion = (APIResult<[Post]?>) -> Void
}

extension BabylonHealthServiceAPI {
    
    static func load(posts: URLRequestConvertible, completion: @escaping postsCompletion) {
        Alamofire.request(posts).responseJSON(completionHandler: { response in
            
            guard let httpResponse = response.response else {
                completion( .error(. requestFailed))
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = response.data {
                    guard let object = try? JSONSerialization.jsonObject(with:data),
                        let json = object as? NSArray else {
                            completion( .error( .jsonConversionFailure))
                            return
                    }
                    let posts = Post.from(json)
                    completion( .success(posts))
                    
                } else {
                    completion( .error( .invalidData))
                }
            } else {
                completion( .error( .responseUnsuccessful))
                print("\(httpResponse.statusCode)")
            }
        })
    }
    
    static func load(user: URLRequestConvertible, completion: @escaping postsCompletion) {
        Alamofire.request(user).responseJSON(completionHandler: { response in
            
            print("\(response)")
            
        })
    }
    
    static func load(comments: URLRequestConvertible, completion: @escaping postsCompletion) {
        Alamofire.request(comments).responseJSON(completionHandler: { response in
        
            print("\(response)")
            
        })
    }
}

enum APIResult <T> {
    case success(T)
    case error(BabylonHealthApiError)
}

enum BabylonHealthApiError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
}
