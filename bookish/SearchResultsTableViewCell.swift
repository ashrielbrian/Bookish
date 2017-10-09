//
//  SearchResultsTableViewCell.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 22/09/2017.
//  Copyright © 2017 Ashriel Brian Tang. All rights reserved.
//

import UIKit
import Foundation

class SearchResultsCustomCell: UITableViewCell {
    
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var bookSummaryLabel: UILabel!
    
    var bookReview: NYTBookReview! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        // Setting cell background colour to gray
        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        
        // Assigning the label properties
        bookTitleLabel.text = bookReview.bookTitle
        bylineLabel.text = bookReview.reviewAuthor
        bookSummaryLabel.text = bookReview.summary
        
        // Configuring the background card shadows
        backgroundCardView.backgroundColor = UIColor.white
        backgroundCardView.layer.cornerRadius = 3.0
        backgroundCardView.layer.masksToBounds = false
        backgroundCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCardView.layer.shadowOpacity = 0.8
        
    }
    
    
}
