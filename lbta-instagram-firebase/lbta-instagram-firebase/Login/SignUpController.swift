//
//  SignUpController.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 3/18/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class SignUpController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePlusPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let origionalImage = info[.originalImage] as? UIImage {
            plusPhotoButton.setImage(origionalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 3
        dismiss(animated: true, completion: nil)
    }
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = #colorLiteral(red: 0.9527953113, green: 0.9527953113, blue: 0.9527953113, alpha: 1)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    @objc func handleTextInputChange() {
        let isEmailValid = emailTextField.text?.count ?? 0 > 0
        let isUsernameValid = usernameTextField.text?.count ?? 0 > 0
        let isPasswordValid = passwordTextField.text?.count ?? 0 > 0
        
        if isEmailValid && isUsernameValid && isPasswordValid {
            signupButton.isEnabled = true
            signupButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        } else {
            signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
    }
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = #colorLiteral(red: 0.9527953113, green: 0.9527953113, blue: 0.9527953113, alpha: 1)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = #colorLiteral(red: 0.9527953113, green: 0.9527953113, blue: 0.9527953113, alpha: 1)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupInputFields()
        
        view.backgroundColor = .white
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text, email.description.count > 0 else { return }
        guard let username = usernameTextField.text, username.description.count > 0 else { return }
        guard let password = passwordTextField.text, password.description.count > 0 else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (dataResult: AuthDataResult?, error: Error?) in
            if let err = error {
                print("Failed to create user:",err)
                return
            }
            print("Sucesfully created user:",dataResult?.user.uid ?? "")
            
            guard let uid = dataResult?.user.uid else { return }
            
            let filename = UUID.init().uuidString
            guard let image = self.plusPhotoButton.imageView?.image else { return }
            guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
            let storageRef = Storage.storage().reference().child("profile_images").child(filename)
                
            storageRef.putData(uploadData, metadata: nil) { (metadata, err) in
                
                if let err = err {
                    print("Failed to upload profile image:",err)
                    return
                }
                print("Profile picture succesfully saved to db.")
                
                storageRef.downloadURL { (url, err) in
                    if let err = err {
                        print("Error retrieving download url: \(err.localizedDescription)")
                        return
                    }
                    let profilePictureURL = url?.absoluteString
                    print("Profile picture url saved:",profilePictureURL)
                    
                    let values = ["username": username, "profilePictureURL": profilePictureURL]
                    let db = Firestore.firestore()
                    db.collection("users").document(uid).setData(values) { (err) in
                        if let err = err {
                            print("Failed to save user info into db:",err)
                            return
                        }
                        print("Succesfully saved user info to db.")
                    }
                }
            }
        }
    }
    
    fileprivate func setupInputFields() {
        
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            usernameTextField,
            passwordTextField,
            signupButton,
        ])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 200)
    }
}