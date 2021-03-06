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

enum Priority: Int {
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
    
    var priority = Priority(rawValue: 0) {
        didSet {
            self.dateModified = NSDate()
        }
    }
    
    func description() -> String {
        return "Predmet \(name), ustvarjen \(dateCreated). Status "
    }
    
    init(name: String) {
        self.uID = Item.nextUID
        Item.nextUID += 1
        self.name = name
        self.dateCreated = NSDate()
        self.dateModified = NSDate()
    }
    
    convenience init() {
        self.init(name: "Nov predmet")
    }
}
/*
class TaskManager {
var tasks: Set<Item>

func addTasks(item: Item) {
self.tasks.append(item)
}

func deleteTasks(item: Item) {
var tasksToDelete = [String]()
for task in tasks:
if let
}
}
*/

var prva = Item(name: "prva")

print(prva.uID)

print(prva.dateCreated.description)

print(prva.state)

print(prva.dateCreated)

print(prva.priority)

var drug = Item(name: "prva")

drug.name
drug.uID

var mojlist = [String]()

mojlist.append("prva")

print(mojlist)

mojlist.removeAll()

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

var mojManager = TaskManager()

print(mojManager.items)


mojManager.addItems(prva)

mojManager.description()

mojManager.addItems(drug)

prva == drug

prva.name == drug.name

mojManager.description()

var mojSet = Set<String>()

mojSet.insert("bla")
mojSet.insert("bla")







