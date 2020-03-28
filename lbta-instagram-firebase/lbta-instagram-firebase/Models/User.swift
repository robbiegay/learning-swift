//
//  User.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 3/28/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import Foundation

struct User {
    let username: String
    let profilePictureURL: String
    
    init(dictionary: [String:Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profilePictureURL = dictionary["profilePictureURL"] as? String ?? ""
    }
}
