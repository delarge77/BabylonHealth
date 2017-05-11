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
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let post = post else {
            return
        }
        
        DetailViewModel.loadDetails(post: post) { [weak self] detailModel in
            guard let detailViewModel = detailModel else {
                self?.showErrorMessage()
                return
            }
            
            self?.detailScreenDataSource.comments = detailViewModel.comments
            self?.commentsTableView.dataSource = self?.detailScreenDataSource
            self?.authorNameLabel.text = detailViewModel.name
            self?.commentsCountLabel.text = detailViewModel.numberCommentsText
            self?.postBodyLabel.text = detailViewModel.postDescription
            self?.commentsTableView.reloadData()
            self?.commentsTableView.estimatedRowHeight = 120.0
            self?.commentsTableView.rowHeight = UITableViewAutomaticDimension

        }
    }
    
    func showErrorMessage() {
        view.bringSubview(toFront: errorLabel)
        errorLabel.isHidden = false
        commentsTableView.isHidden = true
        errorLabel.text = NSLocalizedString("DetailScreenViewController.Error", comment: "")
    }
}
