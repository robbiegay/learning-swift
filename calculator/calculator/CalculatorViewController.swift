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
    
    var num1 = ""
    var num2 = ""
    var operand = ""
    var equalTemp = Int()
    var eqPress = false
    
    let displayScreen = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(displayScreen)
        view.addSubview(button)
        
        createButtons()
        styleSubviews()
    }
    
    func createButtons() {
        let buttonDimensions = (self.view.frame.width / 100) * 20
        
        let calcBtns = ["C", "", "", "÷", "7", "8", "9", "X", "4", "5", "6", "-", "1", "2", "3", "+", "0", "", ".", "="]
        var tagNum = 1
        
        for buttonLabel in calcBtns {
            let button = UIButton()
            if buttonLabel != "" {
                button.addTarget(self, action: #selector(handleClick), for: .touchUpInside)
            }
            self.view.addSubview(button)
            
            button.height(buttonDimensions)
            button.width(buttonDimensions)
            button.setTitle(buttonLabel, for: .normal)
            button.layer.borderWidth = 3
            button.layer.cornerRadius = buttonDimensions / 2
            button.layer.masksToBounds = true
            button.tag = tagNum
            
            tagNum += 1
        }
    }
    
    func styleSubviews() {
        /*
         Display height = 30% of view
         Button section height = 70%
         Each button = 20 % of width, with 4% width padding on each side
         Button height could be 10% of height and 4% width padding
         */
        
        // Gets 1% of height and width
        let viewHeight = self.view.frame.height / 100
        let viewWidth = self.view.frame.width / 100
        
        
        view.backgroundColor = #colorLiteral(red: 0.9987662435, green: 0.9001430869, blue: 0.7403401732, alpha: 1)
        
        displayScreen.backgroundColor = #colorLiteral(red: 0.5557582974, green: 0.6102099419, blue: 0.468695879, alpha: 1)
        displayScreen.text = "0"
        displayScreen.textColor = #colorLiteral(red: 0.3411012292, green: 0.3455565274, blue: 0.3205627799, alpha: 1)
        displayScreen.textAlignment = .right
        displayScreen.font = UIFont(name: "Futura-Medium", size: viewHeight * 15)
        
        displayScreen.topToSuperview()
        displayScreen.leadingToSuperview()
        displayScreen.height(viewHeight * 30)
        displayScreen.widthToSuperview()
        
        // COL 1
        
        view.viewWithTag(1)!.leadingToSuperview(offset: viewWidth * 4)
        view.viewWithTag(1)!.topToBottom(of: displayScreen, offset: viewHeight * 2.5)
        view.viewWithTag(1)!.backgroundColor = #colorLiteral(red: 0.9821309447, green: 0.4039210081, blue: 0.36013937, alpha: 1)
        
        view.viewWithTag(2)!.leadingToTrailing(of: view.viewWithTag(1)!, offset: viewWidth * 4)
        view.viewWithTag(2)!.topToBottom(of: displayScreen, offset: viewHeight * 2.5)
        view.viewWithTag(2)!.backgroundColor = #colorLiteral(red: 0.9821309447, green: 0.4039210081, blue: 0.36013937, alpha: 1)
        
        view.viewWithTag(3)!.leadingToTrailing(of: view.viewWithTag(2)!, offset: viewWidth * 4)
        view.viewWithTag(3)!.topToBottom(of: displayScreen, offset: viewHeight * 2.5)
        view.viewWithTag(3)!.backgroundColor = #colorLiteral(red: 0.9821309447, green: 0.4039210081, blue: 0.36013937, alpha: 1)
        
        view.viewWithTag(4)!.leadingToTrailing(of: view.viewWithTag(3)!, offset: viewWidth * 4)
        view.viewWithTag(4)!.topToBottom(of: displayScreen, offset: viewHeight * 2.5)
        view.viewWithTag(4)!.backgroundColor = #colorLiteral(red: 0.992130816, green: 0.6051428914, blue: 0.3372822106, alpha: 1)
        
        // COL 2
        
        view.viewWithTag(5)!.leadingToSuperview(offset: viewWidth * 4)
        view.viewWithTag(5)!.topToBottom(of: view.viewWithTag(1)!, offset: viewHeight * 2.5)
        view.viewWithTag(5)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(6)!.leadingToTrailing(of: view.viewWithTag(5)!, offset: viewWidth * 4)
        view.viewWithTag(6)!.topToBottom(of: view.viewWithTag(2)!, offset: viewHeight * 2.5)
        view.viewWithTag(6)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(7)!.leadingToTrailing(of: view.viewWithTag(6)!, offset: viewWidth * 4)
        view.viewWithTag(7)!.topToBottom(of: view.viewWithTag(3)!, offset: viewHeight * 2.5)
        view.viewWithTag(7)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(8)!.leadingToTrailing(of: view.viewWithTag(7)!, offset: viewWidth * 4)
        view.viewWithTag(8)!.topToBottom(of: view.viewWithTag(4)!, offset: viewHeight * 2.5)
        view.viewWithTag(8)!.backgroundColor = #colorLiteral(red: 0.992130816, green: 0.6051428914, blue: 0.3372822106, alpha: 1)
        
        // COL 3
        
        view.viewWithTag(9)!.leadingToSuperview(offset: viewWidth * 4)
        view.viewWithTag(9)!.topToBottom(of: view.viewWithTag(5)!, offset: viewHeight * 2.5)
        view.viewWithTag(9)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(10)!.leadingToTrailing(of: view.viewWithTag(9)!, offset: viewWidth * 4)
        view.viewWithTag(10)!.topToBottom(of: view.viewWithTag(6)!, offset: viewHeight * 2.5)
        view.viewWithTag(10)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(11)!.leadingToTrailing(of: view.viewWithTag(10)!, offset: viewWidth * 4)
        view.viewWithTag(11)!.topToBottom(of: view.viewWithTag(7)!, offset: viewHeight * 2.5)
        view.viewWithTag(11)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(12)!.leadingToTrailing(of: view.viewWithTag(11)!, offset: viewWidth * 4)
        view.viewWithTag(12)!.topToBottom(of: view.viewWithTag(8)!, offset: viewHeight * 2.5)
        view.viewWithTag(12)!.backgroundColor = #colorLiteral(red: 0.992130816, green: 0.6051428914, blue: 0.3372822106, alpha: 1)
        
        // COL 4
        
        view.viewWithTag(13)!.leadingToSuperview(offset: viewWidth * 4)
        view.viewWithTag(13)!.topToBottom(of: view.viewWithTag(9)!, offset: viewHeight * 2.5)
        view.viewWithTag(13)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(14)!.leadingToTrailing(of: view.viewWithTag(13)!, offset: viewWidth * 4)
        view.viewWithTag(14)!.topToBottom(of: view.viewWithTag(10)!, offset: viewHeight * 2.5)
        view.viewWithTag(14)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(15)!.leadingToTrailing(of: view.viewWithTag(14)!, offset: viewWidth * 4)
        view.viewWithTag(15)!.topToBottom(of: view.viewWithTag(11)!, offset: viewHeight * 2.5)
        view.viewWithTag(15)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(16)!.leadingToTrailing(of: view.viewWithTag(15)!, offset: viewWidth * 4)
        view.viewWithTag(16)!.topToBottom(of: view.viewWithTag(12)!, offset: viewHeight * 2.5)
        view.viewWithTag(16)!.backgroundColor = #colorLiteral(red: 0.992130816, green: 0.6051428914, blue: 0.3372822106, alpha: 1)
        
        // COL 5
        
        view.viewWithTag(17)!.leadingToSuperview(offset: viewWidth * 4)
        view.viewWithTag(17)!.topToBottom(of: view.viewWithTag(13)!, offset: viewHeight * 2.5)
        view.viewWithTag(17)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(18)!.leadingToTrailing(of: view.viewWithTag(17)!, offset: viewWidth * 4)
        view.viewWithTag(18)!.topToBottom(of: view.viewWithTag(14)!, offset: viewHeight * 2.5)
        view.viewWithTag(18)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(19)!.leadingToTrailing(of: view.viewWithTag(18)!, offset: viewWidth * 4)
        view.viewWithTag(19)!.topToBottom(of: view.viewWithTag(15)!, offset: viewHeight * 2.5)
        view.viewWithTag(19)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(20)!.leadingToTrailing(of: view.viewWithTag(19)!, offset: viewWidth * 4)
        view.viewWithTag(20)!.topToBottom(of: view.viewWithTag(16)!, offset: viewHeight * 2.5)
        view.viewWithTag(20)!.backgroundColor = #colorLiteral(red: 0.992130816, green: 0.6051428914, blue: 0.3372822106, alpha: 1)
    }
    
    @objc func handleClick(_ sender: AnyObject?) {
        let calcBtns = ["C", "", "", "÷", "7", "8", "9", "X", "4", "5", "6", "-", "1", "2", "3", "+", "0", "", ".", "="]
        
        let idx = Int(sender?.tag?.description ?? "-1")
        
        displayScreen.text = calcBtns[idx! - 1]
    }
}
