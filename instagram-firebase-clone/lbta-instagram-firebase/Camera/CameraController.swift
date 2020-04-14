//
//  CameraController.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 4/13/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UIViewController {
    
    let captureButton: UIButton = {
        let  button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "capture_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCapturePhoto), for: .touchUpInside)
        return button
    }()
    
    let dismissButton: UIButton = {
        let  button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "arrow.right").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupHUD()
    }
    
    fileprivate func setupHUD() {
        view.addSubview(captureButton)
        captureButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 24, paddingRight: 0, width: 80, height: 80)
        captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 50, height: 50)
    }
    
    @objc func handleCapturePhoto() {
        print("Capturing photo...")
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        
        // 1. Setup Inputs
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
        } catch let err {
            print("Could not setup camera input:",err)
        }
        
        // 2. Setup Outputs
        let output = AVCapturePhotoOutput()
        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
        }
        
        // 3. Setup Output Preview
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        
        // Shows us the camera preview
        view.layer.addSublayer(previewLayer)
        
        // Start the session
        captureSession.startRunning()
    }
}