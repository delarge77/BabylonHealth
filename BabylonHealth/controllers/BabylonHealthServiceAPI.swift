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
    typealias detailsCompletion = (APIResult<CompoundResponse?>) -> Void
}

extension BabylonHealthServiceAPI {
    
    static func loadPosts(_ posts: URLRequestConvertible, completion: @escaping postsCompletion) {
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
    
    static func loadDetails(user: URLRequestConvertible, comments: URLRequestConvertible, completion: @escaping detailsCompletion) {
        
        let group = DispatchGroup()
        group.enter()
        Alamofire.request(user).responseJSON(completionHandler: { response in
            
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
                    let user = User.from(json)
                    print("\(String(describing: user))")
//                    completion( .success(user))
                    
                } else {
                    completion( .error( .invalidData))
                }
            } else {
                completion( .error( .responseUnsuccessful))
                print("\(httpResponse.statusCode)")
            }
            group.leave()
        })
        
        group.enter()
        Alamofire.request(comments).responseJSON(completionHandler: { response in
            
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
                    let comments = Comment.from(json)
                    print("\(String(describing: comments))")
                    //                    completion( .success(user))
                    
                } else {
                    completion( .error( .invalidData))
                }
            } else {
                completion( .error( .responseUnsuccessful))
                print("\(httpResponse.statusCode)")
            }

            group.leave()
        })
        
        group.notify(queue: .main) {
            print("both requests done)")
        }
    }
}

enum APIResult <T> {
    case success(T)
    case error(BabylonHealthApiError)
}

struct CompoundResponse {
    let user: User
    let comments: [Comment]
}

enum BabylonHealthApiError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
}
