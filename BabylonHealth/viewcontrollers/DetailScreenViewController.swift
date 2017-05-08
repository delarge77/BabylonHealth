//
//  DetailScreenViewController.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 06/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import UIKit

class DetailScreenViewController: UIViewController {

    var post: Post?
    var detailScreenDataSource = DetailScreenDataSource()
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let post = post else {
            return
        }
        
        BabylonHealthServiceAPI.loadDetails(user: ServiceRouter.searchUser(userId: post.userId),
                                        comments: ServiceRouter.comments(postId: post.postId)) { (result ) in
            
         print(result)
                                                
//            switch result {
//            case .success(let comments):
//                self?.detailScreenDataSource.comments = comments ?? []
//                self?.commentsTableView.dataSource = self?.detailScreenDataSource
//                self?.commentsTableView.reloadData()
//                self?.commentsTableView.estimatedRowHeight = 120.0
//                self?.commentsTableView.rowHeight = UITableViewAutomaticDimension
//            case .error(let error):
//                print("\(error)")
//            }
        }
    }
}
