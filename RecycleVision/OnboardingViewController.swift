//
//  OnboardingViewController.swift
//  RecycleVision
//
//  Created by Cameron Moreau on 4/22/17.
//  Copyright © 2017 Mobi. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import ParseFacebookUtilsV4

class OnboardingViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        PFFacebookUtils.logInInBackground(withReadPermissions: ["email", "public_profile"]) { (user, error) in
            
            if let error = error {
                print("There was an error")
                print(error)
            }
            
            if let user = user {
                print("WE got the user")
                print(user)
            }
        }
    }
    
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookLoginButton.readPermissions = ["email", "public_profile"]
        facebookLoginButton.delegate = self
    }
    
    // MARK: - Facebook
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error?) {
        print("LOGGEDIN")
        print(FBSDKAccessToken.current())
        print(result)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //try? FIRAuth.auth()?.signOut()
        print("login")
    }
}

