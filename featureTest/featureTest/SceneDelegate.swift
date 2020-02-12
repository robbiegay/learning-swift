//
//  SceneDelegate.swift
//  featureTest
//
//  Created by Robbie Gay on 2/1/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        
        // --> Various page views
        let mainView =
            MainViewController()
        let tableView = ViewController()
        let fruitTabelView = FruitTableViewController()
                
        // --> Adding nav bars to two of the pages
        let housematesNavController = UINavigationController(rootViewController: tableView)
        let fruitNavController = UINavigationController(rootViewController: fruitTabelView)
            
        // --> Creating a tabBarController
        let tabBarController = UITabBarController()
        // --> Adding the veiws to the tabBar
        tabBarController.setViewControllers([mainView, housematesNavController, fruitNavController], animated: true)
        // --> Adding each tab bar items label and icon
        // mainView.tabBarItem = UITabBarItem(title: "Feature Test", image: #imageLiteral(resourceName: "Moolathon Logo final_logo only black"), tag: 0)
        mainView.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        housematesNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        fruitNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 2)
        
        // --> Placing the tab bar in the window's rootViewController
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = tabBarController
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

