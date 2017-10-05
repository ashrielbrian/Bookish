//
//  GoodReadsViewController.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 20/09/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

class GoodReadsViewController: UITableViewController {
    
    let cellIdentifier = "bookReviewCell"
    var latestBookReviews = [GoodReadsBookReview]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 155.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        fetchData()
    }

    func fetchData() {
        let clientParser = GoodReadsClient()
        clientParser.parse { (success, error, results) in
            
            guard error == nil else {
                print(error?.localizedDescription ?? "The network request to GoodReads failed.")
                return
            }
            
            if success {
                if let results = results {
                    self.latestBookReviews = results
                    performUpdatesOnMain {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
                    print ("Could not open: \(url.absoluteString)")
                }
            }
        }
    }

}
