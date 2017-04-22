//
//  AppDelegate.swift
//  RecycleVision
//
//  Created by Cameron Moreau on 4/22/17.
//  Copyright © 2017 Mobi. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Init parse
        let configuration = ParseClientConfiguration {
            $0.applicationId = "app123"
            $0.server = "http://54.70.178.101:8080/parse"
        }
        Parse.initialize(with: configuration)
        
        PFFacebookUtils.initializeFacebook(applicationLaunchOptions: launchOptions)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

}

