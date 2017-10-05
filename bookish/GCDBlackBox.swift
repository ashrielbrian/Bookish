//
//  GCDBlackBox.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 23/09/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation

func performUpdatesOnMain(_ updates: @escaping () -> Void) {
    
    DispatchQueue.main.async {
        updates()
    }
}
