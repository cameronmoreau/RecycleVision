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
import SwiftMessages
import PromiseKit

enum LoginError: Error {
    case FacebookError
    case ParseError
}

class OnboardingViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookLoginButton.readPermissions = ["email", "public_profile"]
        facebookLoginButton.delegate = self
    }
    
    func showErorrMessage() {
        let error = MessageView.viewFromNib(layout: .CardView)
        error.configureTheme(.error)
        error.configureContent(title: "Uh oh", body: "There was an error registering!")
        error.button?.isHidden = true

        SwiftMessages.show(view: error)
    }
    
    // MARK: - FacebookLogin
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error?) {
        
        // Login to
        if FBSDKAccessToken.current() != nil {
            runLoginActions()
        }
        
        // Failed to login
        else {
            showErorrMessage()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //try? FIRAuth.auth()?.signOut()
        print("login")
        PFUser.logOutInBackground()
    }
    
    // MARK: - Promise functions
    
    // Get all the facebook data
    func getFacebookData() -> Promise<[String:Any]> {
        return Promise { resolve, reject in
            
            let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"first_name,email, picture.type(large)"])
            req?.start(completionHandler: { (_, userData, error) in
                if let userData = userData {
                    resolve(userData as! [String : Any])
                }
                    
                else {
                    reject(LoginError.FacebookError)
                }
            })
            
        }
    }
    
    // Given access token, create the account
    func registerUserWithToken(token: FBSDKAccessToken) -> Promise<PFUser> {
        return Promise { resolve, reject in
            
            PFFacebookUtils.logInInBackground(with: token, block: { (user, error) in
                if let user = user {
                    resolve(user)
                }
                    
                else {
                    reject(LoginError.ParseError)
                }
            })
            
        }
    }
    
    // Given fb data, update their profile
    func updateUserWithData(user: PFUser) -> Promise<Bool> {
        return Promise { resolve, reject in
            
            user.saveInBackground(block: { (saved, error) in
                if error != nil {
                    reject(LoginError.ParseError)
                }
                
                else {
                    resolve(true)
                }
            })
            
        }
    }
    
    // MARK: - Login
    func runLoginActions() {
        print("running login")
        let token = FBSDKAccessToken.current()!
        var fbData: [String:Any]!
        
        getFacebookData()
            .then { data -> Promise<PFUser> in
                fbData = data
                return self.registerUserWithToken(token: token)
            }.then { user -> Promise<Bool> in
                let u = PFUser.current()!
                
                // Update all the data
                if let email = fbData["email"] {
                    u.setValue(email, forKey: "email")
                }
                
                if let firstName = fbData["first_name"] {
                    u.setValue(firstName, forKey: "firstName")
                }
                
                if let picture = fbData["picture"] as? [String:Any] {
                    if let data = picture["data"] as? [String:Any] {
                        if let imageUrl = data["url"] {
                            u.setValue(imageUrl, forKey: "imageUrl")
                        }
                    }
                }
                
                // Actually save now
                return self.updateUserWithData(user: u)
            }.then { _ in
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }.catch { _ in
                self.showErorrMessage()
            }
    }
}

