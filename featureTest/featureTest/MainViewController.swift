//
//  MainViewController.swift
//  featureTest
//
//  Created by Robbie Gay on 2/1/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import TinyConstraints

class MainViewController: UIViewController {
    /*
     -Label-
     -Button-
     Segmented Text
     Text Field
     Slider
     Switch
     Activity Indicator
     Progress View
     Table View
     Table View Cell
     Iamge View
    */
    
    let testLabel = UILabel()
    let testButton = UIButton()
    let testSeg = UISegmentedControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(testLabel)
        view.addSubview(testButton)
        view.addSubview(testSeg)
        
        styleSubviews()
    }
    
    func styleSubviews() {
        view.backgroundColor = #colorLiteral(red: 0.9499809146, green: 0.4625762105, blue: 0.1792234778, alpha: 1)
        
        testLabel.text = "This is a UILabel"
        testLabel.font = UIFont(name: "Futura-Medium", size: 30)
        testLabel.textAlignment = .center
        testLabel.backgroundColor = #colorLiteral(red: 0.3319281638, green: 0.4998449683, blue: 0.4219300747, alpha: 1)
        testLabel.leadingToSuperview()
        testLabel.topToSuperview()
        testLabel.height(150)
        testLabel.trailingToSuperview()
        
        testButton.setTitle("This is a UIButton", for: .normal)
        testButton.topToBottom(of: testLabel, offset: 50)
        testButton.leadingToSuperview(offset: 50)
        testButton.width(300)
        testButton.layer.borderWidth = 3
        testButton.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        testButton.layer.cornerRadius = 10
        testButton.layer.masksToBounds = true
        testButton.addTarget(self, action: #selector(handleButtonClick), for: .touchUpInside)
        testButton.backgroundColor = #colorLiteral(red: 0.8044971824, green: 0.2484204769, blue: 0.2948410213, alpha: 1)
        
        testSeg.backgroundColor = #colorLiteral(red: 0.8044971824, green: 0.2484204769, blue: 0.2948410213, alpha: 1)
        testSeg.leadingToSuperview(offset: 50)
        testSeg.topToBottom(of: testButton, offset: 50)
    }
    
    @objc func handleButtonClick() {
        view.backgroundColor = view.backgroundColor == #colorLiteral(red: 0.8044971824, green: 0.2484204769, blue: 0.2948410213, alpha: 1) ? #colorLiteral(red: 0.9499809146, green: 0.4625762105, blue: 0.1792234778, alpha: 1) : #colorLiteral(red: 0.8044971824, green: 0.2484204769, blue: 0.2948410213, alpha: 1)
        testButton.backgroundColor = view.backgroundColor == #colorLiteral(red: 0.9499809146, green: 0.4625762105, blue: 0.1792234778, alpha: 1) ? #colorLiteral(red: 0.8044971824, green: 0.2484204769, blue: 0.2948410213, alpha: 1) : #colorLiteral(red: 0.9499809146, green: 0.4625762105, blue: 0.1792234778, alpha: 1)
    }
}
