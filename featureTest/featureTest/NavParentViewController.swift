//
//  NavParentViewController.swift
//  featureTest
//
//  Created by Robbie Gay on 2/14/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import TinyConstraints

class NavParentViewController: UIViewController {
    
    let pushButton = UIButton()
    let presentButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Push & Present"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(pushButton)
        pushButton.topToSuperview(offset: 200)
        pushButton.centerXToSuperview()
        pushButton.setTitle("Push View", for: .normal)
        pushButton.setTitleColor(.black, for: .normal)
        pushButton.width(200)
        pushButton.layer.cornerRadius = 15
        pushButton.layer.masksToBounds = true
        pushButton.layer.borderWidth = 3
        pushButton.addTarget(self, action: #selector(handlePush), for: .touchUpInside)
        
        view.addSubview(presentButton)
        presentButton.top(to: pushButton, offset: 50)
        presentButton.centerXToSuperview()
        presentButton.setTitle("Present View", for: .normal)
        presentButton.setTitleColor(.black, for: .normal)
        presentButton.width(200)
        presentButton.layer.cornerRadius = 15
        presentButton.layer.masksToBounds = true
        presentButton.layer.borderWidth = 3
        presentButton.addTarget(self, action: #selector(handlePresent), for: .touchUpInside)
    }
    
    @objc func handlePush() {
        navigationController?.pushViewController(FruitTableViewController(), animated: true)
    }
    
    @objc func handlePresent() {
        navigationController?.present(ViewController(), animated: true, completion: nil)
    }
}
