//
//  MaterialButton.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 03/10/2017.
//  Copyright © 2017 Ashriel Brian Tang. All rights reserved.
//

import Foundation
import UIKit
import Material


extension UIViewController {
    
    func prepareFabButton(_ image: UIImage) -> FABButton {
        let diameter: CGFloat = 64
        let button = FABButton(image: image, tintColor: .white)
        button.pulseColor = .white
        button.backgroundColor = Color.red.base
    
        view.layout(button).width(diameter).height(diameter).right(64).bottom(64)
        
        return button
    }
    
    func prepareRaisedButton(title: String) -> RaisedButton {
        let button = RaisedButton(title: title, titleColor: .white)
        button.pulseColor = .white
        button.backgroundColor = Color.blue.base
        
        view.addSubview(button)
        // Still need to position the Raised button within the VC
        return button
    }
    
}
