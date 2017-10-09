//
//  Book+CoreDataProperties.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 26/09/2017.
//  Copyright © 2017 Ashriel Brian Tang. All rights reserved.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var author: String?
    @NSManaged public var title: String?
    @NSManaged public var creationDate: NSDate?
    @NSManaged public var review: String?

}
