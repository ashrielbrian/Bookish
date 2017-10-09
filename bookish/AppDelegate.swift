//
//  AppDelegate.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 20/09/2017.
//  Copyright © 2017 Ashriel Brian Tang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let stack = CoreDataStack(modelName: "Model")!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        checkIfFirstLaunch()
        
        return true
    }
    
    // MARK: - Helper Functions
    
    func preloadData() {
        // Test Data
        let _ = Book(title: "Bookish - The Beginning", author: "Brian Tang", review: "I'm really happy to be able to share with you: Bookish!\n\nDiscover new books through GoodReads' recent reviews; search for the reviews you've always wondered about on The New York Times; and flesh out your thoughts on your most recent reads.\n\nLove a book or hate a book, Bookish's happy to hear about it!\n\nEnjoy your time on the App! ", context: stack.context)
    }
    
    // Removes previous data, if any
    func resetData() {
        do {
            try stack.dropAllData()
        } catch {
            print ("Could not delete previous data.")
        }
    }
    
    // Checks if this is the first time the app has launched; if so, create a default book review entry
    func checkIfFirstLaunch() {
        if UserDefaults.standard.bool(forKey: "hasLaunchedBefore") {
            print("App has launched before!")
        } else {
            preloadData()
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
            UserDefaults.standard.synchronize()
        }
    }
    
    // Obtains the location of the directory where Core Data objects are being saved
    func printCoreDataDirectoryLocation() {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1] as URL)
    }
    

}

