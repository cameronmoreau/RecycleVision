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
import Parse

class RecycleViewController: SwiftyCamViewController, SwiftyCamViewControllerDelegate {
   
    var captureButton: SwiftyRecordButton!
    var takenImage: UIImage!
    var takenLabel: String!
    
    func openPopup(title: String, body: String, showInfo: Bool) {
        
        let view: RecyclableDialogView = try! SwiftMessages.viewFromNib()
        view.configureDropShadow()
        view.cancelAction = { _ in SwiftMessages.hide() }
        view.moreInfoAction = {
            SwiftMessages.hide()
            self.gotoMoreInfo()
        }
        
        if !showInfo {
            view.moreInfoButton.isHidden = true
        }
        
        view.headerLabel.text = title
        view.descriptionLabel.text = body
        var config = SwiftMessages.defaultConfig
        config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        config.duration = .forever
        config.presentationStyle = .bottom
        config.dimMode = .gray(interactive: true)
        SwiftMessages.show(config: config, view: view)
    }
    
    @IBAction func unwindToRecycle(segue:UIStoryboardSegue) {
        
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
    
    func gotoMoreInfo() {
        self.performSegue(withIdentifier: "MoreInfoSegue", sender: nil)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        self.captureButton.setLoading(loading: true)
        
        let resizedPhoto = self.resizeImage(image: photo, targetSize: CGSize(width: 500, height: 500))
        let imageData = UIImagePNGRepresentation(resizedPhoto)
        let imageFile = PFFile(name: "\(Date().timeIntervalSince1970).png", data: imageData!)
        
        // Save the file
        let userPhoto = PFObject(className:"Upload")
        userPhoto["user"] = PFUser.current()
        userPhoto["imageFile"] = imageFile
        userPhoto.saveInBackground { (saved, error) in
            
            if error == nil {
                if let file = userPhoto["imageFile"] as? PFFile {
                    PFCloud.callFunction(inBackground: "Classify", withParameters: ["id": userPhoto.objectId], block: { (data, error) in
                        
                        self.captureButton.setLoading(loading: false)
                        print(data)
                        
                        if let data = data as? [String:Any] {
                            let pass = data["isRecycleable"] as? Bool ?? false
                            let type = data["type"] as? String ?? ""
                            
                            self.takenLabel = type
                            self.takenImage = resizedPhoto
                            
                            var title: String!
                            var body: String!
                            
                            if pass {
                                title = "It's Recyclable!"
                                body = "+5 points for you! \(type) can be recycled"
                            } else {
                                title = "Nope!"
                                body = "This looks like \(type), which is not recycleable"
                            }
                            
                            self.openPopup(title: title, body: body, showInfo: pass)
                        }
                    })
                }
            }
        }

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MoreInfoSegue" {
            let vc = (segue.destination as! UINavigationController).topViewController as! CardViewController
            vc.takenLabel = self.takenLabel
            vc.takenImage = self.takenImage
        }
    }
}
