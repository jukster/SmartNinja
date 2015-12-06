//
//  CDItem.swift
//  Mooltz
//
//  Created by Marko Jukic on 04/12/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import Foundation
import CoreData


class CDItem: NSManagedObject {
    
    //ali to sploh rabimo?
    override func didChangeValueForKey(key: String) {
        super.didChangeValueForKey(key)
        
        if key == "name" {
            self.dateModified = NSDate()
        }
    }
    
    var priority: Priority {
        
        get {
            
            let priorityValueAsInt = self.priorityValue?.longValue
            
            let priority = Priority(rawValue: priorityValueAsInt!)
            
            return priority!
        }
        
        set {

            self.priorityValue = newValue.rawValue

        }
        
    }
    
    override var description: String {
        let formatter = NSDateFormatter()
        formatter.timeStyle = NSDateFormatterStyle.LongStyle
        
        // print, če je notes zraven
        if let notesContent = notes {
            return "Predmet \(name), ustvarjen \(formatter.stringFromDate(dateCreated!)). Notes: \(notesContent)"
        } else {
            return "Predmet \(name), ustvarjen \(formatter.stringFromDate(dateCreated!)). Notes: None."
            
        }
        
    }
    
}