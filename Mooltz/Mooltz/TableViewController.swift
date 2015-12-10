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
    
    var locationSections: [String] = [String]()
    
    var itemsByLocation: [String: [CDItem]] = [String: [CDItem]]()
    
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

        return locationSections.count

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "itemDetail" {
            
            if let itemDetailVC = segue.destinationViewController as? ItemDetailViewController {
                
                let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
                
                itemDetailVC.selectedItem = itemsByLocation[locationSections[indexPath.section]]![indexPath.row]
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        print("number of rows in section: \(itemsByLocation[locationSections[section]]!.count)")

        return itemsByLocation[locationSections[section]]!.count

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        var reuseIdentifier = ""
        
        let section = locationSections[indexPath.section]

        let item = itemsByLocation[section]![indexPath.item]

        if item.marked == 1 {

            reuseIdentifier = "TextCellMarked"

        } else {

            reuseIdentifier = "TextCell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as UITableViewCell        
        
        cell.textLabel?.text = itemsByLocation[locationSections[indexPath.section]]![indexPath.row].name
        
        cell.imageView!.image = nil
        
        // Add gesture recognizer - samo če še ni nobenega
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: "longPressed:")
        
        recognizer.minimumPressDuration = 0.5
        
        cell.addGestureRecognizer(recognizer)
        
        if let cellImage = item.hasImage {

            print("trying image cell")
            print(cellImage)
            //cell.imageView?.image = cellImage.imageRef
            cell.imageView?.image = UIImage(contentsOfFile: CDImage.getDocumentPath(cellImage.imageFileName! + "_thumb"))
            
        }

        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        /*
        let calendar = NSCalendar.currentCalendar()

        let todayAsString = dateFormatter.stringFromDate(NSDate())
        
        let yesterdayAsString = dateFormatter.stringFromDate(calendar.dateByAddingUnit(.Day, value: -1, toDate: NSDate(), options: [])!)
        
        if dates[section] == todayAsString {
            return "Today"
        }
        else if dates[section] == yesterdayAsString {
            return "Yesterday"
        }
        */
        
        return locationSections[section]
    }

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let item = itemsByLocation[locationSections[indexPath.section]]![indexPath.row]
        
        var rowActions = [UITableViewRowAction]()
        
        //markAction
        
        let currentlyMarked = item.marked
        
        var titleMarked: String = String()
        
        if currentlyMarked == 1 {

            titleMarked = "Unmark"

        } else {
            
            titleMarked = "Mark"
        }
        
        let markAction = UITableViewRowAction(style: .Normal, title: titleMarked, handler: { action, indexPath
            
            in
            
            var destinationMark = false
            
            if currentlyMarked == 0 {

                destinationMark = true
                
            }
            
            MagicalRecord.saveWithBlock({context in
                
                item.marked = destinationMark
                
                }
                , completion: { success, error -> Void in
                    
                    ItemManager.sharedInstance.refreshItemsFromCD()
                    
                    self.refreshTable()
            })

            
            //tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        })
        
        markAction.backgroundColor = UIColor(red: 138.0/255.0, green: 9.0/255.0, blue: 23.0/255.0, alpha: 1.0)

        rowActions.append(markAction)
        
        var titleLocation: String = String()
        
        if item.location == Location.Here {
            
            titleLocation = "Move There"

        } else {
            
            titleLocation = "Move Here"
            
        }
        
        let moveAction = UITableViewRowAction(style: .Normal, title: titleLocation, handler: { action, indexPath in
            
            var destLocation: Location {
                if item.location == Location.Here {

                    return Location.There

                } else {
                    
                    return Location.Here
                }
            }
            
            MagicalRecord.saveWithBlock({context in
                    
                    item.location = destLocation
                    
                    }
                    , completion: { success, error -> Void in

                        ItemManager.sharedInstance.refreshItemsFromCD()
                        
                        self.refreshTable()
                })
            
        })
        
        moveAction.backgroundColor = UIColor(red: 3.0/255.0, green: 145.0/255.0, blue: 214.0/255.0, alpha: 1.0)
        
        rowActions.append(moveAction)
        
        return rowActions;
        
        // takojšen učinek geste move. Plus swipe z desne?
    }
    
    override func viewWillAppear(animated: Bool) {
        
        for item in ItemManager.sharedInstance.items {
            print("item marked status \(item.marked)")
        }


        refreshTable()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self

        tableView.dataSource = self
        
        //refreshTable()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshTable", name: "didSaveImage", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshTable", name: "NewItem", object: nil)
        

    }
    
    
    func longPressed(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .Began {
            
            let thisCell = recognizer.view as! UITableViewCell
            //print(thisCell.debugDescription)
            
            var tappedItem: CDItem?
            
            let indexPath = self.tableView.indexPathForCell(thisCell)
            
            tappedItem = itemsByLocation[locationSections[indexPath!.section]]![indexPath!.item]
            
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
        
        ItemManager.sharedInstance.refreshItemsFromCD()
        
        loadTableViewData()
        
        tableView.reloadData()
    
    }

    
    func loadTableViewData() {
        
        let itemsToSort = ItemManager.sharedInstance.items
        
        let sortedItems = itemsToSort.sort {
            
            if $0.location.description == $1.location.description {
                
                return $0.dateCreated!.compare($1.dateCreated!) == .OrderedDescending

            } else {
            
                return $0.location.description.compare($1.location.description) == .OrderedAscending
            }
        }
        
        locationSections = [String]()
        
        itemsByLocation = [String: [CDItem]]()

        for item in sortedItems {
            
            if !locationSections.contains(item.location.description) {
                
                locationSections.append(item.location.description)
                
                itemsByLocation[item.location.description] = [CDItem]()
            }
            
            itemsByLocation[item.location.description]!.append(item)
        }
        
    }

}
