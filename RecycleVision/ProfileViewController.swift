//
//  ProfileViewController.swift
//  RecycleVision
//
//  Created by Paul Awadalla on 4/22/17.
//  Copyright © 2017 Mobi. All rights reserved.
//

import UIKit
import Parse
import FBSDKLoginKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        
        PFUser.logOutInBackground()
        FBSDKLoginManager().logOut()
        
        self.performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
    
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var realName: UILabel!
    
    
    @IBAction func editPicture(_ sender: Any) {
        // lets the user edit their profile pick
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
    
       
    }
    
    
//    @IBAction func saveButton(_ sender: Any) {
//        //lets the user the cha
//        //let myUser:PFUser = PFUser.current()!
//        
//       // let profilePicture = UIImageJPEGRepresentation(imageView.image!, 1)
//        
//        if((userName.text?.isEmpty)!){
//                let myAlert = UIAlertController(title: "Warning", message: "Please Provide input a username", preferredStyle: UIAlertControllerStyle.alert)
//            let okAction = UIAlertAction(title: "OK", style:UIAlertActionStyle.default, handler: nil)
//            myAlert.addAction(okAction)
//            self.present(myAlert, animated: true, completion: nil)
//            return
//        }
//        else{
//            let myAlerts = UIAlertController(title: "Success", message: "Your username has been saved", preferredStyle: UIAlertControllerStyle.alert)
//            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
//            myAlerts.addAction(action)
//            self.present(myAlerts, animated: true, completion: nil)
//            return
//        }
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let username = PFUser.current()?["firstName"] as? String
        realName.text = username
        // get the user's first, Email, and im
        //let userFirstName = PFUser.current()?.object(forKey: "First_Name") as! String
        
       // firstName.text = userFirstName
        
        
        
        
//        if(PFUser.current()?.object(forKey: "profile_picture"),!=nil)
//        {
//            let userImageFile:PFFile = PFUser.current()?.object(forKey: "profile_picture") as! PFFile
//            
//           userImageFile.s
//        
//        
//    }

  
        
        

}
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        //Hide Keyword
//        
//        textField.resignFirstResponder()
//        return true
//        
//    }
//    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: NSObject, _: AnyObject)
//    {
////        imageView.image = info [UIImagePickerControllerOriginalImage] as! UIImage
//        
//        self.dismiss(animated: true, completion: nil)
//    }

}
