//
//  NewReviewViewController.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 20/09/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit
import Material

class NewReviewViewController: UIViewController {
    
    let placeholderText = "Your thoughts on the book?"
    let reviewTextDelegate = ReviewTextViewFieldDelegate()
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var reviewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        reviewTextView.delegate = reviewTextDelegate
        
        reviewTextView.text = placeholderText
        reviewTextView.textColor = UIColor.lightGray
        toolbar.barTintColor = Color.yellow.darken1
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveReviewButton(_ sender: Any) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let stack = delegate.stack
        
        
        if let title = titleTextField.text, let author = authorTextField.text, let review = reviewTextView.text {
            if title != "" && author != "" && review != "" {
                _ = Book(title: title, author: author, review: review, context: stack.context)
                stack.save()
                displayAlert(title: "Done!", message: "Your review was successfully saved!", handler: { (alert) in
                    self.dismiss(animated: true, completion: nil)
                })
            
            } else {
                displayAlert(title: "Error", message: "One or more fields are empty. Please enter a book title, author and your review.", handler: {_ in })
            }
        }
    }
}
