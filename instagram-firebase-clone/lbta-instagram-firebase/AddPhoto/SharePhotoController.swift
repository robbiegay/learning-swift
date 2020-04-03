//
//  SharePhotoController.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 3/27/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController: UIViewController {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        setupImageAndTextViews()
    }
    
    // Adds image and text field to screen
    fileprivate func setupImageAndTextViews() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        containerView.addSubview(imageView)
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 84, height: 0)
        imageView.image = selectedImage
        
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, left: imageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 0, height: 0)
    }
    
    @objc func handleShare() {
        // prevents user from uploading without a caption
        let caption = textView.text
        if caption?.count == 0 {
            return
        }
        
        guard let image = selectedImage else { return }
        
        guard let uploadData = image.jpegData(compressionQuality: 0.5) else { return }
        
        // Prevents user from saving multiple times, and reenables if an error occurs
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let filename = NSUUID().uuidString
        // Puts post image in Firebase Storage
        let storageRef = Storage.storage().reference().child("posts").child(filename)
        storageRef.putData(uploadData, metadata: nil) { (metadata, err) in
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to upload post image:",err)
                return
            }
                        
            storageRef.downloadURL { (url, err) in
                if let err = err {
                    print("Failed to fetch post image URL:",err)
                    return
                }
                
                guard let downloadURL = url?.absoluteString else { return }
                
                print("Sucesfully uploaded post image:",downloadURL)
                
                // Saves to post data to Firebase Database
                self.saveToDatebaseWithImageURL(imageURL: downloadURL)
            }
        }
    }
    
    fileprivate func saveToDatebaseWithImageURL(imageURL: String) {
        guard let caption = textView.text else { return }
        guard let postImage = imageView.image else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["imageURL": imageURL, "caption": caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String : Any]
        let db = Firestore.firestore()
        db.collection("users").document(uid).collection("posts").addDocument(data: values, completion: { (err) in
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to save post to DB:",err)
            }
            
            print("sucessfully saved post to DB.")
            self.dismiss(animated: true, completion: nil)
        })
    }
}
