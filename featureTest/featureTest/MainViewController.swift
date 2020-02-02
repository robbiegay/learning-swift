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
     -Segmented Text-
     -Text Field-
     -Slider-
     -Switch-
     
     Table View
     Table View Cell
     Scroll View
     
     Activity Indicator
     Progress View
     
     TinyConstraint Stack
     */
    
    let testLabel = UILabel()
    let testButton = UIButton()
    let testSeg = UISegmentedControl()
    let testTextField = UITextField()
    let testTextView = UITextView()
    let testSlider = UISlider()
    let testSwitch = UISwitch()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(testLabel)
        view.addSubview(testButton)
        view.addSubview(testSeg)
        view.addSubview(testTextField)
        view.addSubview(testTextView)
        view.addSubview(testSlider)
        view.addSubview(testSwitch)
        
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
        testLabel.height(100)
        testLabel.trailingToSuperview()
        
        testButton.setTitle("This is a UIButton", for: .normal)
        testButton.topToBottom(of: testLabel, offset: 50)
        testButton.leadingToSuperview(offset: 50)
        testButton.centerXToSuperview()
        testButton.layer.borderWidth = 3
        testButton.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        testButton.layer.cornerRadius = 10
        testButton.layer.masksToBounds = true
        testButton.addTarget(self, action: #selector(handleButtonClick), for: .touchUpInside)
        testButton.backgroundColor = #colorLiteral(red: 0.8044971824, green: 0.2484204769, blue: 0.2948410213, alpha: 1)
        
        testSeg.backgroundColor = #colorLiteral(red: 0.8044971824, green: 0.2484204769, blue: 0.2948410213, alpha: 1)
        testSeg.leadingToSuperview(offset: 50)
        testSeg.topToBottom(of: testButton, offset: 50)
        testSeg.centerXToSuperview()
        testSeg.insertSegment(withTitle: "Red", at: 0, animated: true)
        testSeg.insertSegment(withTitle: "Green", at: 1, animated: true)
        testSeg.insertSegment(withTitle: "Blue", at: 2, animated: true)
        testSeg.addTarget(self, action: #selector(handleSegClick), for: .valueChanged)
        
        testTextField.leadingToSuperview(offset: 50)
        testTextField.topToBottom(of: testSeg, offset: 50)
        testTextField.centerXToSuperview()
//        testTextField.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        testTextField.height(35)
        testTextField.layer.borderWidth = 3
        testTextField.layer.cornerRadius = 10
        testTextField.layer.masksToBounds = true
        testTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        testTextField.placeholder = "Tell me a story..."
        testTextField.addTarget(self, action: #selector(handleTextChange), for: .allEvents)
        
        testTextView.leadingToSuperview(offset: 50)
        testTextView.topToBottom(of: testTextField, offset: 50)
        testTextView.centerXToSuperview()
        testTextView.layer.borderWidth = 3
        testTextView.layer.cornerRadius = 10
        testTextView.layer.masksToBounds = true
        testTextView.height(75)
        testTextView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        testSlider.leadingToSuperview(offset:50)
        testSlider.topToBottom(of: testTextView, offset: 50)
        testSlider.centerXToSuperview()
        testSlider.isContinuous = true
        testSlider.setValue(0.5, animated: true)
        testSlider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        
        testSwitch.leadingToSuperview(offset: 50)
        testSwitch.topToBottom(of: testSlider, offset: 50)
        testSwitch.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
    }
    
    @objc func handleButtonClick() {
        view.backgroundColor = view.backgroundColor == #colorLiteral(red: 0.8044971824, green: 0.2484204769, blue: 0.2948410213, alpha: 1) ? #colorLiteral(red: 0.9499809146, green: 0.4625762105, blue: 0.1792234778, alpha: 1) : #colorLiteral(red: 0.8044971824, green: 0.2484204769, blue: 0.2948410213, alpha: 1)
        testButton.backgroundColor = view.backgroundColor == #colorLiteral(red: 0.9499809146, green: 0.4625762105, blue: 0.1792234778, alpha: 1) ? #colorLiteral(red: 0.8044971824, green: 0.2484204769, blue: 0.2948410213, alpha: 1) : #colorLiteral(red: 0.9499809146, green: 0.4625762105, blue: 0.1792234778, alpha: 1)
    }
    
    @objc func handleSegClick() {
        let selected = testSeg.selectedSegmentIndex
        view.backgroundColor = selected == 0 ? #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1) : selected == 1 ? #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) : #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }
    
    @objc func handleTextChange() {
        testTextView.text = testTextField.text!
    }
    
    @objc func handleSliderChange() {
        let value = testSlider.value
        view.backgroundColor = UIColor(displayP3Red: 200/255, green: CGFloat((255 * value)/255), blue: CGFloat((255 * value)/255), alpha: 1)
    }
    
    @objc func handleSwitch() {
        view.backgroundColor = testSwitch.isOn ? #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
    
}
