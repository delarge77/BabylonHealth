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
    typealias PostsBlock = (APIResult<[Post]>) -> Void
    typealias DetailsBlock = (APIResult<CompoundDetail>) -> Void
    typealias UserDetailsBlock = (APIResult<User>) -> Void
    typealias CommentsBlock = (APIResult<[Comment]>) -> Void
}

extension BabylonHealthServiceAPI {
    func load(_ posts: URLRequestConvertible, completion: @escaping PostsBlock) {
		
		Alamofire.request(posts).responseData { json in
			switch json {
			case .success(let json):
				let posts = try! JSONDecoder().decode([Post].self, from: json)
				completion (.success(posts))
			case .error:
				completion (.error (.responseUnsuccessful))
			}
		}
    }
    
    func loadDetails(userConvertible: URLRequestConvertible,
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
            completion(.success((user, comments)))
        }
    }
    
    func load(user: URLRequestConvertible, completion: @escaping UserDetailsBlock) {
		
		Alamofire.request(user).responseData { json in
			switch json {
				case .success(let json):
					let user = try! JSONDecoder().decode([User].self, from: json)
					completion (.success(user[0]))
				case .error :
					completion( .error( .responseUnsuccessful))
			}
		}
    }
    
    func load(comments: URLRequestConvertible, completion: @escaping CommentsBlock) {
        Alamofire.request(comments).responseData { json in
            switch json {
                case .success(let json):
					let comments = try! JSONDecoder().decode([Comment].self, from: json)
                    completion( .success(comments))
                case .error :
                    completion( .error( .responseUnsuccessful))
            }
        }
    }
}

enum APIResult<T> {
    case success(T)
    case error(BabylonHealthApiError)
}

enum BabylonHealthApiError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
}
