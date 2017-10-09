//
//  ReviewTextDelegate.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 27/09/2017.
//  Copyright © 2017 Ashriel Brian Tang. All rights reserved.
//

import Foundation
import UIKit

class ReviewTextViewFieldDelegate: NSObject, UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == NewReviewViewController().placeholderText {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = NewReviewViewController().placeholderText
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.scrollToBotom()
    }
}

extension UITextView {
    func scrollToBotom() {
        let range = NSMakeRange(text.characters.count - 1, 1)
        scrollRangeToVisible(range)
    }
}
