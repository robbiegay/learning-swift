//
//  CommentsController.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 4/14/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import Firebase

class CommentsController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CommentInputAccessoryViewDelegate {
    var post: Post?
    var comments = [Comment]()
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Comments"
        
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        
        collectionView.backgroundColor = .white
        
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: cellID)
        
        fetchComments()
    }
    
    fileprivate func fetchComments() {
        guard let userUid = post?.user.uid else { return }
        guard let postId = post?.id else { return }
        let ref = Firestore.firestore().collection("users").document(userUid).collection("posts").document(postId).collection("comments").order(by: "creationDate")
        
        ref.getDocuments { (snapshot, err) in
            if let err = err {
                print("Failed to fetch comments",err)
            }
            
            guard let documents = snapshot?.documents else { return }
                        
            for document in documents {
                
                let comment = Comment(dictionary: document.data())
                                   
                self.comments.append(comment)
            }
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CommentCell
        
        cell.comment = self.comments[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
//        let dummyCell = CommentCell(frame: frame)
//        print("Comment at index path:",comments[indexPath.item])
//        dummyCell.comment = comments[indexPath.item]
//        print("Dummey cell height:",dummyCell.frame.height)
//        dummyCell.layoutIfNeeded()
//
//        let targetSize = CGSize(width: view.frame.width, height: 1000)
//        let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
//        print("estimated size:",estimatedSize)
//
//        print("Estimated height:",estimatedSize.height)
//
//        let height = max(40 + 8 + 8, estimatedSize.height)
//        print("Final height:",height)
//        print("===================================")
//        return CGSize(width: view.frame.width, height: 200)
        
        // A hack to size the cell based on length of string
        let commentTextLength = comments[indexPath.item].text.count
        let numberOfLines = ceil(Double(commentTextLength) / 30)
        let maxHeight = 12 * numberOfLines
        let height = max(40 + 8 + 8, maxHeight)
        
        return CGSize(width: view.frame.width, height: CGFloat(height))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    lazy var containerView: CommentInputAccessoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let commentInputAccessoryView = CommentInputAccessoryView(frame: frame)
        commentInputAccessoryView.delegate = self
        return commentInputAccessoryView
    }()
    
    func didSubmit(for comment: String) {
        let values = [
            "text": comment,
            "userId": Auth.auth().currentUser?.uid ?? "",
            "creationDate": Date().timeIntervalSince1970
        ] as [String : Any]

        guard let userUid = post?.user.uid else { return }
        guard let postId = post?.id else { return }
        Firestore.firestore().collection("users").document(userUid).collection("posts").document(postId).collection("comments").addDocument(data: values) { (err) in
            if let err = err {
                print("Error adding comment:",err)
            }

            print("Successfully added comment.")
            let comment = Comment(dictionary: values)
            self.comments.append(comment)
            self.collectionView.reloadData()
        }
                
        self.containerView.clearCommentField()
    }

    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
}
