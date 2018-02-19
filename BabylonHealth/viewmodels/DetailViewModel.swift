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
        let provider = Provider()
        provider.loadDetailsFrom(post: post) { result in

            guard let result = result else {
                completion(nil)
                return
            }
			
            let name = formatUserName(result)
            let numberOfCommentsText = numberOfComments(result)
			
            let detailModel = Detail(name: name, comments: result.comments, postDescription: post.body, numberCommentsText: numberOfCommentsText)
            completion(detailModel)
        }
    }
    
    static func formatUserName(_ detail: CompoundDetail) -> String {
        return detail.user.name
    }
    
    static func numberOfComments(_ detail: CompoundDetail) -> String {
        return NSLocalizedString("DetailScreenViewController.Comments", comment: "").appending(" \(detail.comments.count)")
    }
}

struct Detail {
    let name: String
    let comments: [Comment]
    let postDescription: String
    let numberCommentsText: String
}
