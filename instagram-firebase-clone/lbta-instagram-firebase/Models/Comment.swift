//
//  Comment.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 4/15/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import Foundation

struct Comment {
    let text: String
    let userId: String
    let creationDate: Date
    
    init(dictionary: [String:Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.userId = dictionary["userId"] as? String ?? ""
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
