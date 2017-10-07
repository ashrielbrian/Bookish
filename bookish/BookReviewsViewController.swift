//
//  BookReviewsViewController.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 20/09/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit
import CoreData
import Material

class BookReviewsViewController: CoreDataTableViewController {
    
    
    let reuseIdentifier = "myBookCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let stack = delegate.stack
        
        configureNavBar()
        
        // Create a fetch request
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        fr.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        // Create the fetch results controller
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    func configureNavBar() {
        self.navigationController?.navigationBar.barTintColor = Color.yellow.darken1
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let book = fetchedResultsController?.object(at: indexPath) as! Book
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = book.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = fetchedResultsController?.object(at: indexPath) as! Book
        pushToDetailVC(book)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteReview(indexPath: indexPath)
            
        }
    }
    
    
    @IBAction func addBookReview(_ sender: Any) {

        let controller = storyboard?.instantiateViewController(withIdentifier: "NewReviewViewController") as! NewReviewViewController
        self.present(controller, animated: true, completion: nil)
 
    }
    
    // Function to instantiate and push to new BookDetailViewController
    func pushToDetailVC(_ book: Book) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookDetailViewController") as? BookDetailViewController {
            if let navigator = navigationController {
                viewController.book = book
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    // MARK: - Delete Reviews Swipe
    
    func deleteReview(indexPath: IndexPath) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let stack = delegate.stack
        stack.context.delete(fetchedResultsController?.object(at: indexPath) as! Book)
        stack.save()
        
        performUpdatesOnMain {
            self.tableView.reloadData()
        }
    }
    
}

