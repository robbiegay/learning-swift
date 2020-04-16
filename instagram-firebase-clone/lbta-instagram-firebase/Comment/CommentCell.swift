//
//  CommentCell.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 4/14/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import Firebase

class CommentCell: UICollectionViewCell {
    
    var comment: Comment? {
        didSet {
            guard let commentText = comment?.text else { return }
            
            guard let userUid = comment?.userId else { return }
            
            Firestore.firestore().collection("users").document(userUid).getDocument { (snapshot, err) in
                if let err = err {
                    print("Failed to fetch comment user profiles:",err)
                }
                
                guard let profileImageUrl = snapshot?.data()?["profilePictureURL"] as? String else { return }
                
                guard let username = snapshot?.data()?["username"] as? String else { return }
                
                self.profileImageView.loadImage(urlString: profileImageUrl)
                
                let attributedText = NSMutableAttributedString(string: "\(username) ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
                
                attributedText.append(NSAttributedString(string: commentText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
                
                self.textView.attributedText = attributedText
            }
        }
    }
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .systemGray5
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.isScrollEnabled = false
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        
        addSubview(textView)
        textView.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
