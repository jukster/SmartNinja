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

class Item: NSObject, NSCoding {
    
    static var nextUID: Int = 1
    
    var name: String {
        didSet {
            self.dateModified = NSDate()
        }
    }
    
    let uID: Int
    
    let dateCreated: NSDate
    
    var dateModified: NSDate
    
    var state = State(rawValue: 0) {
        didSet {
            self.dateModified = NSDate()
        }
    }
    
    override var hashValue: Int {
        return self.name.hashValue
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? Item {
            return object.name == self.name
        } else  {
            return false
        }
    }
    
    var priority = Priority(rawValue: "Normal") {
        didSet {
            self.dateModified = NSDate()
        }
    }
    
    override var description: String {
        let formatter = NSDateFormatter()
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        return "Predmet \(name), ustvarjen \(formatter.stringFromDate(dateCreated))."
    }
    
    init(name: String, priority: Priority) {
        self.uID = Item.nextUID
        Item.nextUID += 1
        self.name = name
        self.dateCreated = NSDate()
        self.dateModified = NSDate()
        self.priority = priority
    }
    
    convenience override init() {
        self.init(name: "Nov predmet", priority: Priority(rawValue: "Normal")!)
    }

    @objc func encodeWithCoder(coder: NSCoder) {
        // do not call super in this case
        coder.encodeObject(self.uID, forKey: "uID")
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeObject(self.dateCreated, forKey: "dateCreated")
        coder.encodeObject(self.dateModified, forKey: "dateModified")
        coder.encodeObject(self.priority as? AnyObject, forKey: "priority")
    }
    
    @objc required init(coder: NSCoder) {
        self.uID = coder.decodeObjectForKey("uID") as! Int
        self.name = coder.decodeObjectForKey("name") as! String
        self.dateCreated = coder.decodeObjectForKey("dateCreated") as! NSDate
        self.dateModified = coder.decodeObjectForKey("dateModified") as! NSDate
        self.priority = coder.decodeObjectForKey("priority") as? Priority
    }
}

class TaskManager {
    static let sharedInstance = TaskManager()

    
    lazy var items: Set<Item> = {

        func decodeItems(encoded: NSData) -> AnyObject? {
            return NSKeyedUnarchiver.unarchiveObjectWithData(encoded)
        }

        var savedItems = Set<Item>()

        if let encoded = NSUserDefaults.standardUserDefaults().objectForKey("items") {
            savedItems = decodeItems(encoded as! NSData) as! Set<Item>
        }
        return savedItems
    }()
    
    func addItems(item: Item) {
        self.items.insert(item)

        let data = NSKeyedArchiver.archivedDataWithRootObject(self.items)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "items")
        NSUserDefaults.standardUserDefaults().synchronize()
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