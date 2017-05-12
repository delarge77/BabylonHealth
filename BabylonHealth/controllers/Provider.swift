//
//  Provider.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 09/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import RealmSwift

struct Provider: Persistable {
    static let shared = Provider()
}

extension Provider {
    
    func loadPosts(completion:@escaping ([Post]?) -> Void) {
        BabylonHealthServiceAPI.loadPosts(ServiceRouter.loadPosts) {  result in
            switch result {
                case .success(let posts):
                    self.insertPosts(posts: posts, update: true)
                    completion(posts)
                case .error:
                    let posts = self.getAll()
                    completion(posts)
            }
        }
    }
    
    func loadDetailsFrom(post: Post, completion:@escaping (CompoundResponse?) -> Void) {
        BabylonHealthServiceAPI.loadDetails(userConvertible: ServiceRouter.searchUser(userId: post.userId), commentsConvertible: ServiceRouter.comments(postId: post.postId)) { (result ) in
            
            switch result {
                case .success(let response):
                    let user = response.user
                    let userObject = UserObject(user: user)
                    self.insert(item: userObject, update: true)
                    self.insertComments(comments: response.comments, update: true)
                    completion(response)
                case .error:
                    guard let user = self.getUserById(userId: post.userId) else {
                        completion(nil)
                        return
                    }
                    guard let comments = self.getCommentsByPostId(postId: post.postId) else {
                        completion(nil)
                        return
                    }
                    let compound = CompoundResponse(user: user, comments: comments)
                    completion(compound)
            }
        }
    }
}
