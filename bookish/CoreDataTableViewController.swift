//
//  CoreDataTableViewController.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 26/09/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit
import CoreData

// MARK: CoreDataTableViewController: frc Initialisation

class CoreDataTableViewController: UITableViewController {
    
    // Initialising the Fetched Results Controller
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? {
        // Whenever the frc changes, we execute the search and reload the table
        didSet {
            fetchedResultsController?.delegate = self
            executeSearch()
            tableView.reloadData()
        }
    }
    
    init(fetchedResultsController fc: NSFetchedResultsController<NSFetchRequestResult>, style: UITableViewStyle = .plain) {
        fetchedResultsController = fc
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK: CoreDataTableViewController: Fetching Results
extension CoreDataTableViewController {
    func executeSearch() {
        if let fc = fetchedResultsController {
            do {
                try fc.performFetch()
            } catch let err {
                print ("Error trying to perform a search: \n\(err)\n\(String(describing: fetchedResultsController))")
            }
        }
    }
}

// MARK: CoreDataTableViewController: Tableview Data Source
extension CoreDataTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let frc = fetchedResultsController {
            return frc.sections![section].numberOfObjects
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("This method must be implemented by a subclass of CoreDataTableViewController")
    }
}

// MARK: CoreDataTableViewController: frc Delegate Functions
extension CoreDataTableViewController: NSFetchedResultsControllerDelegate {
    
    // Prepares the tableview for changes when the frc detects data content change
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}
