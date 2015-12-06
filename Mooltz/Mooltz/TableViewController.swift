//
//  TableViewController.swift
//  Mooltz
//
//  Created by Marko Jukic on 05/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit
import MagicalRecord

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dates: [String] = [String]()
    
    var itemsByDate: [String: [CDItem]] = [String: [CDItem]]()
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "itemDetail" {
            
            if let itemDetailVC = segue.destinationViewController as? ItemDetailViewController {
                
                let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
                
                itemDetailVC.selectedItem = itemsByDate[dates[indexPath.section]]![indexPath.row]
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return itemsByDate[dates[section]]!.count

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var reuseIdentifier = ""
        
        let section = dates[indexPath.section]

        let item = itemsByDate[section]![indexPath.item]

        if item.active == 1 {

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
        
        if let cellImage = item.hasImage {

            print("trying image cell")
            print(cellImage)
            cell.imageView?.image = cellImage.imageRef
            
        }

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
        
        if item.active == 0 { return false } else {return true}
        
    }


    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let item = itemsByDate[dates[indexPath.section]]![indexPath.row]
        
        let action = UITableViewRowAction(style: .Normal, title: "Finish", handler: { action, indexPath in

            item.active = false
            
            //saveItems(self)
            
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        })
        action.backgroundColor = UIColor.blueColor()
        
        return [action];
    }
    
    override func viewWillAppear(animated: Bool) {

        refreshTable()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self

        tableView.dataSource = self
        
        refreshTable()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshTable", name: "didSaveImage", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshTable", name: "NewItem", object: nil)

        //let images = CDImage.MR_findAll()
        
        //print("ob launchu je slik \(images.count)")
        
        let items = CDItem.MR_findAll() as! [CDItem]
        
        for item in items {
            print(item.hasImage)

            print(item.hasImage?.imageRef)

            print(item.hasImage?.imageFileName)
        }

    }
    
    
    func longPressed(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .Began {
            
            let thisCell = recognizer.view as! UITableViewCell
            //print(thisCell.debugDescription)
            
            var tappedItem: CDItem?
            
            let indexPath = self.tableView.indexPathForCell(thisCell)
            
            tappedItem = itemsByDate[dates[indexPath!.section]]![indexPath!.item]
            
            print(tappedItem?.name)
            
            let tapAlert = UIAlertController(title: thisCell.textLabel?.text, message: "Delete this item?", preferredStyle:UIAlertControllerStyle.ActionSheet)
        
            tapAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            
            tapAlert.addAction(UIAlertAction(title: "Delete", style: .Destructive) { action in

                
                    MagicalRecord.saveWithBlock({ context in
                        
                        tappedItem!.MR_deleteEntityInContext(context)
                        
                        }, completion: { (success, error) -> Void in
                        
                            ItemManager.sharedInstance.refreshItemsFromCD()
                        
                            self.refreshTable()
                    })
                
                
                
                }
            )
        
            self.presentViewController(tapAlert, animated: true, completion: nil)
        }
    }
    
    func refreshTable(){
        
        loadTableViewData()
        
        tableView.reloadData()
    
    }

    
    func loadTableViewData() {
        
        print("rebuidling dates")
        
        let itemsToSort = ItemManager.sharedInstance.items
        
        let sortedItems = itemsToSort.sort { $0.dateCreated!.compare($1.dateCreated!) == .OrderedDescending }
        
        dates = [String]()

        itemsByDate = [String: [CDItem]]()
        
        for item in sortedItems {
            
            let thisDateAsString = dateFormatter.stringFromDate(item.dateCreated!)
            
            if !dates.contains(thisDateAsString) {
                dates.append(thisDateAsString)
                itemsByDate[thisDateAsString] = [CDItem]()
            }
            
            itemsByDate[thisDateAsString]!.append(item)
        }
    }

}
