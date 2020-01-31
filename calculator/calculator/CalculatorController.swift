//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Robbie Gay on 1/29/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import TinyConstraints

class CalculatorViewController: UIViewController {
    
    var num1 = "0"
    var num2 = ""
    var operand = ""
    var equalTemp = ""
    var eqPress = false
    
    let calcBtns = ["C", "", "", "÷", "7", "8", "9", "X", "4", "5", "6", "-", "1", "2", "3", "+", "0", "", ".", "="]
    
    let displayPadding = UILabel()
    let displayScreen = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(displayPadding)
        view.addSubview(displayScreen)
        
        createButtons()
        styleSubviews()
    }
    
    func createButtons() {
        let buttonDimensions = (self.view.frame.width / 100) * 20
        
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
         Button section height = 70% of view
         
         Each button dimensions = 20% of width
         Each button has 4% horizonal and 2.5% vertical padding
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
        
        // Creates 5% padding to the left of the number
        displayPadding.backgroundColor = #colorLiteral(red: 0.5557582974, green: 0.6102099419, blue: 0.468695879, alpha: 1)
        displayPadding.topToSuperview()
        displayPadding.leadingToTrailing(of: displayScreen)
        displayPadding.height(viewHeight * 30)
        displayPadding.widthToSuperview()
        
        var idx = 1
        for _ in calcBtns {
            // Sets leading to Superview or the button left of it
            if idx == 1 || idx == 5 || idx == 9 || idx == 13 || idx == 17 {
                view.viewWithTag(idx)!.leadingToSuperview(offset: viewWidth * 4)
            } else {
                view.viewWithTag(idx)!.leadingToTrailing(of: view.viewWithTag(idx - 1)!, offset: viewWidth * 4)
            }
            // Sets top to displayScreen or the button above it
            if idx < 5 {
                view.viewWithTag(idx)!.topToBottom(of: displayScreen, offset: viewHeight * 2.5)
            } else {
                view.viewWithTag(idx)!.topToBottom(of: view.viewWithTag(idx - 4)!, offset: viewHeight * 2.5)
            }
            // Sets the button colors
            if idx < 4 {
                view.viewWithTag(idx)!.backgroundColor = #colorLiteral(red: 0.9821309447, green: 0.4039210081, blue: 0.36013937, alpha: 1)
            } else if idx % 4 == 0 {
                view.viewWithTag(idx)!.backgroundColor = #colorLiteral(red: 0.992130816, green: 0.6051428914, blue: 0.3372822106, alpha: 1)
            } else {
                view.viewWithTag(idx)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
            }
            // Increments the idx value
            idx += 1
        }
    }
    
    @objc func handleClick(_ sender: AnyObject?) {
        let viewHeight = self.view.frame.height / 100
        
        // Gets the tagNum of the button clicked
        let idx = Int(sender?.tag?.description ?? "-1")
        let keyVal = calcBtns[idx! - 1]
        
        if (keyVal == "C" || keyVal == "÷" || keyVal == "X" || keyVal == "-" || keyVal == "+" || keyVal == "=" || keyVal == ".") {
            symPress(keyVal)
        } else {
            numPress(keyVal)
        }
        // If nan (for example, from 0/0) clears the calc and displays a message)
        if (displayScreen.text == "nan") {
            clear()
            displayScreen.text = "-Undefined-"
        }
        
        // Adjust the font size for larger numbers
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
        
        // Displays Easter Egg Button
        if displayScreen.text == "32193" {
            view.viewWithTag(18)!.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        } else {
            view.viewWithTag(18)!.backgroundColor = #colorLiteral(red: 0.3576321006, green: 0.3255228996, blue: 0.3168733418, alpha: 1)
        }
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
                num1 = "0"
                // Caps the input length at 10 digits
            } else if num1.count < 10 {
                // Resets num1 to "" so that you don't get results like -> 03
                if num1 == "0" {
                    num1 = ""
                }
                num1 += inputNum
                displayScreen.text = num1
            }
            // Sets num2
        } else {
            if inputNum == "0" && num2 == "0" {
                num2 = "0"
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
                // If num2 isn"t defined yet, set the operand and do nothing else
                if num2 == "" {
                    displayScreen.text = "+"
                    operand = "+"
                    // If num2 has been defined, calculate the last 2 numbers and display that result,
                    // place the result in num1, and clear num2
                } else {
                    calculate(operand: operand, type: "multi")
                    displayScreen.text = num1
                    operand = "+"
                }
            case "-":
                if num2 == "" {
                    displayScreen.text = "-"
                    operand = "-"
                } else {
                    calculate(operand: operand, type: "multi")
                    displayScreen.text = num1
                    operand = "-"
                }
            case "÷":
                if (num2 == "") {
                    displayScreen.text = "÷"
                    operand = "÷"
                } else {
                    calculate(operand: operand, type: "multi")
                    displayScreen.text = num1
                    operand = "÷"
                }
            case "X":
                if (num2 == "") {
                    displayScreen.text = "X"
                    operand = "X"
                } else {
                    calculate(operand: operand, type: "multi")
                    displayScreen.text = num1
                    operand = "X"
                }
            case "=":
                // If either input is "." --> display "Illegal use of decimal"
                if (num1 == "." || num2 == ".") {
                    clear()
                    displayScreen.text = "-Invalid Use of Decimal-"
                }
                // Records a boolean noting if "=" was the last sym pressed
                eqPress = true
                // If neither num1 nor num2 have been defined yet, do nothing
                if (num1 == "" && num2 == "") {
                // If num2 is undefined, calculate using num1 [operand] num1
                } else if (num2 == "") {
                    displayScreen.text = calculate(operand: operand, type: "equal")
                // If num2 has been defined, record num2 in the equal sign's temp num holder, then calculate
                } else {
                    equalTemp = num2
                    displayScreen.text = calculate(operand: operand, type: "normal")
                }
            case ".":
                // If operand is undefined, then apply decimal to num1
                if (operand == "") {
                    // Check to make sure num1 doesn't already have a decimal
                    if !num1.contains(".") {
                        num1 += "."
                        displayScreen.text = num1
                    }
                // If operand has been defined, apply the decimal to num2
                } else {
                    if !num2.contains(".") {
                        num2 += "."
                        displayScreen.text = num2
                    }
                }
            // Clears the calc and all its variables if btn "C" is pressed
            case "C":
                clear()
            default:
                print("Default case triggered in symPress()")
        }
    }
    
    // "normal" calculations --> [] + [] =
    // "multi" calculations --> [] + [] + []... =
    // "equal" = For when equal sign is pressed multiple times --> [] + = = = OR [] + [] = = =
    func calculate(operand: String, type: String) -> String {
        var num2Temp = num2
        // If equalTemp's number has not been defined yet, define it
        // Otherwise, keep performing calculations using the old value
        if (equalTemp == "") {
            equalTemp = num1
        }
        // If type is "equal" -> use equalTemp as second calculation value
        if type == "equal" {
            num2Temp = equalTemp
        }
        switch operand {
            // Calculates: num1 [operand] num2
            // Stores the result in num1
            case "+":
                num1 = "\(Double(num1)! + Double(num2Temp)!)"
            case "-":
                num1 = "\(Double(num1)! - Double(num2Temp)!)"
            case "÷":
                num1 = "\(Double(num1)! / Double(num2Temp)!)"
            case "X":
                num1 = "\(Double(num1)! * Double(num2Temp)!)"
            default:
                print("Default case triggered during calculation")
        }
        // Clears num2 for use in future calculations, displays num1
        num2 = ""
        // Removes ".0" from return value
        if num1.hasSuffix(".0") {
            num1.removeLast(2)
        }
        if type == "normal" || type == "equal" {
            return num1
        }
        // For "multi" type calculations, return nothing
        return ""
    }
    
    // Resets all of the calculator"s values to their default state
    func clear() {
        num1 = "0"
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
        // If secret code is displaying and easter egg is NOT currently running, turn it ON
        if displayScreen.text == "32193" && !easterEgg {
            easterEgg = true
            // Starts the easter egg timers
            // Colors change every 50ms, text changes every 500ms
            displayColorTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(rainbowColors), userInfo: nil, repeats: true)
            textColorTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(textColors), userInfo: nil, repeats: true)
        // Else if secret code is displaying and easter egg is already running, turn it OFF
        } else if displayScreen.text == "32193" && easterEgg  {
            easterEgg = false
            displayScreen.backgroundColor = #colorLiteral(red: 0.5557582974, green: 0.6102099419, blue: 0.468695879, alpha: 1)
            displayPadding.backgroundColor = #colorLiteral(red: 0.5557582974, green: 0.6102099419, blue: 0.468695879, alpha: 1)
            displayScreen.textColor = #colorLiteral(red: 0.3411012292, green: 0.3455565274, blue: 0.3205627799, alpha: 1)
            // Invalidates the timers
            displayColorTimer?.invalidate()
            textColorTimer?.invalidate()
        }
    }
   
    // Changes the background colors
    @objc func rainbowColors() {
        // RED
        // Raises the color's number until 0.9
        if redColor < 0.9 && redForward {
            redColor += 0.09
        // The starts lowering the color's value until 0.1
        // These raising and lowering continue to cycle until the timer is stopped
        } else {
            redForward = redColor <= 0.1
            redColor -= 0.01
        }
        // GREEN
        if greenColor < 0.9 && greenForward {
            greenColor += 0.1
        } else {
            greenForward = greenColor <= 0.1
            greenColor -= 0.09
        }
        // BLUE
        if blueColor < 0.9 && blueForward {
            blueColor += 0.1
        } else {
            blueForward = blueColor <= 0.1
            blueColor -= 0.05
        }
        // Sets the display and padding to the color values calculated above
        displayScreen.backgroundColor = UIColor(displayP3Red: CGFloat(redColor), green: CGFloat(greenColor), blue: CGFloat(blueColor), alpha: 1.0)
        displayPadding.backgroundColor = UIColor(displayP3Red: CGFloat(redColor), green: CGFloat(greenColor), blue: CGFloat(blueColor), alpha: 1.0)
    }
    
    // Cycles the text between black or white
    @objc func textColors() {
        if textColor {
            displayScreen.textColor = .black
        } else {
            displayScreen.textColor = .white
        }
        // Once the text color has been changed, reverses the bool value
        textColor = !textColor
    }
    
    // Prevents a "strong reference cycle" by invalidating the times when the app is done
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        displayColorTimer?.invalidate()
        textColorTimer?.invalidate()
    }
}
