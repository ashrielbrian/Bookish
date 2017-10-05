//
//  BookDetailViewController.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 28/09/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var reviewText: UILabel!
    
    var book: Book!
    let fabImage = UIImage(named: "add-white")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBookInfo()
        prepareFabButton(fabImage!)
    }
    
    func updateBookInfo() {
        bookTitle.text = book.title
        bookAuthor.text = book.author
        reviewText.text = book.review
    }
    
}
