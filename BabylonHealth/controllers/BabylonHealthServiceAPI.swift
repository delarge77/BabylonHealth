//
//  PostsController.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 05/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import RealmSwift

struct BabylonHealthServiceAPI {
    typealias PostsBlock = (APIResult<[Post]>) -> Void
    typealias DetailsBlock = (APIResult<CompoundResponse>) -> Void
    typealias UserDetailsBlock = (APIResult<User>) -> Void
    typealias CommentsBlock = (APIResult<[Comment]>) -> Void
}

extension BabylonHealthServiceAPI {
    
    static func loadPosts(_ posts: URLRequestConvertible, completion: @escaping PostsBlock) {
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
                    guard let postsObject = Mapper<PostObject>().mapArray(JSONObject: json) else {
                        return
                    }
                    let posts = postsObject.map {$0.post}
                    completion( .success(posts))
                } else {
                    completion( .error( .invalidData))
                }
            } else {
                completion( .error( .responseUnsuccessful))
            }
        })
    }
    
    static func loadDetails(userConvertible: URLRequestConvertible,
                            commentsConvertible: URLRequestConvertible,
                            completion: @escaping DetailsBlock) {
        
        var user: User? = nil
        var comments: [Comment]? = nil
        let group = DispatchGroup()
        
        group.enter()
        load(user: userConvertible) { result in
            switch result {
            case .success(let userResponse):
                user = userResponse
            case .error(let error):
                print("\(error)")
            }
            group.leave()
        }
        
        group.enter()
        load(comments: commentsConvertible) { result in
            switch result {
                case .success(let commentsResponse):
                    comments = commentsResponse
                case .error(let error):
                    print("\(error)")
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            
            guard let user = user else {
                completion( .error( .responseUnsuccessful))
                return
            }
            guard let comments = comments else {
                completion( .error( .responseUnsuccessful))
                return
            }
            
            let result = CompoundResponse(user: user, comments: comments)
            completion(.success(result))
        }
    }
    
    static func load(user: URLRequestConvertible, completion: @escaping UserDetailsBlock) {
        
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
                    
                    guard let userObject = Mapper<UserObject>().map(JSONObject: json.firstObject) else {
                        return
                    }
                    completion( .success(userObject.user))

                } else {
                    completion( .error( .invalidData))
                }
            } else {
                completion( .error( .responseUnsuccessful))
            }
        })
    }
    
    static func load(comments: URLRequestConvertible, completion: @escaping CommentsBlock) {
        
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
                    guard let commentObjects = Mapper<CommentObject>().mapArray(JSONObject: json) else {
                        return
                    }
                    let comments = commentObjects.map {$0.comment}
                    completion( .success(comments))
                } else {
                    completion( .error( .invalidData))
                }
            } else {
                completion( .error( .responseUnsuccessful))
            }
        })
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
