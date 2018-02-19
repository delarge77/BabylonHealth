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
    var detailScreenDataSource = DataSource<Comment, DetailCell>()
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTableView.estimatedRowHeight = 120.0
        commentsTableView.rowHeight = UITableViewAutomaticDimension
        commentsTableView.dataSource = detailScreenDataSource

        guard let post = post else {
            return
        }
        
        DetailViewModel.loadDetails(post: post) { [weak self] detailModel in
            guard let detailViewModel = detailModel else {
                return
            }
            
            self?.detailScreenDataSource.objects = detailViewModel.comments
            self?.authorNameLabel.text = detailViewModel.name
            self?.commentsCountLabel.text = detailViewModel.numberCommentsText
            self?.postBodyLabel.text = detailViewModel.postDescription
            self?.commentsTableView.reloadData()
        }
    }
}
