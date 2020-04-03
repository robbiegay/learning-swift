//
//  User.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 3/28/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import Foundation

struct User {
    let uid: String
    let username: String
    let profilePictureURL: String
    
    init(uid: String, dictionary: [String:Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profilePictureURL = dictionary["profilePictureURL"] as? String ?? ""
    }
}
