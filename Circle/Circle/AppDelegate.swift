//
//  AppDelegate.swift
//  Circle
//
//  Created by Ivanna Peña on 4/14/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    //created custom colors to fit with color scheme
    let lightOrange = UIColor(red: 0.9216, green: 0.6353, blue: 0.4902, alpha: 1.0)
    let darkOrange = UIColor(red: 0.8784, green: 0.349, blue: 0.0824, alpha: 1.0)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //change color of nav bar
        let navigationBarAppearace = UINavigationBar.appearance()

        navigationBarAppearace.tintColor = darkOrange
        navigationBarAppearace.barTintColor = lightOrange
        
        //configures firebase
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

