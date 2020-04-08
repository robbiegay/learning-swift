//
//  Post.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 3/28/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import Foundation

struct Post {
    let user: User
    
    let imageURL: String
    let caption: String
    let creationDate: Date
    let imageHeight: String
    let imageWidth: String
    
    // Creates an initializer, that takes in a dict and pulls things
    // like imageURL as String, or "" if no match found
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        
        self.imageURL = dictionary["imageURL"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
        self.imageHeight = dictionary["imageHeight"] as? String ?? ""
        self.imageWidth = dictionary["imageWidth"] as? String ?? ""
    }
}
