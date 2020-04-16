//
//  MainTabBarController.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 3/20/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        // Lets you select any view controller except the add post controller
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            present(navController, animated: true, completion: nil)
            
            return false
        } else {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
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
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "house"), selectedImage: #imageLiteral(resourceName: "house.fill"), rootViewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // Search
        let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "magnifyingglass.circle"), selectedImage: #imageLiteral(resourceName: "magnifyingglass.circle.fill"), rootViewController: UserSearchController(collectionViewLayout: UICollectionViewFlowLayout()))
                
        // New Post
        let newPostNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "plus.square"), selectedImage: #imageLiteral(resourceName: "plus.square"))
        
        // Notifications
        let notificationsNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "heart"), selectedImage: #imageLiteral(resourceName: "heart.fill"), rootViewController: NotificationsController(collectionViewLayout: UICollectionViewFlowLayout()))
        
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
