//
//  LoginViewController.swift
//  AntMediaReferenceApplication
//
//  Created by Cem Arpasatan on 2.04.2021.
//  Copyright © 2021 F2F. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginTapped(_ sender: UIButton) {
        
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            return
        }
        
        authUI?.delegate = self
        
        let authViewController = authUI!.authViewController()

        present(authViewController, animated: true, completion: nil)
        
        
    }
    
}

extension LoginViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        
        if error != nil{
            return
        }
        
       // authDataResult?.user.uid
        
        performSegue(withIdentifier: "loginSuccess", sender: self)
    }
    
    
}
