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

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout, userProfileHeaderDelegate {
    let gridCellId = "gridCellId"
    let listCellId = "listCellId"
    var postsArray = [Post]()
    var user: User?
    var userID: String?
    
    var isGridView = true
    
    func didChangeToGridView() {
        isGridView = true
        collectionView.reloadData()
    }
    
    func didChangeToListView() {
        isGridView = false
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
        
        collectionView.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: gridCellId)
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: listCellId)
        
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
            
            self.paginatePosts()
        }
    }
    
    // Creates the logout button
    fileprivate func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogout))
    }
    
    var value: Double = Date().timeIntervalSince1970
    
    fileprivate func paginatePosts() {
        guard let uid = user?.uid else { return }
        
        let ref = Firestore.firestore().collection("users").document(uid).collection("posts")
        
        // Start at the current time, retrieving the 5 most recent photos
        let query = ref.order(by: "creationDate", descending: true).limit(to: 6).start(at: [value])
        
        query.addSnapshotListener({ (snapshot, err) in
            if let err = err {
                print("Failed to fetch user posts:",err)
            }
            
            guard let documents = snapshot?.documents else { return }
            
            guard let user = self.user else { return }
            
            for document in documents {
                let dictionary = document.data()
                let post = Post(user: user, dictionary: dictionary)
                self.postsArray.append(post)
            }
            
            self.collectionView.reloadData()
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Paginates by checking for a time that is just barely later than the last time checked
        let currentItemTime = postsArray[indexPath.item].creationDate.timeIntervalSince1970 - 0.000001
        
        // Check to see if last cell is being rendered, if so -> fire paginate function
        // If value is already equal to current time, ie if we are on the last cell and
        // it is rendering again, stop
        if indexPath.item == self.postsArray.count - 1, value != currentItemTime {
            value = currentItemTime
            paginatePosts()
        }
        
        if isGridView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gridCellId, for: indexPath) as! UserProfilePhotoCell
            cell.post = postsArray[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listCellId, for: indexPath) as! HomePostCell
            cell.post = postsArray[indexPath.item]
            return cell
        }
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isGridView {
            let width = (view.frame.width - 2) / 3
            return CGSize(width: width, height: width)
        } else {
            var height: CGFloat = 40 + 8 + 8 // User photo height + top and bottom padding
            height += view.frame.width // + the width of the screen (making a square for the photo
            height += 50 // Adds 50 for the lower controls (like, comment, etc)
            height += 60 // Space for caption
            
            return CGSize(width: view.frame.width, height: height)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! UserProfileHeader
        
        header.user = self.user
        header.delegate = self
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}
