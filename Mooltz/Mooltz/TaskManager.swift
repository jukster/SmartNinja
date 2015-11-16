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
    
    lazy var items = [Item]()
    
    func addItems(item: Item) {
        self.items.append(item)
        NSNotificationCenter.defaultCenter().postNotificationName("itemName", object: self)
    }
    
    func deleteItems(item: Item) {
        guard let index = self.items.indexOf(item) else {
            return
        }
        self.items.removeAtIndex(index)
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