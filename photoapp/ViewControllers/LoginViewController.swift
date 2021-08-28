//
//  LoginViewController.swift
//  photoapp
//
//  Created by Irish on 8/27/21.
//

import UIKit
import FirebaseEmailAuthUI

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        // Create a Firebase AuthUI obj
        let authUI = FUIAuth.defaultAuthUI()
        
        // Check that is isn't nil
        if let authUI = authUI {
            
            // Set self as delegate for the AuthUI
            authUI.delegate = self
            
            // Set sign in providers
            authUI.providers = [FUIEmailAuth()]
            
            // Get the prebuilt UI view controller
            let authViewController = authUI.authViewController()
            
            // Present it
            present(authViewController, animated: true, completion: nil)
            
        }
    }
}

extension LoginViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        guard error != nil else {
            return
        }
        
        let user = authDataResult?.user
        
        if let user = user {
            
            // Got a user
            
            // Check on the database if user has a profile
            
            // If not, go to create profile vc
            
            // If so, go to tab bar controller
        }
    }
}
