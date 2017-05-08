//
//  DetailScreenDataSource.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 08/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import UIKit

class DetailScreenDataSource: NSObject, UITableViewDataSource {
    
    var comments = [Comment]()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DetailCell
        let comment = comments[indexPath.row]
        cell.setUp(comment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
