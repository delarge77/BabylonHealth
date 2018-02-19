//
//  HomeDataSource.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 05/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import UIKit

class DataSource<T, C: UITableViewCell>: NSObject, UITableViewDataSource where C: Reusable, C.T == T {
    
    var objects = [T]()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as C
        let object = objects[indexPath.row]
        cell.setUp(object)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
