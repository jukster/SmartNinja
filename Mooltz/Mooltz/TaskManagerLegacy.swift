//
//  TaskManager.swift
//  Mooltz
//
//  Created by Marko Jukic on 26/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//
/*
import Foundation

class TaskManagerLegacy {
    static let sharedInstance = TaskManagerLegacy()

    var items = [Item]()
    
    func addItems(item: Item) {
        self.items.append(item)
        NSNotificationCenter.defaultCenter().postNotificationName("itemName", object: self)
        saveItems(self)
    }
    
    func deleteItems(item: Item) {
        guard let index = self.items.indexOf(item) else {
            return
        }
        self.items.removeAtIndex(index)
        saveItems(self)
    }
    
    func description() -> String {
        return "Currently holding \(items.count) items."
    }
    
}

extension TaskManagerLegacy {
    func activeItems() -> [Item] {
        var matchedItems = [Item]()
        for item in items {
            if item.active {
                matchedItems.append(item)
            }
        }
        return matchedItems
    }
}


*/