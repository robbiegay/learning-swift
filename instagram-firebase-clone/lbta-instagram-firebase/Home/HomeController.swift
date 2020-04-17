//
//  HomeController.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 3/30/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, HomePostCellDelegate {
    
    let cellID = "cellID"
    var postsArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleRefresh), name: SharePhotoController.updateFeedNotificationName, object: nil)
        
        collectionView.backgroundColor = .white
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: cellID)
        
        setupNavigationItems()
        fetchPosts()
    }
    
    @objc func handleRefresh() {
        postsArray.removeAll()
        collectionView.reloadData()
        fetchPosts()
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "camera").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleCamera))
    }
    
    @objc func handleCamera() {
        let cameraController = CameraController()
        // Allows you to make custom transitions
        cameraController.modalPresentationStyle = .fullScreen
        present(cameraController, animated: true, completion: nil)
    }
    
    fileprivate func fetchPosts() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print("Error fetching follwed users:",err)
            }
            self.collectionView.refreshControl?.endRefreshing()
            
            guard let followingArray = snapshot?.data()?["following"] as? [String] else { return }
            
            for profileUid in followingArray {
                Database.fetchUserWithUID(uid: profileUid) { (user) in
                    self.fetchPostsWithUser(user: user)
                }
            }
        }
        
        // Fetch logged in user posts as well
        Database.fetchUserWithUID(uid: uid) { (user) in
            self.fetchPostsWithUser(user: user)
        }
    }
    
    fileprivate func fetchPostsWithUser(user: User) {
        let ref = Firestore.firestore().collection("users").document(user.uid).collection("posts")
        ref.order(by: "creationDate").addSnapshotListener({ (snapshot, err) in
            if let err = err {
                print("Failed to fetch user posts:",err)
            }
            
            guard let documents = snapshot?.documents else { return }
            
            for document in documents {
                let dictionary = document.data()
                var post = Post(user: user, dictionary: dictionary)
                post.id = document.documentID
                guard let postId = post.id else { return }
                guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
                Firestore.firestore().collection("users").document(user.uid).collection("posts").document(postId).collection("likes").document(currentUserUid).getDocument { (snapshot, err) in
                    if let err = err {
                        print("Failed to fetch likes:",err)
                        return
                    }
                    
                    if let value = snapshot?.data()?[currentUserUid] as? Int, value == 1 {
                        post.hasLiked = true
                    } else {
                        post.hasLiked = false
                    }
                    
                    // check if the post already exsits in the array
                    // If so, skip adding that post to the array
                    
                    if self.postsArray.contains(where: { (postItem) -> Bool in
                        return post.id == postItem.id
                    }) {
                        return
                    }
                    
                    self.postsArray.append(post)
                    
                    self.postsArray.sort { (p1, p2) -> Bool in
                        return p1.creationDate.compare(p2.creationDate) == .orderedDescending
                    }
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 40 + 8 + 8 // User photo height + top and bottom padding
        height += view.frame.width // + the width of the screen (making a square for the photo
        height += 50 // Adds 50 for the lower controls (like, comment, etc)
        height += 60 // Space for caption
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HomePostCell
        
        cell.post = postsArray[indexPath.item]
        
        cell.delegate = self
        
        return cell
    }
    
    func didTapComment(post: Post) {
        print("Clicked on post with caption:",post.caption)
        
        let commentsController = CommentsController(collectionViewLayout: UICollectionViewFlowLayout())
        commentsController.post = post
        
        navigationController?.pushViewController(commentsController, animated: true)
    }
    
    func didLike(for cell: HomePostCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        var post = self.postsArray[indexPath.item]
        
        guard let postId = post.id else { return }
        
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        let values = [currentUserUid : post.hasLiked == true ? 0 : 1]
        Firestore.firestore().collection("users").document(post.user.uid).collection("posts").document(postId).collection("likes").document(currentUserUid).setData(values) { (err) in
            if let err = err {
                print("Failed to like photo:",err)
                return
            }
            
            print("Successfully liked photo.")
            
            post.hasLiked = !post.hasLiked
            
            self.postsArray[indexPath.item] = post
            
            self.collectionView.reloadItems(at: [indexPath])
        }
    }
}
