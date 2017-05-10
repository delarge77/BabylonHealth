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
        
        Provider.shared.loadDetailsFrom(post: post) { [weak self] compoundResult in
            self?.detailScreenDataSource.comments = compoundResult.comments 
            self?.commentsTableView.dataSource = self?.detailScreenDataSource
            self?.commentsCountLabel.text = "\(compoundResult.comments.count)"
            self?.postBodyLabel.text = post.body
            self?.commentsTableView.reloadData()
            self?.commentsTableView.estimatedRowHeight = 120.0
            self?.commentsTableView.rowHeight = UITableViewAutomaticDimension
        }
    }
}
