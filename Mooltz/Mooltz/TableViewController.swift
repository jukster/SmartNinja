//
//  TableViewController.swift
//  Mooltz
//
//  Created by Marko Jukic on 05/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dates: [String] = [String]()
    
    var itemsByDate: [String: [Item]] = [String: [Item]]()
    
    lazy var dateFormatter: NSDateFormatter = {

        let formatter = NSDateFormatter()

        formatter.dateStyle = .MediumStyle
        
        return formatter
    
    }()

    func dateToString(date: NSDate) -> String {
        
        let simpleDateFormatter = NSDateFormatter()
        
        simpleDateFormatter.dateStyle = .ShortStyle
        
        let dateAsString = simpleDateFormatter.stringFromDate(date)
        
        return dateAsString
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return dates.count

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return itemsByDate[dates[section]]!.count

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var reuseIdentifier = ""
        
        let section = dates[indexPath.section]

        let item = itemsByDate[section]![indexPath.item]

        if item.active {

            reuseIdentifier = "TextCell"

        } else {

            reuseIdentifier = "TextCellInactive"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as UITableViewCell        
        
        cell.textLabel?.text = itemsByDate[dates[indexPath.section]]![indexPath.row].name
        
        // Add gesture recognizer - samo če še ni nobenega
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: "longPressed:")
        
        recognizer.minimumPressDuration = 0.5
        
        cell.addGestureRecognizer(recognizer)

        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let calendar = NSCalendar.currentCalendar()

        let todayAsString = dateFormatter.stringFromDate(NSDate())
        
        let yesterdayAsString = dateFormatter.stringFromDate(calendar.dateByAddingUnit(.Day, value: -1, toDate: NSDate(), options: [])!)
        
        if dates[section] == todayAsString {
            return "Today"
        }
        else if dates[section] == yesterdayAsString {
            return "Yesterday"
        }
        
        return dates[section]
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {

        let item = itemsByDate[dates[indexPath.section]]![indexPath.row]
        
        return item.active

    }


    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let item = itemsByDate[dates[indexPath.section]]![indexPath.row]
        
        let action = UITableViewRowAction(style: .Normal, title: "Finish", handler: { action, indexPath in

            item.active = false
            
            saveItems(self)
            
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        })
        action.backgroundColor = UIColor.blueColor()
        
        return [action];
    }
    
    override func viewWillAppear(animated: Bool) {
        loadTableViewData()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self

        tableView.dataSource = self
        
    }
    
    
    func longPressed(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .Began {
            
            let thisCell = recognizer.view as! UITableViewCell
            //print(thisCell.debugDescription)
            
            var tappedItem: Item?
            
            let indexPath = self.tableView.indexPathForCell(thisCell)
            
            tappedItem = itemsByDate[dates[indexPath!.section]]![indexPath!.item]
            
            print(tappedItem?.name)
            
            let tapAlert = UIAlertController(title: thisCell.textLabel?.text, message: "Delete this item?", preferredStyle:UIAlertControllerStyle.Alert)
        
            tapAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            
            tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive) { action in

                    let cellSection = self.dates[(indexPath?.section)!]

                    TaskManager.sharedInstance.deleteItems(tappedItem!)

                    self.loadTableViewData()

                    if let _ = self.itemsByDate[cellSection] {

                        self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)

                    } else {

                        self.tableView.deleteSections(NSIndexSet(index: indexPath!.section), withRowAnimation: UITableViewRowAnimation.Fade)
                    }
                
                }
            )
        
            self.presentViewController(tapAlert, animated: true, completion: nil)
        }
    }
    
    func loadTableViewData() {
        
        dates = [String]()
        
        itemsByDate = [String: [Item]]()

        
        let sortedItems = TaskManager.sharedInstance.items.sort { $0.dateCreated.compare($1.dateCreated) == .OrderedDescending }
        
        for item in sortedItems {
            
            let thisDateAsString = dateFormatter.stringFromDate(item.dateCreated)
            
            if !dates.contains(thisDateAsString) {
                dates.append(thisDateAsString)
                itemsByDate[thisDateAsString] = [Item]()
            }
            
            itemsByDate[thisDateAsString]!.append(item)
        }
        
        print(dates)
        print(itemsByDate)
    }

}
