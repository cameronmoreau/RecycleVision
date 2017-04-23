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
import Parse

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
        
        // Transparent navbar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        navigationController?.navigationBar.barStyle = .black
        
        // Setup camera
        cameraDelegate = self
        
        captureButton = SwiftyRecordButton(frame: CGRect(x: view.frame.midX - 37.5, y: view.frame.height - 150.0, width: 75.0, height: 75.0))
        captureButton.delegate = self
        self.view.addSubview(captureButton)
        
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        let resizedPhoto = self.resizeImage(image: photo, targetSize: CGSize(width: 500, height: 500))
        let imageData = UIImagePNGRepresentation(resizedPhoto)
        let imageFile = PFFile(name: "\(Date().timeIntervalSince1970).png", data: imageData!)
        
        print("TRYING TO SAVE")
        let userPhoto = PFObject(className:"TestPhoto")
        userPhoto["imageName"] = "My trip to Hawaii!"
        userPhoto["imageFile"] = imageFile
        userPhoto.saveInBackground { (saved, error) in
            print("SAVING")
            print(saved)
            print(error)
        }
        
        captureButton.setLoading(loading: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.captureButton.setLoading(loading: false)
            RecycleViewController.demoCustomNib()
        })

    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
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
