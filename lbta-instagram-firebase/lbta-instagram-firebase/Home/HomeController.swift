//
//  HomeController.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 3/30/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "cellID"
    var postsArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: cellID)
        
        setupNavigationItems()
        fetchPosts()
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
    }
    
    fileprivate func fetchPosts() {
        var user: User?
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).addSnapshotListener { (snapshot, err) in
            if let err = err {
                print("Failed to fetch users:",err)
            }
            
            guard let userDictionary = snapshot?.data() else { return }
            
            user = User(dictionary: userDictionary)
            
        }
        
        let ref = Firestore.firestore().collection("users").document(uid).collection("posts")
        ref.order(by: "creationDate").addSnapshotListener({ (snapshot, err) in
            if let err = err {
                print("Failed to fetch user posts:",err)
            }
            
            // Clears the post array when the snapshot listener is triggered
            self.postsArray.removeAll()
            
            guard let documents = snapshot?.documents else { return }
            
            guard let user = user else { return }
                        
            for document in documents {
                let dictionary = document.data()
                let post = Post(user: user, dictionary: dictionary)
                self.postsArray.append(post)
            }
            
            self.collectionView.reloadData()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 40 + 8 + 8 // User photo height + top and bottom padding
        height += view.frame.width // + the width of the screen (making a square for the photo
        height += 50 // Adds 50 for the lower controls (like, comment, etc)
        height += 60 // Space for caption
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HomePostCell
        
        cell.post = postsArray[indexPath.item]
        
        return cell
    }
}
