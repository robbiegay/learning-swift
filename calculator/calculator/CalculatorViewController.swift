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
    var equalTemp = ""
    var eqPress = false
    
    let displayPadding = UILabel()
    let displayScreen = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(displayPadding)
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
            // Adds the Easter Egg button click event
            if tagNum == 18 {
                button.addTarget(self, action: #selector(handleEasterEgg), for: .touchUpInside)
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
        displayScreen.width(viewWidth * 95)
        
        displayPadding.backgroundColor = #colorLiteral(red: 0.5557582974, green: 0.6102099419, blue: 0.468695879, alpha: 1)
        displayPadding.topToSuperview()
        displayPadding.leadingToTrailing(of: displayScreen)
        displayPadding.height(viewHeight * 30)
        displayPadding.widthToSuperview()
        
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
        let viewHeight = self.view.frame.height / 100
        let calcBtns = ["C", "", "", "÷", "7", "8", "9", "X", "4", "5", "6", "-", "1", "2", "3", "+", "0", "", ".", "="]
        
        let idx = Int(sender?.tag?.description ?? "-1")
        let keyVal = calcBtns[idx! - 1]
        
        if (keyVal == "C" || keyVal == "÷" || keyVal == "X" || keyVal == "-" || keyVal == "+" || keyVal == "=" || keyVal == ".") {
            symPress(keyVal)
        } else {
            numPress(keyVal)
        }
        // If NaN (for example, from 0/0) clears the calc and displays a message)
        if (displayScreen.text == "nan") {
            clear()
            displayScreen.text = "-Undefined-"
        }
        
        // Adjust the font size
        if displayScreen.text!.count < 5 {
            displayScreen.font = UIFont(name: "Futura-Medium", size: viewHeight * 15)
        } else if displayScreen.text!.count < 8 {
            displayScreen.font = UIFont(name: "Futura-Medium", size: viewHeight * 10)
        } else if displayScreen.text!.count < 12 {
            displayScreen.font = UIFont(name: "Futura-Medium", size: viewHeight * 7)
        } else if displayScreen.text!.count < 15 {
            displayScreen.font = UIFont(name: "Futura-Medium", size: viewHeight * 5)
        } else if displayScreen.text!.count < 20 {
            displayScreen.font = UIFont(name: "Futura-Medium", size: viewHeight * 4)
        } else {
            displayScreen.font = UIFont(name: "Futura-Medium", size: viewHeight * 3)
        }
        
        // Display Easter Egg Button
        if displayScreen.text == "32193" {
            view.viewWithTag(18)!.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        } else {
            view.viewWithTag(18)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        }
        
        // Debugging Logs:
        print("Equation: \(num1)  \(operand) \(num2)")
        print("Equal temp num: \(equalTemp) eqPress: \(eqPress)")
        print("---------------")
    }
    
    // If a number is pressed
    func numPress(_ inputNum: String) {
        // Resets the equal temp number on any number press
        equalTemp = ""
        // If equal was just pressed, followed by a number, clears the calc
        if eqPress {
            clear()
        }
        // Sets num1
        if operand == "" {
            // Makes it so you can"t enter 00000
            if inputNum == "0" && num1 == "0" {
                num1 = ""
                // Caps the input length at 10 digits
            } else if num1.count < 10 {
                if num1 == "0" {
                    num1 = ""
                }
                num1 += inputNum
                displayScreen.text = num1
            }
            // Sets num2
        } else {
            if inputNum == "0" && num2 == "0" {
                num2 = ""
            } else if num2.count < 10 {
                if num2 == "0" {
                    num2 = ""
                }
                num2 += inputNum
                displayScreen.text = num2
            }
        }
    }
    
    // If a symbol is pressed
    func symPress(_ inputSym: String) {
        // If the sym is not =, then reset the equal values
        if inputSym != "=" {
            equalTemp = ""
            eqPress = false
        }
        // Switch cases for various symbols
        switch inputSym {
        case "+":
            // Only allows you to input operands if num1 has already been defined
            // Otherwise, you can press an operand, and then a num, which can cause weird results
            if num1 != "" {
                // If num2 isn"t defined yet, set the operand and do nothing else
                if num2 == "" {
                    displayScreen.text = "+"
                    operand = "+"
                    // If it has been defined, calculate the last 2 numbers, display that result,
                    // place the result in num1, and clear num2
                } else {
                    multiCalc(operand)
                    displayScreen.text = num1
                    operand = "+"
                }
            }
        case "-":
            if num1 != "" {
                if num2 == "" {
                    displayScreen.text = "-"
                    operand = "-"
                } else {
                    multiCalc(operand)
                    displayScreen.text = num1
                    operand = "-"
                }
            }
        case "÷":
            if (num1 != "") {
                if (num2 == "") {
                    displayScreen.text = "÷"
                    operand = "÷"
                } else {
                    multiCalc(operand)
                    displayScreen.text = num1
                    operand = "÷"
                }
            }
        case "X":
            if (num1 != "") {
                if (num2 == "") {
                    displayScreen.text = "X"
                    operand = "X"
                } else {
                    multiCalc(operand)
                    displayScreen.text = num1
                    operand = "X"
                }
            }
        case "=":
            // If either input is "." --> display "Illegal use of decimal"
            if (num1 == "." || num2 == ".") {
                clear()
                displayScreen.text = "-Invalid Use of Decimal-"
            }
            // Records a boolean for if = was the last sym pressed
            eqPress = true
            // If neither num1 nor num2 have been defined yet, do nothing
            if (num1 == "" && num2 == "") {
                // If num2 is undefined, calculate using num1 [operand] num1
            } else if (num2 == "") {
                displayScreen.text = equalCalc(operand)
                // If num2 has been defined, record num2 in the equal sign"s temp num holder, then calculate
            } else {
                equalTemp = num2
                displayScreen.text = mathCalc(operand)
            }
        case ".":
            // If operand is undefined, then apply decimal to num1
            if (operand == "") {
                // Check to make sure num1 doesn"t already have a decimal
                if !num1.contains(".") {
                    num1 += "."
                    displayScreen.text = num1
                }
            } else {
                if !num2.contains(".") {
                    num2 += "."
                    displayScreen.text = num2
                }
            }
        // Clears the calc and all its variables if btn C is pressed
        case "C":
            clear()
        default:
            print("Default case triggered in symPress()")
            
        }
    }
    
    // Normal calculations --> [] + [] =
    func mathCalc(_ sym: String) -> String {
        switch sym {
        case "+":
            // Calculates num1 [operand] num2, stores that value
            // in num1 and displays it, clears num2 for use in future calculations
            num1 = String(Double(num1)! + Double(num2)!)
            num2 = ""
        case "-":
            num1 = String(Double(num1)! - Double(num2)!)
            num2 = ""
        case "÷":
            num1 = String(Double(num1)! / Double(num2)!)
            num2 = ""
        case "X":
            num1 = String(Double(num1)! * Double(num2)!)
            num2 = ""
        default:
            print("Default case triggered in mathCalc()")
        }
        return num1
    }
    
    // [] + [] + []... =
    func multiCalc(_ sym: String) {
        switch sym {
        case "+":
            num1 = String(Double(num1)! + Double(num2)!)
            num2 = ""
        case "-":
            num1 = String(Double(num1)! - Double(num2)!)
            num2 = ""
        case "÷":
            num1 = String(Double(num1)! / Double(num2)!)
            num2 = ""
        case "X":
            num1 = String(Double(num1)! * Double(num2)!)
            num2 = ""
        default:
            print("Default case triggered in multiCalc()")
        }
    }
    
    // For when equal sign is pressed multiple times --> [] + = = = OR [] + [] = = =
    func equalCalc(_ sym: String) -> String {
        switch sym {
        case "+":
            // If equal"s temp num has not been defined yet, define it
            // Otherwise, keep performing calculations using the old value
            if (equalTemp == "") {
                equalTemp = num1
            }
            num1 = String(Double(num1)! + Double(equalTemp)!)
            num2 = ""
        case "-":
            if (equalTemp == "") {
                equalTemp = num1
            }
            num1 = String(Double(num1)! - Double(equalTemp)!)
            num2 = ""
        case "÷":
            if (equalTemp == "") {
                equalTemp = num1
            }
            num1 = String(Double(num1)! / Double(equalTemp)!)
            num2 = ""
        case "X":
            if (equalTemp == "") {
                equalTemp = num1
            }
            num1 = String(Double(num1)! * Double(equalTemp)!)
            num2 = ""
        default:
            print("Default case triggered in equalCalc()")
        }
        return num1
    }
    
    // Resets all of the calculator"s values to their default state
    func clear() {
        num1 = ""
        num2 = ""
        operand = ""
        displayScreen.text = "0"
        equalTemp = ""
        eqPress = false
    }
    
    // -------- Easter Egg Logic --------
    
    var easterEgg = false
    var displayColorTimer: Timer?
    var textColorTimer: Timer?
    var redColor = 0.0
    var greenColor = 0.3
    var blueColor = 0.6
    var redForward = true
    var greenForward = true
    var blueForward = true
    var textColor = false
    
    @objc func handleEasterEgg() {
        if displayScreen.text == "32193" && !easterEgg {
            easterEgg = true
            displayColorTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(rainbowColors), userInfo: nil, repeats: true)
            textColorTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(textColors), userInfo: nil, repeats: true)
        } else {
            displayScreen.backgroundColor = #colorLiteral(red: 0.5557582974, green: 0.6102099419, blue: 0.468695879, alpha: 1)
            displayPadding.backgroundColor = #colorLiteral(red: 0.5557582974, green: 0.6102099419, blue: 0.468695879, alpha: 1)
            displayScreen.textColor = #colorLiteral(red: 0.3411012292, green: 0.3455565274, blue: 0.3205627799, alpha: 1)
            easterEgg = false
            displayColorTimer?.invalidate()
            textColorTimer?.invalidate()
        }
    }
    
    @objc func rainbowColors() {
        if redColor < 0.9 && redForward {
            redColor += 0.05
        } else {
            redForward = redColor <= 0.1
            redColor -= 0.01
        }
        if greenColor < 0.9 && greenForward {
            greenColor += 0.01
        } else {
            greenForward = greenColor <= 0.1
            greenColor -= 0.05
        }
        if blueColor < 0.9 && blueForward {
            blueColor += 0.05
        } else {
            blueForward = blueColor <= 0.1
            blueColor -= 0.05
        }
        displayScreen.backgroundColor = UIColor(displayP3Red: CGFloat(redColor), green: CGFloat(greenColor), blue: CGFloat(blueColor), alpha: 1.0)
        displayPadding.backgroundColor = UIColor(displayP3Red: CGFloat(redColor), green: CGFloat(greenColor), blue: CGFloat(blueColor), alpha: 1.0)
    }
    
    @objc func textColors() {
        if textColor {
            displayScreen.textColor = .black
        } else {
            displayScreen.textColor = .white
        }
        textColor = !textColor
    }
    
    // Prevents a "strong reference cycle"
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        displayColorTimer?.invalidate()
        textColorTimer?.invalidate()
    }
    
    
    // ATTEMPT AT REMOVING DECIMAL
    //    func removeDecimal(_ val: String) -> String {
    //        var output = val
    //        // Checks to see if there are any numbers after the decimal
    //        if val.contains(".") {
    //            // Adds the display text to an Array
    //            var displayTextArray = [Character]()
    //            for char in displayScreen.text! {
    //                displayTextArray.append(char)
    //            }
    //            let i = displayTextArray.firstIndex(of: ".")! + 1
    //            if (
    //                displayTextArray[i...].contains("1") ||
    //                displayTextArray[i...].contains("2") ||
    //                displayTextArray[i...].contains("3") ||
    //                displayTextArray[i...].contains("4") ||
    //                displayTextArray[i...].contains("5") ||
    //                displayTextArray[i...].contains("6") ||
    //                displayTextArray[i...].contains("7") ||
    //                displayTextArray[i...].contains("8") ||
    //                displayTextArray[i...].contains("9")
    //                ) {
    //                print("Contains some numbers")
    //                displayTextArray.removeSubrange((i - 1)...)
    //                output = ""
    //                for char in displayTextArray {
    //                    output += String(char)
    //                }
    //                print("The new string ->",output)
    //            }
    //        }
    //        return output
    //    }
}

/*
 Things to fix:
 - Calulations result in decimal values even when 4.0
 - Get app loaded on my phone
 */
