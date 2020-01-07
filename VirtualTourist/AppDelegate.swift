//
//  AppDelegate.swift
//  Virtual Tourist
//
//  Created by 강선미 on 21/10/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let dataController = DataController(modelName: "VirtualTourist")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navigationController = window?.rootViewController as! UINavigationController
        let mapview = navigationController.topViewController as! MapViewController
        mapview.dataController = (UIApplication.shared.delegate as? AppDelegate)?.dataController
          
        dataController.load()
       
        return true
    }


    func applicationDidEnterBackground(_ application: UIApplication) {

        saveViewContext()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        saveViewContext()
    }

    func saveViewContext() {
        try? dataController.viewContext.save()
    }
}


