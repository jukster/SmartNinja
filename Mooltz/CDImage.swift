//
//  CDImage.swift
//  Mooltz
//
//  Created by Marko Jukic on 04/12/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class CDImage: NSManagedObject {
    
    var imageRef : UIImage? {

        get {
            
            if let imageFileName = imageFileName {

                return UIImage(contentsOfFile: CDImage.getDocumentPath(imageFileName))
                
            } else {
                
                return nil
            }


        }

    }
    
    class func getDocumentPath(name: String) -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        let docs: String = paths[0]
        
        return NSString(string: docs).stringByAppendingPathComponent(name)
    }
    
    class func generateImageName() -> String {
        
        let randomImageName = String(randomNumber(UINT32_MAX))
        
        //let randomImageName = String(random())
        
        return randomImageName + ".png"
    }
    
    class func randomNumber(max: UInt32) -> Int {
        //print(arc4random_uniform, Int32)
        return Int(arc4random_uniform(max/2)) + 1
    }
// Insert code here to add functionality to your managed object subclass

}
