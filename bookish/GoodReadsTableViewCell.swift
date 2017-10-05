//
//  GoodReadsTableViewCell.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 02/10/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class GoodReadsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var reviewBody: UILabel!
    
    var bookReview: GoodReadsBookReview! {
        
        didSet {
            bookTitleLabel.text = bookReview.title
            usernameLabel.text = bookReview.username
            reviewBody.text = bookReview.reviewBody
        }
    }
    
}
