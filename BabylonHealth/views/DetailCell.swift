//
//  DetailCell.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 08/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell, CellTextPresentable {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
}

extension DetailCell: Reusable {
    
    func setUp(_ comment: Comment) {
        nameLabel.text = comment.name
        nameLabel.textColor = commentsColor
        commentLabel.text = comment.body
        commentLabel.font = commentsFont
    }
}
