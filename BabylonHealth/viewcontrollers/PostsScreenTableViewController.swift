//
//  HomeTableViewController.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 05/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import UIKit

class PostsScreenTableViewController: UITableViewController {

    var postScreenDataSource = PostScreenDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
        splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.allVisible
        extendedLayoutIncludesOpaqueBars = true
        
        BabylonHealthServiceAPI.loadPosts(ServiceRouter.loadPosts) { [weak self] (result) in
            switch result {
            case .success(let postsResult):
                self?.postScreenDataSource.posts = postsResult ?? []
                self?.tableView.dataSource = self?.postScreenDataSource
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
        if let destination = segue.destination as? DetailScreenViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = self.tableView.indexPath(for: cell) {
            destination.post = postScreenDataSource.posts[indexPath.row]
        }
    }
}

extension PostsScreenTableViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return tableView.indexPathForSelectedRow == nil
    }
}