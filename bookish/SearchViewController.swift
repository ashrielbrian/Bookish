//
//  SearchViewController.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 20/09/2017.
//  Copyright © 2017 Ashriel Brian Tang. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var bookTitleTextField: UITextField!
    
    let nytClient = NYTClient.sharedInstance()
    var nytBookReviews = [NYTBookReview]()
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureBackgroundImage()
        self.hideKeyboard()
    }
    
    // Sets the background image
    func configureBackgroundImage() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "front2")?.draw(in: self.view.bounds)
        
        if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        } else {
            UIGraphicsEndImageContext()
            print("Could not find/load image")
        }
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
        let titleSearch = bookTitleTextField.text
        if (titleSearch != nil) && (titleSearch != "") {
            
            self.startActivityIndicator(activityIndicator)
            
            nytClient.bookReviewSearch(title: titleSearch!, completionHandlerForBookReviewSearch: {
                (success, error, bookReviewResults) in
                
                guard error == nil else {
                    performUpdatesOnMain {
                        self.stopActivityIndicator(self.activityIndicator)
                        self.displayAlert(title: "Oops", message: "Network Request to New York Times failed.", handler: {_ in })
                    }
                    return
                }
                
                if success {
                    
                    self.stopActivityIndicator(self.activityIndicator)
                    
                    if let bookReviewResults = bookReviewResults {
                        self.nytBookReviews = NYTBookReview.bookReviewsFromResults(results: bookReviewResults)
                        
                        if self.nytBookReviews.isEmpty {
                            performUpdatesOnMain {
                                let msg = "No search results returned for '\(titleSearch!)'. Try again."
                                self.displayAlert(title: "Oops!", message: msg, handler: {_ in })
                            }
                        } else {
                            performUpdatesOnMain {
                                self.compileSearchResults()
                            }
                        }
                    }
                    
                } else {
                    self.displayAlert(title: "Error", message: "No Network Conection", handler: {_ in })
                }
                
            })
        } else {
            displayAlert(title: "Oops!", message: "Please enter a title to search for!", handler: {_ in })
        }
    }
    
    func compileSearchResults() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "SearchResultsViewController") as! SearchResultsViewController
        
        controller.nytBookReviews = self.nytBookReviews
        self.present(controller, animated: true, completion: nil)
    }

}

