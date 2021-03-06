//
//  HomeTableViewController.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 05/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import UIKit

class PostsScreenTableViewController: UITableViewController {

    var postScreenDataSource = DataSource<Post, PostCell>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        splitViewController?.delegate = self
        splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.allVisible
        extendedLayoutIncludesOpaqueBars = true
        tableView.estimatedRowHeight = 120.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = postScreenDataSource
        
        let provider = Provider()
        provider.loadPosts { [weak self] (posts) in
            self?.postScreenDataSource.objects = posts ?? []
            self?.tableView.reloadData()
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailScreenViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = self.tableView.indexPath(for: cell) {
            destination.post = postScreenDataSource.objects[indexPath.row]
        }
    }
}

extension PostsScreenTableViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return tableView.indexPathForSelectedRow == nil
    }
}
