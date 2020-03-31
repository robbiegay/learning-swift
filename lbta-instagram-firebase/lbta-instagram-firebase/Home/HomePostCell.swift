//
//  HomePostCell.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 3/30/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit

class HomePostCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            guard let postImageURL = post?.imageURL else { return }
            
            photoImageView.loadImage(urlString: postImageURL)
        }
    }
    
    // Create it as the CustomImage in order to access the extension like properties
    let photoImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .systemGray5
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
