//
//  Helper.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 27/09/2017.
//  Copyright © 2017 Ashriel Brian Tang. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: - Activity Indicators
    func startActivityIndicator(_ activityIndicator: UIActivityIndicatorView) {
        activityIndicator.center = self.view.center
        activityIndicator.activityIndicatorViewStyle = .gray
        
        performUpdatesOnMain {
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        
    }
    
    func stopActivityIndicator(_ activityIndicator: UIActivityIndicatorView) {
        performUpdatesOnMain {
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    // MARK: - Alert Views
    func displayAlert(title: String, message: String, handler: @escaping (_ alert: UIAlertAction) -> Void) {
        performUpdatesOnMain {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Keyboards
    // Resigns keyboard on tap
    func hideKeyboard() {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.cancelsTouchesInView = false // IMPORTANT: this ensures that each subview will handle a tap accordingly; eg a UIButton will handle the tap through its own IBAction, whilst tapping anywhere else will call dismissKeyboard()
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func dismissKeyboard(_ recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

