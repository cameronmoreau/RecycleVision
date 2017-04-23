//
//  RecycleViewController.swift
//  RecycleVision
//
//  Created by Paul Awadalla on 4/22/17.
//  Copyright © 2017 Mobi. All rights reserved.
//

import UIKit
import SwiftyCam
import SwiftMessages
import AudioToolbox
import AVFoundation
class RecycleViewController: SwiftyCamViewController, SwiftyCamViewControllerDelegate {
   
    var captureButton: SwiftyRecordButton!
    
    static func demoCustomNib() {
        
        let view: RecyclableDialogView = try! SwiftMessages.viewFromNib()
        view.configureDropShadow()
        view.cancelAction = { _ in SwiftMessages.hide() }
        view.MoreInfoAction = { SwiftMessages.hide() }
        var config = SwiftMessages.defaultConfig
        config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        config.duration = .forever
        config.presentationStyle = .bottom
        config.dimMode = .gray(interactive: true)
        SwiftMessages.show(config: config, view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraDelegate = self
        
        captureButton = SwiftyRecordButton(frame: CGRect(x: view.frame.midX - 37.5, y: view.frame.height - 150.0, width: 75.0, height: 75.0))
        captureButton.delegate = self
        self.view.addSubview(captureButton)
        
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
       
        captureButton.growButton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            self.captureButton.shrinkButton()
        })
        
        // Temp delay of uno mo secondo
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            RecycleViewController.demoCustomNib()
        })
        
        
        print("IT TOOK THE PICTURE")
    }
    
    
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
        let focusView = UIImageView(image: #imageLiteral(resourceName: "focus"))
        
        focusView.center = point
        focusView.alpha = 0.0
        view.addSubview(focusView)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            focusView.alpha = 1.0
            focusView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }, completion: { (success) in
            UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations: {
                focusView.alpha = 0.0
                focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
            }, completion: { (success) in
                focusView.removeFromSuperview()
            })
        })
    }
}
