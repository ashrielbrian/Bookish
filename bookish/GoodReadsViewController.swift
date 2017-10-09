//
//  GoodReadsViewController.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 20/09/2017.
//  Copyright © 2017 Ashriel Brian Tang. All rights reserved.
//

import UIKit
import Material

class GoodReadsViewController: UITableViewController {
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    let cellIdentifier = "bookReviewCell"
    var activityIndicator = UIActivityIndicatorView()
    var latestBookReviews = [GoodReadsBookReview]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 155.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        toolbar.isTranslucent = false
        toolbar.barTintColor = Color.yellow.darken1
        fetchData()
    }

    func fetchData() {
        let clientParser = GoodReadsClient()
        startActivityIndicator(activityIndicator)
        
        clientParser.parse { (success, error, results) in
            
            guard error == nil else {
                performUpdatesOnMain {
                    self.stopActivityIndicator(self.activityIndicator)
                    self.displayAlert(title: "Oops", message: "The network request to GoodReads failed. Check your internet connection.", handler: {_ in })
                }
                print(error?.localizedDescription ?? "The network request to GoodReads failed.")
                return
            }
            
            if success {
                if let results = results {
                    self.latestBookReviews = results
                    performUpdatesOnMain {
                        self.stopActivityIndicator(self.activityIndicator)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        fetchData()
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestBookReviews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GoodReadsTableViewCell
        
        cell.bookReview = latestBookReviews[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let reviewUrl = latestBookReviews[indexPath.row].reviewUrl
        if let reviewUrl = reviewUrl {
            if let url = URL(string: reviewUrl) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    self.displayAlert(title: "Oops", message: "Could not open the url for this GoodReads review", handler: {_ in })
                    print ("Could not open: \(url.absoluteString)")
                }
            }
        }
    }

}
