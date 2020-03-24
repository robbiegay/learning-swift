//
//  AppDelegate.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 3/18/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import Firebase

// Init global color variables
// Nat Forrest Theme
//let customGreen = UIColor(red:0.35, green:0.45, blue:0.36, alpha:1.00)
//let customYellow = UIColor(red:0.75, green:0.64, blue:0.29, alpha:1.00)
//let customTan = UIColor(red:0.95, green:0.89, blue:0.81, alpha:1.00)
//let customBrown = UIColor(red:0.35, green:0.20, blue:0.12, alpha:1.00)
//let customRed = UIColor(red:0.65, green:0.31, blue:0.18, alpha:1.00)

let instagramDarkBlue = UIColor.rgb(red: 0, green: 120, blue: 175)
let instagramButtonActiveColor = UIColor.rgb(red: 17, green: 154, blue: 237)
let instragramButtonInactiveColor = UIColor.rgb(red: 149, green: 204, blue: 244)

let mainColor = instagramDarkBlue
let buttonActiveColor = instagramButtonActiveColor
let buttonInactiveColor = instragramButtonInactiveColor
//let accentColor = customBrown
//let themeBackgroundColor = customTan

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

