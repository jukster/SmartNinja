//
//  Item.swift
//  Mooltz
//
//  Created by Marko Jukic on 26/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import Foundation

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
    
    var priority = Priority(rawValue: 0) {
        didSet {
            self.dateModified = NSDate()
        }
    }
    
    override var description: String {
        let formatter = NSDateFormatter()
        formatter.timeStyle = NSDateFormatterStyle.LongStyle
        return "Predmet \(name), ustvarjen \(formatter.stringFromDate(dateCreated)). ID \(uID)"
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
        self.init(name: "Nov predmet", priority: Priority(rawValue: 0)!)
    }
    
    @objc func encodeWithCoder(coder: NSCoder) {
        // do not call super in this case
        coder.encodeObject(self.uID, forKey: "uID")
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeObject(self.dateCreated, forKey: "dateCreated")
        coder.encodeObject(self.dateModified, forKey: "dateModified")
        coder.encodeObject(self.priority as? AnyObject, forKey: "priority")
        coder.encodeObject(self.state as? AnyObject, forKey: "state")
    }
    
    @objc required init(coder: NSCoder) {
        self.uID = coder.decodeObjectForKey("uID") as! Int
        self.name = coder.decodeObjectForKey("name") as! String
        self.dateCreated = coder.decodeObjectForKey("dateCreated") as! NSDate
        self.dateModified = coder.decodeObjectForKey("dateModified") as! NSDate
        self.priority = coder.decodeObjectForKey("priority") as? Priority
        self.state = coder.decodeObjectForKey("state") as? State
    }
}
