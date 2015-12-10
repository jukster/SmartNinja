//
//  CDImage+CoreDataProperties.swift
//  Mooltz
//
//  Created by Marko Jukic on 09/12/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CDImage {

    @NSManaged var imageFileName: String?
    @NSManaged var relationship: CDItem?

}
