//
//  CreateProfileViewController.swift
//  photoapp
//
//  Created by Irish on 8/27/21.
//

import UIKit
import FirebaseAuth

class CreateProfileViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func confirmTapped(_ sender: UIButton) {
        
        let currentUser = Auth.auth().currentUser
        
        // Check if there's a current user
        guard currentUser != nil else {
            return
        }
        
        // Get the username, and validate the text
        let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if username == nil || username == "" {
            
            // TODO: Inform user of invalid input
            return
        }
        
        // Create profile
        UserService.createProfile(userId: currentUser!.uid, username: username!) { (user) in
            
            // Check if user was created successfully
            if user != nil {
                
                // Save the user to local storage
                LocalStorageService.saveUser(userId: user!.userId, username: user!.username)
                
                // Go to the tab bar controller
                let tabBarVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController)
                
                self.view.window?.rootViewController = tabBarVC
                self.view.window?.makeKeyAndVisible()
                
            } else {
                
                // If not, display error
                
            }
        }
        
        
    }
}
