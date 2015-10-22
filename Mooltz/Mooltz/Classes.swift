//
//  Classes.swift
//  Mooltz
//
//  Created by Marko Jukic on 21/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import Foundation

enum State: Int {
    case Active = 0, Inactive
}

enum Priority: String {
    case Normal, High
}

func == (lhs: Item, rhs: Item) -> Bool {
    return lhs.name == rhs.name
}

class Item: Hashable {
    
    static var nextUID: Int = 1
    
    var name: String {
        didSet {
            self.dateModified = NSDate()
        }
    }
    
    let uID: Int

    var hashValue: Int {
        return self.name.hashValue
    }
    
    let dateCreated: NSDate
    
    var dateModified: NSDate
    
    var state = State(rawValue: 0) {
        didSet {
            self.dateModified = NSDate()
        }
    }
    
    var priority = Priority(rawValue: "Normal") {
        didSet {
            self.dateModified = NSDate()
        }
    }
    
    func description() -> String {
        return "Predmet \(name), ustvarjen \(dateCreated). Status "
    }
    
    init(name: String, priority: Priority) {
        self.uID = Item.nextUID
        Item.nextUID += 1
        self.name = name
        self.dateCreated = NSDate()
        self.dateModified = NSDate()
        self.priority = priority
    }
    
    convenience init() {
        self.init(name: "Nov predmet", priority: Priority(rawValue: "Normal")!)
    }
}

class TaskManager {
    var items: Set<Item> = []
    
    func addItems(item: Item) {
        self.items.insert(item)
    }
    
    func deleteItems(item: Item) {
        self.items.remove(item)
    }
    
    func description() -> String {
        return "Currently holding \(items.count) items."
    }
    
}











