//
//  saveItems.swift
//  Mooltz
//
//  Created by Marko Jukic on 15/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//
/*
import Foundation

func saveItems(calledfrom: AnyObject){

    let data = NSKeyedArchiver.archivedDataWithRootObject(TaskManager.sharedInstance.items)

    NSUserDefaults.standardUserDefaults().setObject(data, forKey: "items")

    NSUserDefaults.standardUserDefaults().synchronize()

    print("saved \(TaskManager.sharedInstance.items.count) items, called by \(calledfrom)")
    
    /* JSON vaja
    
    do {
    
        let dataAsJSON = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))

        NSUserDefaults.standardUserDefaults().setObject(dataAsJSON, forKey: "itemsJSON")

        NSUserDefaults.standardUserDefaults().synchronize()
    } catch {
        
    }
    */
    
}

func loadItems(calledfrom: AnyObject){

    if let encoded = NSUserDefaults.standardUserDefaults().objectForKey("items") {

        func decodeItems(encoded: NSData) -> AnyObject? {

            return NSKeyedUnarchiver.unarchiveObjectWithData(encoded)

        }

        TaskManager.sharedInstance.items = decodeItems(encoded as! NSData) as! [Item]

        print("loaded \(TaskManager.sharedInstance.items.count) items, called by \(calledfrom)")

    }
}
*/