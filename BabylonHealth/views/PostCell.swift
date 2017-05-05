//
//  PostCell.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 05/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell, TextPresentable {
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    func setUp(_ post: Post) {
        postTitleLabel.text = post.title
        postTitleLabel.textColor = textColor
        postBodyLabel.text = post.body
        postBodyLabel.font = textFont
    }
    
}
