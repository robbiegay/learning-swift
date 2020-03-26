//
//  MainTabBarController.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 3/20/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {
            let loginController = LoginController()
            let navController = UINavigationController(rootViewController: loginController)
            DispatchQueue.main.async {
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        // Home
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "house"), selectedImage: #imageLiteral(resourceName: "house.fill"), rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // Search
        let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "magnifyingglass.circle"), selectedImage: #imageLiteral(resourceName: "magnifyingglass.circle.fill"))
        
        // New Post
        let newPostNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "plus.square"), selectedImage: #imageLiteral(resourceName: "plus.square"))
        
        // Notifications
        let notificationsNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "heart"), selectedImage: #imageLiteral(resourceName: "heart.fill"))
        
        // User Profile
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        
        userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "person")
        userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "person.fill")
        
        tabBar.tintColor = .black
        
        viewControllers = [homeNavController,
                           searchNavController,
                           newPostNavController,
                           notificationsNavController,
                           userProfileNavController]
        
        // Centers nav item icons in nav bar
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
