//
//  CDItem+CoreDataProperties.swift
//  Mooltz
//
//  Created by Marko Jukic on 06/12/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CDItem {

    @NSManaged var active: NSNumber?
    @NSManaged var dateCreated: NSDate?
    @NSManaged var dateModified: NSDate?
    @NSManaged var name: String?
    @NSManaged var notes: String?
    @NSManaged var priorityValue: NSNumber?
    @NSManaged var hasImage: CDImage?

}
