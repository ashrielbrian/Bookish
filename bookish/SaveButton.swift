//
//  SaveButton.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 26/09/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit
import Material

class SaveButton: UIButton {
    
    override func awakeFromNib() {
        layer.cornerRadius = 3.0
        backgroundColor = UIColor(red: 0.75, green: 0.20, blue: 0.19, alpha: 1.0)
        tintColor = .white
        // Distance between the font and the surrounding button border
        contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20)
    }
}

class ActionButton: RaisedButton {
    override func awakeFromNib() {
        pulseColor = .white
        backgroundColor = Color.red.lighten1
        tintColor = .white
        contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20)
    }
}
