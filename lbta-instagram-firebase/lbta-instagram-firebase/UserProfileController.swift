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

class UserProfileController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        fetchUser()
    }
    
    fileprivate func fetchUser() {
        let db = Firestore.firestore()
        let userUID = Auth.auth().currentUser?.uid ?? ""
        db.collection("users").document(userUID).getDocument { (documentSnapshot, err) in
            if let err = err {
                print("Error getting username:",err)
                return
            }

            guard let username = documentSnapshot?.data()?["username"] else { return }
            self.navigationItem.title = username as? String
        }
        
    }
}
