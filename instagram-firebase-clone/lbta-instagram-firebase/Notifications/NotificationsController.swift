//
//  NotificationsController.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 4/16/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit

class NotificationsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let comingSoonLabel: UILabel = {
        let label = UILabel()
        label.text = "Coming Soon"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Notifications"
        collectionView.backgroundColor = .systemGray5
        
        view.addSubview(comingSoonLabel)
        comingSoonLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 200)
        comingSoonLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        comingSoonLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
