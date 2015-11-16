//
//  TableViewController.swift
//  Mooltz
//
//  Created by Marko Jukic on 05/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var itemsTable: UITableView!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = TaskManager.sharedInstance.items[indexPath.row].name
        print("hello from tableview")
        print(TaskManager.sharedInstance.items)
        
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return TaskManager.sharedInstance.items.count

    }


}
