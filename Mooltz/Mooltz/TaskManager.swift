//
//  TaskManager.swift
//  Mooltz
//
//  Created by Marko Jukic on 26/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import Foundation

class TaskManager {
    static let sharedInstance = TaskManager()
    
    func decodeItems(encoded: NSData) -> AnyObject? {
        return NSKeyedUnarchiver.unarchiveObjectWithData(encoded)
    }
    
    lazy var items: Set<Item> = {
        
        var savedItems = Set<Item>()
        
        if let encoded = NSUserDefaults.standardUserDefaults().objectForKey("items") {
            savedItems = self.decodeItems(encoded as! NSData) as! Set<Item>
        }
        return savedItems
    }()
    
    func addItems(item: Item) {
        self.items.insert(item)
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(self.items)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "items")
        NSUserDefaults.standardUserDefaults().synchronize()
        NSNotificationCenter.defaultCenter().postNotificationName("itemName", object: self)
    }
    
    func deleteItems(item: Item) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self.items)
        self.items.remove(item)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "items")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func description() -> String {
        return "Currently holding \(items.count) items."
    }
    
}

extension TaskManager {
    func itemsWithStatus(state: State) -> [Item] {
        var matchedItems = [Item]()
        for item in items {
            if item.state == state {
                matchedItems.append(item)
            }
        }
        return matchedItems
    }
}