//
//  HomeTableViewController.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 05/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import UIKit
import Mapper

class HomeTableViewController: UITableViewController {

    var posts = [Post]()
    var postDataSource = HomeDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()

        PostsController.shared.loadPostsWith("posts") {[weak self] (result) in
            switch result {
            case .success(let postsResult):
                    self?.postDataSource.posts = postsResult ?? []
                    self?.tableView.dataSource = self?.postDataSource
                    self?.tableView.reloadData()
                    self?.tableView.estimatedRowHeight = 120.0
                    self?.tableView.rowHeight = UITableViewAutomaticDimension
            case .error(let error):
                    print("\(error)")
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
