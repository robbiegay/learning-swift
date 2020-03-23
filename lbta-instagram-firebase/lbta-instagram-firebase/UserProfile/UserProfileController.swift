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
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        fetchUser()
        
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! UserProfileHeader
        
        header.user = self.user
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    var user: User?
    fileprivate func fetchUser() {
        let db = Firestore.firestore()
        let userUID = Auth.auth().currentUser?.uid ?? ""
        db.collection("users").document(userUID).getDocument { (documentSnapshot, err) in
            if let err = err {
                print("Error getting username:",err)
                return
            }
            
            guard let dictionary = documentSnapshot?.data() else { return }
            self.user = User(dictionary: dictionary)
            self.navigationItem.title = self.user?.username
            self.collectionView.reloadData()
        }
        
    }
}

// Create the model for the data, to be reused throughout the app
struct User {
    let username: String
    let profilePictureURL: String
    
    init(dictionary: [String:Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profilePictureURL = dictionary["profilePictureURL"] as? String ?? ""
    }
}
