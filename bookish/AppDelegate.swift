//
//  AppDelegate.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 20/09/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let stack = CoreDataStack(modelName: "Model")!
    
    func preloadData() {
        // Remove previous data, if any
        do {
            try stack.dropAllData()
        } catch {
            print ("Could not delete previous data.")
        }
 
        // Test Data
        let _ = Book(title: "Let My People Go Surfing", author: "Yvon Chounaird", review: "The biography of Patagonia by its legendary climber-founder: Yvon.", context: stack.context)
        let _ = Book(title: "The Grid", author: "Matt Watkinson", review: "How to make real-time business decisions through the use of a revolutionary matrix: the Grid.", context: stack.context)
        
    }
    
    // Obtains the location of the directory where Core Data objects are being saved
    func printCoreDataDirectoryLocation() {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1] as URL)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        preloadData()
        printCoreDataDirectoryLocation()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

