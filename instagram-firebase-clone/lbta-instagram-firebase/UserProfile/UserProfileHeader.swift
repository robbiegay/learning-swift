//
//  UserProfileHeader.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 3/20/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

protocol userProfileHeaderDelegate {
    func didChangeToListView()
    func didChangeToGridView()
}

class UserProfileHeader: UICollectionViewCell {
    
    var delegate: userProfileHeaderDelegate?
    
    var user: User? {
        didSet {
            guard let profileImageURL = user?.profilePictureURL else { return }
            profileImageView.loadImage(urlString: profileImageURL)
            
            usernameLabel.text = user?.username
            
            setupEditFollowButton()
            
            getUserData()
        }
    }
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .systemGray5
        return iv
    }()
    
    lazy var gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        button.addTarget(self, action: #selector(handleChangeToGridView), for: .touchUpInside)
        return button
    }()
    
    // Must be lazy var in order to add target
    lazy var listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.addTarget(self, action: #selector(handleChangeToListView), for: .touchUpInside)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let postsLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "posts", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
        ]))
        
        label.attributedText = attributedText
        
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
                
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "followers", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
        ]))
        
        label.attributedText = attributedText

        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "following", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
        ]))
        
        label.attributedText = attributedText
        
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // Since we updated the title above, we have to make this a "lazy var"
    lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(handleEditProfileOrFollow), for: .touchUpInside)
        return button
    }()
    
    fileprivate func getUserData() {
        guard let userID = user?.uid else { return }
        
        let ref = Firestore.firestore().collection("users").document(userID)
        
        // Fetch number of posts value
        ref.collection("posts").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error fetching posts number:",err)
                return
            }
            
            guard let snapshotArray = snapshot else { return }
            
            let attributedText = NSMutableAttributedString(string: "\(snapshotArray.count)\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string: "posts", attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
            ]))
            
            self.postsLabel.attributedText = attributedText
        }
        
        // Fetch followers value
        Firestore.firestore().collection("users").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error fetching followers number:",err)
                return
            }
            
            var followers = 0
            
            guard let documents = snapshot?.documents else { return }
                        
            for document in documents {
                if document["following"] != nil {
                    guard let followingArray = document["following"] as? [String] else { return }
                    let ifTrue = followingArray.contains { (value) -> Bool in
                        return userID == value
                    }
                    if ifTrue {
                        followers += 1
                    }
                }
                
                let attributedText = NSMutableAttributedString(string: "\(followers)\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
                
                attributedText.append(NSAttributedString(string: "followers", attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
                ]))
                
                self.followersLabel.attributedText = attributedText
            }
        }
        
        // Fetch following value
        ref.getDocument { (snapshot, err) in
            if let err = err {
                print("Error fetching following number:",err)
                return
            }
            
            guard let followingArray = snapshot?.data()?["following"] as? [String] else { return }
            
            let attributedText = NSMutableAttributedString(string: "\(followingArray.count)\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string: "following", attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
            ]))
            
            self.followingLabel.attributedText = attributedText
        }
    }
    
    fileprivate func setupEditFollowButton() {
        guard let currentLoggedInUserID = Auth.auth().currentUser?.uid else { return }
        guard let userID = user?.uid else { return }

        if currentLoggedInUserID == userID {
            editProfileFollowButton.setTitle("Edit Profile", for: .normal)
        } else {
            // check if following user
            Firestore.firestore().collection("users").document(currentLoggedInUserID).getDocument { (snapshot, err) in
                if let err = err {
                    print("Failed to check if following:",err)
                }
                guard let followingArray = snapshot?.data()?["following"] as? [String] else {
                    self.setupFollowStyle()
                    return
                }
                let isFollowing = followingArray.contains(userID)
                
                if isFollowing {
                    self.editProfileFollowButton.setTitle("Unfollow", for: .normal)
                    self.editProfileFollowButton.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
                } else {
                    self.setupFollowStyle()
                }
            }
        }
    }
    
    @objc func handleEditProfileOrFollow() {
        guard let currentLoggedInUserId = Auth.auth().currentUser?.uid else { return }
        guard let userId = user?.uid else { return }
        
        let ref = Firestore.firestore().collection("users").document(currentLoggedInUserId)
        
        // Follow User
        if editProfileFollowButton.titleLabel?.text == "Follow" {
            // arrayUnion joins the array values
            let values = ["following": FieldValue.arrayUnion([userId])]
            ref.setData(values, merge: true) { (err) in
                if let err = err {
                    print("Faield to follow user",err)
                }
                
                print("Succesfully followed user:",userId)
                self.editProfileFollowButton.setTitle("Unfollow", for: .normal)
                self.editProfileFollowButton.backgroundColor = .white
                self.editProfileFollowButton.setTitleColor(.black, for: .normal)
                self.editProfileFollowButton.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
            }
        // Unfollow User
        } else if editProfileFollowButton.titleLabel?.text == "Unfollow" {
            // arrayRemove removes a value from the array
            let values = ["following": FieldValue.arrayRemove([userId])]
            ref.setData(values, merge: true) { (err) in
                if let err = err {
                    print("Faield to unfollow user",err)
                }
                
                print("Succesfully unfollowed user:",userId)
                self.setupFollowStyle()
            }
        }
    }
    
    @objc func handleChangeToGridView() {
        print("changing to grid view...")
        gridButton.tintColor = .mainBlue()
        listButton.tintColor = UIColor(white: 0, alpha: 0.2)
        delegate?.didChangeToGridView()
    }
    
    @objc func handleChangeToListView() {
        print("changing to list view...")
        listButton.tintColor = .mainBlue()
        gridButton.tintColor = UIColor(white: 0, alpha: 0.2)
        delegate?.didChangeToListView()
    }
    
    fileprivate func setupFollowStyle() {
        self.editProfileFollowButton.setTitle("Follow", for: .normal)
        self.editProfileFollowButton.backgroundColor = instagramButtonActiveColor
        self.editProfileFollowButton.setTitleColor(.white, for: .normal)
        self.editProfileFollowButton.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        
        setupBottomToolbar()
        
        addSubview(usernameLabel)
        usernameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: gridButton.topAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        setupUserStatsView()
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: postsLabel.bottomAnchor, left: postsLabel.leftAnchor, bottom: nil, right: followingLabel.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 34)
    }
    
    fileprivate func setupUserStatsView() {
        let stackView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 50)
    }
    
    fileprivate func setupBottomToolbar() {
        let topDividerView = UIView()
        topDividerView.backgroundColor = .lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = .lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        stackView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        topDividerView.anchor(top: stackView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
