//
//  AppDelegate.swift
//  AntMediaReferenceApplication
//
//  Created by Oğulcan on 11.06.2018.
//  Copyright © 2018 AntMedia. All rights reserved.
//

import UIKit
import Firebase

public typealias SimpleClosure = (() -> ())

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        let filePath = Bundle.main.path(forResource: "MyGoogleService", ofType: "plist")
        guard let fileopts = FirebaseOptions(contentsOfFile: filePath!)
          else { assert(false, "Couldn't load config file") }
        FirebaseApp.configure(options: fileopts)

    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let filePath = Bundle.main.path(forResource: "MyGoogleService", ofType: "plist")
        guard let fileopts = FirebaseOptions(contentsOfFile: filePath!)
          else { assert(false, "Couldn't load config file") }
        FirebaseApp.configure(options: fileopts)
        return true
    }
}
