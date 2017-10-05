//
//  CoreDataStack.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 25/09/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import CoreData


// MARK: Core Data Stack
struct CoreDataStack {
    
    // MARK: Properties
    
    private let model: NSManagedObjectModel
    internal let coordinator: NSPersistentStoreCoordinator
    private let modelURL: URL
    internal let dbURL: URL
    let context: NSManagedObjectContext
    
    // MARK: Initializers
    
    init?(modelName: String) {
        
        // Assumes the model is in the main bundle
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            print ("Unable to find \(modelName) in the main bundle")
            return nil
        }
        
        self.modelURL = modelURL
        
        // Try to create the model from the URL
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            print ("Unable to create model from \(modelURL)")
            return nil
        }
        
        self.model = model
        
        // Create the store coordinator
        coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        // Context to show data to the UI
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        
        // Add a SQLite store located in the documents folder
        let fileManager = FileManager.default
        
        guard let docURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print ("Unable to reach the documents folder")
            return nil
        }
        
        self.dbURL = docURL.appendingPathComponent("model.sqlite")
        
        do {
            try addStoreCoordinator(NSSQLiteStoreType, configuration: nil, storeURL: dbURL)
        } catch {
            print ("Unable to add store at \(dbURL)")
        }
        
    }
    
    // MARK: Utils
    func addStoreCoordinator(_ storeType: String, configuration: String?, storeURL: URL, options: [NSObject: AnyObject]? = nil) throws {
        
        try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: dbURL, options: options)
    }
}
    
// MARK: - CoreDataStack: Removing Data
internal extension CoreDataStack {
    
    // Deletes all the objects in the DB - this won't delete the files. Then creates a new store coordinator to replace the previous
    func dropAllData() throws {
        let options = [NSInferMappingModelAutomaticallyOption: true, NSMigratePersistentStoresAutomaticallyOption: true]
        try coordinator.destroyPersistentStore(at: dbURL, ofType: NSSQLiteStoreType, options: nil)
        try addStoreCoordinator(NSSQLiteStoreType, configuration: nil, storeURL: dbURL, options: options as [NSObject: AnyObject])
    }
}

// MARK: - CoreDataStack: Saving Data
extension CoreDataStack {
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let err {
                print (err.localizedDescription)
            }
        }
    }
}
