//
//  TaskManager.swift
//  Mooltz
//
//  Created by Marko Jukic on 26/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import Foundation
import MagicalRecord

class ItemManager {

    static let sharedInstance = ItemManager()
    
    init() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshItemsFromCD", name: "NewItem", object: nil)

    }
    
    var items = [CDItem]()
    
    @objc func refreshItemsFromCD() {
        
        if let itemsFromCD = CDItem.MR_findAll() as? [CDItem] {
                        
            items = itemsFromCD
        }
        
    }
    
    func addItem(name: String, priority: Priority, notes: String?, hasImage: UIImage?) {
        
        MagicalRecord.saveWithBlock({context in
            
            let newCDItem = CDItem.MR_createEntityInContext(context)
            
            newCDItem.active = 1
            
            newCDItem.dateCreated = NSDate()
            
            newCDItem.dateModified = NSDate()

            newCDItem.name = name
            
            newCDItem.priorityValue = priority.rawValue
            
            if let itemNotes = notes {
                
                newCDItem.notes = itemNotes
            
            }
            
            if let itemImage = hasImage {
                
                let newImage = CDImage.MR_createEntityInContext(context)
                    
                newImage.imageFileName = self.storeImage(itemImage)
                    
                newImage.relationship = newCDItem
                
            }
        
            }, completion: {success, error in
                NSNotificationCenter.defaultCenter().postNotificationName("NewItem", object: nil)
                
        })
    
    }
    
    func deleteItem() {
    
    }
    
    func storeImage(image: UIImage) -> String {

        let imageName = CDImage.generateImageName()
        
        print("generated name: \(imageName)")
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let imageData = NSData(data: UIImagePNGRepresentation(image)!)
            
            imageData.writeToFile(CDImage.getDocumentPath(imageName), atomically: true)
            
            dispatch_async(dispatch_get_main_queue(), {
                NSNotificationCenter.defaultCenter().postNotificationName("didSaveImage", object: nil)            
            })

            
            print("wrote down image \(imageName)")
            
        }
        
        return imageName
    }

}