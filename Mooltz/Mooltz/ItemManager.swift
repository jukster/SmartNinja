//
//  TaskManager.swift
//  Mooltz
//
//  Created by Marko Jukic on 26/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import Foundation
import MagicalRecord
import ImageIO

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
    
    func addItem(name: String, location: Location, notes: String?, savedImageName: String?) {
        
        MagicalRecord.saveWithBlock({context in
            
            let newCDItem = CDItem.MR_createEntityInContext(context)
            
            newCDItem.marked = 0
            
            newCDItem.dateCreated = NSDate()
            
            newCDItem.dateModified = NSDate()

            newCDItem.name = name
            
            newCDItem.locationValue = location.rawValue
            
            if let itemNotes = notes {
                
                newCDItem.notes = itemNotes
            
            }
            
            if let itemImage = savedImageName {
                
                let newImage = CDImage.MR_createEntityInContext(context)
                    
                newImage.imageFileName = itemImage
                    
                newImage.relationship = newCDItem
                
            }
        
            }, completion: {success, error in
                NSNotificationCenter.defaultCenter().postNotificationName("NewItem", object: nil)
                
                //self.refreshItemsFromCD()
                
        })
    
    }
    
    func deleteItem() {
    
    }
    
    func storeImage(image: UIImage) -> String {

        let imageName = CDImage.generateImageName()

        let imageNameThumb = imageName + "_thumb"

        print("generated name: \(imageName)")

        let imageData = NSData(data: UIImagePNGRepresentation(image)!)

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            
            let imageSource = CGImageSourceCreateWithData(imageData as CFDataRef, nil)
            
            let options: [NSString: NSObject] = [
                kCGImageSourceThumbnailMaxPixelSize: 200 / 2.0,
                kCGImageSourceCreateThumbnailFromImageAlways: true
            ]
            
            let scaledImage = CGImageSourceCreateThumbnailAtIndex(imageSource!, 0, options).flatMap { UIImage(CGImage: $0) }
            
            let scaledImageData = NSData(data: UIImagePNGRepresentation(scaledImage!)!)
            
            scaledImageData.writeToFile(CDImage.getDocumentPath(imageNameThumb), atomically: true)
            
            dispatch_async(dispatch_get_main_queue(), {
                NSNotificationCenter.defaultCenter().postNotificationName("didSaveThumb", object: nil)
            })
            
            
            print("wrote down image thumbnail for \(imageName)")
            
        }

        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            
            imageData.writeToFile(CDImage.getDocumentPath(imageName), atomically: true)
            
            dispatch_async(dispatch_get_main_queue(), {
                NSNotificationCenter.defaultCenter().postNotificationName("didSaveImage", object: nil)            
            })

            
            print("wrote down image \(imageName)")
            
        }
        
        return imageName
    }
    
    func resizeImageAtPath(imageData: NSData) {
        

    }

}