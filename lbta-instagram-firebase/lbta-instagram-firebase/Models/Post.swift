//
//  Post.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 3/28/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import Foundation

struct Post {
    let imageURL: String
    let caption: String
    let creationDate: String
    let imageHeight: String
    let imageWidth: String
    
    // Creates an initializer, that takes in a dict and pulls things
    // like imageURL as String, or "" if no match found
    init(dictionary: [String: Any]) {
        self.imageURL = dictionary["imageURL"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.creationDate = dictionary["creationDate"] as? String ?? ""
        self.imageHeight = dictionary["imageHeight"] as? String ?? ""
        self.imageWidth = dictionary["imageWidth"] as? String ?? ""
    }
}
