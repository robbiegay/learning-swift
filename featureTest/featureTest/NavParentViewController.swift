//
//  NavParentViewController.swift
//  featureTest
//
//  Created by Robbie Gay on 2/14/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import TinyConstraints
import AudioToolbox

class NavParentViewController: UIViewController {
    
    let pushButton = UIButton()
    let presentButton = UIButton()
    
    let vc = ViewController()

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
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        vc.tableView.isUserInteractionEnabled = true
        vc.tableView.addGestureRecognizer(pan)
        
        // iPhone 7 and up: Haptics
        let heavyImpact = UIImpactFeedbackGenerator(style: .heavy)
        heavyImpact.impactOccurred()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handlePresent() {
        // iPhone 6s Haptic workaround
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        navigationController?.present(FruitTableViewController(), animated: true, completion: nil)
    }
    
    @objc func handlePan() {
        print("Panned")
        vc.navigationController?.dismiss(animated: true, completion: nil)
    }
}
