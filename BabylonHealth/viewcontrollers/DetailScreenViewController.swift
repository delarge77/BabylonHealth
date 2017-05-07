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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let p = post else {
            return
        }
        
        BabylonHealthServiceAPI.load(user: ServiceRouter.searchUser(userId: p.userId)) { (result) in
            print(result)
        }
        
        BabylonHealthServiceAPI.load(comments: ServiceRouter.comments(postId: p.postId)) { (result) in
            print(result)
        }
    }
}
