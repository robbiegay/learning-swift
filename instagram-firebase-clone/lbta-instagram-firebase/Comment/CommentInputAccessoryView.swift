//
//  CommentInputAccessoryView.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 4/16/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit

protocol CommentInputAccessoryViewDelegate {
    func didSubmit(for comment: String)
}

class CommentInputAccessoryView: UIView {
    
    var delegate: CommentInputAccessoryViewDelegate?

    func clearCommentField() {
        commentTextField.text = nil
        commentTextField.showPlaceholderLabel()
    }
    
    fileprivate let commentTextField: CommentInputTextView = {
        let tv = CommentInputTextView()
        tv.isScrollEnabled = false
        tv.font = UIFont.systemFont(ofSize: 18)
        return tv
    }()

    fileprivate let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Step one for multiline comment
        autoresizingMask = .flexibleHeight
        
        backgroundColor = .white
        
        addSubview(submitButton)
        submitButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 50, height: 50)

        addSubview(commentTextField)
        // Step 3 for multiline
        if #available(iOS 11.0, *) {
            commentTextField.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: submitButton.leftAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 0, height: 0)
        } else {
            commentTextField.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: submitButton.leftAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 0, height: 0)
        }

        setupLineSeperatorView()
    }
    
    // Step 2 for multiline
    // Allows program to resize itself as it sees fit
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    fileprivate func setupLineSeperatorView() {
        let lineSeperatorView = UIView()
        lineSeperatorView.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        addSubview(lineSeperatorView)
        lineSeperatorView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }

    @objc func handleSubmit() {
        guard let commentText = commentTextField.text else { return }
        delegate?.didSubmit(for: commentText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
