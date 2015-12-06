//
//  Item.swift
//  Mooltz
//
//  Created by Marko Jukic on 26/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import Foundation
import UIKit

class Item: NSObject, NSCoding {
    
    static var nextUID: Int = 1
    
    var name: String {
        didSet {
            self.dateModified = NSDate()
        }
    }
    
    var image: UIImage?
    
    var imagePath: String?
    
    let uID: Int
    
    let dateCreated: NSDate
    
    var dateModified: NSDate
    
    var active = true {
        didSet {
            self.dateModified = NSDate()
        }
    }
    
    var notes: String?
        
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
        
        // print, če je notes zraven
        if let notesContent = notes {
            return "Predmet \(name), ustvarjen \(formatter.stringFromDate(dateCreated)). ID \(uID). Notes: \(notesContent)"
        } else {
            return "Predmet \(name), ustvarjen \(formatter.stringFromDate(dateCreated)). ID \(uID). Notes: None."
            
        }
        
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
    
    // demo initializer za preteklost
    init(forceBackwardsDate: Int) {
        let dateCreated = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: forceBackwardsDate*(-1), toDate: NSDate(), options: [])

        self.uID = Item.nextUID
        Item.nextUID += 1
        self.name = "Neka stvar za \(forceBackwardsDate) dni nazaj"
        self.dateCreated = dateCreated!
        self.dateModified = NSDate()
        self.priority = Priority(rawValue: 0)
    }
    
    @objc func encodeWithCoder(coder: NSCoder) {
        // do not call super in this case
        coder.encodeObject(self.uID, forKey: "uID")
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeObject(self.dateCreated, forKey: "dateCreated")
        coder.encodeObject(self.dateModified, forKey: "dateModified")
        coder.encodeObject(self.priority as? AnyObject, forKey: "priority")
        coder.encodeObject(self.active, forKey: "active")
        coder.encodeObject(self.notes, forKey: "notes")
        coder.encodeObject(self.imagePath, forKey: "imagePath")
    }
    
    @objc required init(coder: NSCoder) {
        self.uID = coder.decodeObjectForKey("uID") as! Int
        self.name = coder.decodeObjectForKey("name") as! String
        self.dateCreated = coder.decodeObjectForKey("dateCreated") as! NSDate
        self.dateModified = coder.decodeObjectForKey("dateModified") as! NSDate
        self.priority = coder.decodeObjectForKey("priority") as? Priority
        self.active = coder.decodeObjectForKey("active") as! Bool
        self.notes = coder.decodeObjectForKey("notes") as? String
        self.imagePath = coder.decodeObjectForKey("imagePath") as? String
    }
}