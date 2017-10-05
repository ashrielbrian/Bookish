//
//  SaveButton.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 26/09/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

class SaveButton: UIButton {
    
    override func awakeFromNib() {
        layer.cornerRadius = 3.0
        backgroundColor = UIColor(red: 0.75, green: 0.20, blue: 0.19, alpha: 1.0)
        tintColor = .white
        // Distance between the font and the surrounding button border
        contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20)
    }
}
