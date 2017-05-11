//
//  DetailViewModel.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 11/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation

struct DetailViewModel {
    
    static func loadDetails(post: Post, completion:@escaping (Detail?) -> Void) {
        Provider.shared.loadDetailsFrom(post: post) { result in
            
            guard let detail = result else {
                completion(nil)
                return
            }
            
            let name = formatUserName(detail)
            let numberOfCommentsText = numberOfComments(detail)
            
            let detailModel = Detail(name: name, comments: detail.comments, postDescription: post.body, numberCommentsText: numberOfCommentsText)
            completion(detailModel)
            
        }
    }
    
    static func formatUserName(_ detail: CompoundResponse) -> String {
        return detail.user.name
    }
    
    static func numberOfComments(_ detail: CompoundResponse) -> String {
        return NSLocalizedString("DetailScreenViewController.Comments", comment: "").appending(" \(detail.comments.count)")
    }
}

struct Detail {
    let name: String
    let comments: [Comment]
    let postDescription: String
    let numberCommentsText: String
}
