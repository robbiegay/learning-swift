//
//  UserSearchController.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 4/1/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import Firebase

class UserSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    let cellID = "cellID"
    var filteredUsers = [User]()
    var users = [User]()
    
    // Lazy var = waits till search bar is instantiated before running
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter username"
        sb.delegate = self
        sb.autocapitalizationType = .none
        return sb
    }()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            filteredUsers = users
        } else {
            self.filteredUsers = self.users.filter { (user) -> Bool in
                return user.username.lowercased().contains(searchText.lowercased())
            }
        }
        
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        let navBar = navigationController?.navigationBar
        
        navBar?.addSubview(searchBar)
        searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        collectionView.register(UserSearchCell.self, forCellWithReuseIdentifier: cellID)
        
        // Allows you to scroll even if the screen doesn't overflow with content
        collectionView.alwaysBounceVertical = true
        // Dismesses keyboard when dragging the view
        collectionView.keyboardDismissMode = .onDrag
        
        fetchUsers()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchBar.isHidden = true
        // This hides the keyboard when you click on a row
        searchBar.resignFirstResponder()
        
        let user = filteredUsers[indexPath.item]
        
        let userProfileController = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        userProfileController.userID = user.uid
        navigationController?.pushViewController(userProfileController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.isHidden = false
    }
    
    fileprivate func fetchUsers() {
        Firestore.firestore().collection("users").addSnapshotListener { (snapshot, err) in
            if let err = err {
                print("Failed the fetch users for search:",err)
            }
            
            // Clears users array each time the array of users is being loaded
            self.users.removeAll()
            
            guard let documents = snapshot?.documents else { return }
            
            for document in documents {
                let uid = document.documentID
                
                if uid == Auth.auth().currentUser?.uid {
                    print("Found myself, omit from list")
                } else {
                    let user = User(uid: uid, dictionary: document.data())
                    self.users.append(user)
                }
            }

            self.users.sort { (u1, u2) -> Bool in
                return u1.username.compare(u2.username) == .orderedAscending
            }

            self.filteredUsers = self.users
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! UserSearchCell
        cell.user = filteredUsers[indexPath.item]
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 66)
    }
}
