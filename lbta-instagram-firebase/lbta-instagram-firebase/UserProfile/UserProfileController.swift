//
//  UserProfileController.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 3/20/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellID = "cellID"
    var postsArray = [Post]()
    var user: User?
    var userID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
        
        collectionView.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: cellID)
        
        fetchUser()
        setupLogOutButton()
        }
    
    // Fetches the User's data from Firebase, stores it in a local variable
    fileprivate func fetchUser() {
        let db = Firestore.firestore()
        // First: check for a inputed uid, then use auth.uid, then default to ""
        let uid = userID ?? Auth.auth().currentUser?.uid ?? ""
        db.collection("users").document(uid).getDocument { (documentSnapshot, err) in
            if let err = err {
                print("Error getting username:",err)
                return
            }
            
            guard let dictionary = documentSnapshot?.data() else { return }
            self.user = User(uid: uid, dictionary: dictionary)
            self.navigationItem.title = self.user?.username
            self.collectionView.reloadData()
            
            self.fetchPosts()
        }
    }
    
    // Creates the logout button
    fileprivate func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogout))
    }
    
    // Fetch posts from Firebase
    fileprivate func fetchPosts() {
        guard let uid = user?.uid else { return }
        
        let ref = Firestore.firestore().collection("users").document(uid).collection("posts")
        ref.order(by: "creationDate").addSnapshotListener({ (snapshot, err) in
            if let err = err {
                print("Failed to fetch user posts:",err)
            }
            
            // Clears the post array when the snapshot listener is triggered
            self.postsArray.removeAll()
            
            guard let documents = snapshot?.documents else { return }
            
            guard let user = self.user else { return }
            
            for document in documents {
                let dictionary = document.data()
                let post = Post(user: user, dictionary: dictionary)
                // Puts the users posts in the proper order (new photos first)
                self.postsArray.insert(post, at: 0)
            }
            
            self.collectionView.reloadData()
        })
    }
    
    // Logs the user out
    @objc func handleLogout() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                try Auth.auth().signOut()
                
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            } catch let signOutError {
                print("Failed to sign out:",signOutError)
            }
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return postsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! UserProfilePhotoCell
        
        cell.post = postsArray[indexPath.item]
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! UserProfileHeader
        
        header.user = self.user
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}
