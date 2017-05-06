//
//  PostsController.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 05/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import Alamofire

struct PostsController {
    static let shared = PostsController()
    static let baseUrl = URL(string: "http://jsonplaceholder.typicode.com/")!
    typealias postsCompletion = (APIResult<[Post]?>) -> Void
}

extension PostsController {
    
    func load(_ posts: String, completion:@escaping postsCompletion) {
        
        let postsURL = PostsController.baseUrl.appendingPathComponent(posts)
        
        Alamofire.request(postsURL, method: .get, parameters: nil, encoding: URLEncoding.default)
            .responseJSON { response in
                
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
        }
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
