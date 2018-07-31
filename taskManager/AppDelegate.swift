 //
//  AppDelegate.swift
//  taskManager
//
//  Created by Cristi_Tohatan on 27/07/2018.
//  Copyright © 2018 Cristi_Tohatan. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do{
            _ = try Realm()
        }catch{
            print("Error creating Realm \(error)")
        }
        
        return true
    }
}


