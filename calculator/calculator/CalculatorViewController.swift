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
        let viewHeight = self.view.frame.height / 100
        let viewWidth = self.view.frame.width / 100
        let buttonDimensions = viewWidth * 20
        
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
        view.viewWithTag(1)!.topToBottom(of: displayScreen, offset: viewHeight * 2)
        view.viewWithTag(1)!.backgroundColor = #colorLiteral(red: 0.9821309447, green: 0.4039210081, blue: 0.36013937, alpha: 1)
        
        view.viewWithTag(2)!.leading(to: view.viewWithTag(1)!, offset: viewWidth * 24)
        view.viewWithTag(2)!.topToBottom(of: displayScreen, offset: viewHeight * 2)
        view.viewWithTag(2)!.backgroundColor = #colorLiteral(red: 0.9821309447, green: 0.4039210081, blue: 0.36013937, alpha: 1)
        
        view.viewWithTag(3)!.leading(to: view.viewWithTag(2)!, offset: viewWidth * 24)
        view.viewWithTag(3)!.topToBottom(of: displayScreen, offset: viewHeight * 2)
        view.viewWithTag(3)!.backgroundColor = #colorLiteral(red: 0.9821309447, green: 0.4039210081, blue: 0.36013937, alpha: 1)
        
        view.viewWithTag(4)!.leading(to: view.viewWithTag(3)!, offset: viewWidth * 24)
        view.viewWithTag(4)!.topToBottom(of: displayScreen, offset: viewHeight * 2)
        view.viewWithTag(4)!.backgroundColor = #colorLiteral(red: 0.992130816, green: 0.6051428914, blue: 0.3372822106, alpha: 1)
        
        // COL 2
        
        view.viewWithTag(5)!.leadingToSuperview(offset: viewWidth * 4)
        view.viewWithTag(5)!.topToBottom(of: displayScreen, offset: viewHeight * 14)
        view.viewWithTag(5)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(6)!.leading(to: view.viewWithTag(5)!, offset: viewWidth * 24)
        view.viewWithTag(6)!.topToBottom(of: displayScreen, offset: viewHeight * 14)
        view.viewWithTag(6)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(7)!.leading(to: view.viewWithTag(6)!, offset: viewWidth * 24)
        view.viewWithTag(7)!.topToBottom(of: displayScreen, offset: viewHeight * 14)
        view.viewWithTag(7)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(8)!.leading(to: view.viewWithTag(7)!, offset: viewWidth * 24)
        view.viewWithTag(8)!.topToBottom(of: displayScreen, offset: viewHeight * 14)
        view.viewWithTag(8)!.backgroundColor = #colorLiteral(red: 0.992130816, green: 0.6051428914, blue: 0.3372822106, alpha: 1)
        
        // COL 3
        
        view.viewWithTag(9)!.leadingToSuperview(offset: viewWidth * 4)
        view.viewWithTag(9)!.topToBottom(of: displayScreen, offset: viewHeight * 24)
        view.viewWithTag(9)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(10)!.leading(to: view.viewWithTag(9)!, offset: viewWidth * 24)
        view.viewWithTag(10)!.topToBottom(of: displayScreen, offset: viewHeight * 24)
        view.viewWithTag(10)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(11)!.leading(to: view.viewWithTag(10)!, offset: viewWidth * 24)
        view.viewWithTag(11)!.topToBottom(of: displayScreen, offset: viewHeight * 24)
        view.viewWithTag(11)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(12)!.leading(to: view.viewWithTag(11)!, offset: viewWidth * 24)
        view.viewWithTag(12)!.topToBottom(of: displayScreen, offset: viewHeight * 24)
        view.viewWithTag(12)!.backgroundColor = #colorLiteral(red: 0.992130816, green: 0.6051428914, blue: 0.3372822106, alpha: 1)
        
        // COL 4
        
        view.viewWithTag(13)!.leadingToSuperview(offset: viewWidth * 4)
        view.viewWithTag(13)!.topToBottom(of: displayScreen, offset: viewHeight * 34)
        view.viewWithTag(13)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(14)!.leading(to: view.viewWithTag(13)!, offset: viewWidth * 24)
        view.viewWithTag(14)!.topToBottom(of: displayScreen, offset: viewHeight * 34)
        view.viewWithTag(14)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(15)!.leading(to: view.viewWithTag(14)!, offset: viewWidth * 24)
        view.viewWithTag(15)!.topToBottom(of: displayScreen, offset: viewHeight * 34)
        view.viewWithTag(15)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(16)!.leading(to: view.viewWithTag(15)!, offset: viewWidth * 24)
        view.viewWithTag(16)!.topToBottom(of: displayScreen, offset: viewHeight * 34)
        view.viewWithTag(16)!.backgroundColor = #colorLiteral(red: 0.992130816, green: 0.6051428914, blue: 0.3372822106, alpha: 1)
        
        // COL 5
        
        view.viewWithTag(17)!.leadingToSuperview(offset: viewWidth * 4)
        view.viewWithTag(17)!.topToBottom(of: displayScreen, offset: viewHeight * 44)
        view.viewWithTag(17)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(18)!.leading(to: view.viewWithTag(17)!, offset: viewWidth * 24)
        view.viewWithTag(18)!.topToBottom(of: displayScreen, offset: viewHeight * 44)
        view.viewWithTag(18)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        
        view.viewWithTag(19)!.leading(to: view.viewWithTag(18)!, offset: viewWidth * 24)
        view.viewWithTag(19)!.topToBottom(of: displayScreen, offset: viewHeight * 44)
        view.viewWithTag(19)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
    
        view.viewWithTag(20)!.leading(to: view.viewWithTag(19)!, offset: viewWidth * 24)
        view.viewWithTag(20)!.topToBottom(of: displayScreen, offset: viewHeight * 44)
        view.viewWithTag(20)!.backgroundColor = #colorLiteral(red: 0.992130816, green: 0.6051428914, blue: 0.3372822106, alpha: 1)
    }
    
    @objc func handleClick() {
        print("Clicked")
    }
}
