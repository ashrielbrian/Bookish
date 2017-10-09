//
//  BookDetailViewController.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 28/09/2017.
//  Copyright © 2017 Ashriel Brian Tang. All rights reserved.
//

import Foundation
import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var reviewText: UILabel!
    
    var book: Book!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBookInfo()
        configureBookTitle()
    }
    
    func updateBookInfo() {
        bookTitle.text = book.title
        bookAuthor.text = book.author
        reviewText.text = book.review
    }
    
    func configureBookTitle() {
        // Adjusts the font size if the title is too long
        bookTitle.adjustsFontSizeToFitWidth = true
        bookTitle.minimumScaleFactor = 0.5
    }
}
