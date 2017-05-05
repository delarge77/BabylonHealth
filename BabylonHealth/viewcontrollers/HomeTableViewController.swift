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
    var homeDataSource = HomeDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()

        PostsController.shared.loadPostsWith("posts") {[weak self] (result) in
            switch result {
            case .success(let postsResult):
                    self?.homeDataSource.posts = postsResult ?? []
                    self?.tableView.dataSource = self?.homeDataSource
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
//        if let destination = segue.destination as? WeatherDetailTableViewController,
//            let cell = sender as? UITableViewCell,
//            let indexPath = self.tableView.indexPath(for: cell) {
//            destination.city = cities[indexPath.row]
//        } else if segue.identifier == "addcity" {
//            let destination = (segue.destination.contents as? AddCityTableViewController)
//            destination?.delegate = self
//        }
    }
}
