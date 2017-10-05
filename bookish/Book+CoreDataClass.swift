//
//  Book+CoreDataClass.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 26/09/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Book)
public class Book: NSManagedObject {
    
    convenience init (title: String, author: String, review: String, context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entity(forEntityName: "Book", in: context) {
            self.init(entity: ent, insertInto: context)
            self.author = author
            self.title = title
            self.review = review
            self.creationDate = NSDate()
            
        } else {
            fatalError("Could not save the object 'Book' into Core Data")
        }
        
    }
    
}
