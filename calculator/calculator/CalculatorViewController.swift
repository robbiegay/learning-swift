//
//  CalculatorViewController.swift
//  calculator
//
//  Created by Robbie Gay on 1/29/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import TinyConstraints

class CalculatorViewController: UIViewController {
    
//    let displayScreen = UITextField(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
    let displayScreen = UILabel()
    let button = UIButton()
    
//    let button = UIButton(frame: CGRect(x: 100, y: 500, width: buttonDiameter, height: buttonDiameter))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(displayScreen)
        view.addSubview(button)

        styleSubviews()
    }
    
    func styleSubviews() {
        // Gets 1% of height and width
        let viewHeight = self.view.frame.height / 100
        // let viewWidth = self.view.frame.width / 100
        let buttonDiameter = 100
        
        view.backgroundColor = .black
        
        displayScreen.backgroundColor = #colorLiteral(red: 0.3548194171, green: 0.5498460586, blue: 0.3825876544, alpha: 1)
        displayScreen.text = "0"
        displayScreen.textColor = .white
        displayScreen.textAlignment = .right
        displayScreen.font = UIFont(name: "Futura-Medium", size: viewHeight * 15)
        
        displayScreen.topToSuperview()
        displayScreen.leadingToSuperview()
        displayScreen.height(viewHeight * 30)
        displayScreen.widthToSuperview()
        
        button.leadingToSuperview()
        button.topToBottom(of: displayScreen)
        button.setTitle("1", for: .normal)
        button.layer.borderWidth = 3
        button.layer.cornerRadius = CGFloat(buttonDiameter) / 2
        button.layer.masksToBounds = true
        
        
        button.addTarget(self, action: #selector(handleClick), for: .touchUpInside)
    }
    
    @objc func handleClick() {
        print("Clicked")
    }
}
