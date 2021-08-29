//
//  SettingsViewController.swift
//  photoapp
//
//  Created by Irish on 8/27/21.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    

    @IBAction func signOutTapped(_ sender: UIButton) {
        
        // Sign out with Firebase auth
        do {
            
            // Successfully signing out the user
            try Auth.auth().signOut()
            
            // Clear local storage
            LocalStorageService.clearUser()
            
            // Transition to nav view controller
            let loginNavVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginNavController)
            
            self.view.window?.rootViewController = loginNavVC
            self.view.window?.makeKeyAndVisible()
            
        }
        catch {
            
            // Coudn't sign out the user
        }
    }
}
