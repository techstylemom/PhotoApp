//
//  LocalStorageService.swift
//  photoapp
//
//  Created by Irish on 8/29/21.
//

import Foundation

class LocalStorageService {
    
    static func saveUser(userId: String?, username:String?) {
        
        // Get reference to user defaults
        let defaults = UserDefaults.standard
        
        // Save the id and username
        defaults.set(userId, forKey: Constants.LocalStorage.userIdKey)
        defaults.set(username, forKey: Constants.LocalStorage.usernameKey)
    }
    
    static func loadUser() -> PhotoUser? {
        
        // Get a reference to user defaults
        let defaults = UserDefaults.standard
        
        // Get the username and id
        let userId = defaults.value(forKey: Constants.LocalStorage.userIdKey) as? String
        let username = defaults.value(forKey: Constants.LocalStorage.usernameKey) as? String
        
        // Check if the username and id are not nil
        if userId != nil && username != nil {
            
            // Return the user
            return PhotoUser(userId: userId!, username: username!)
            
        } else {
            
            // No saved user
            print("No user saved")
            return nil
        }
    }
    
    static func clearUser() {
        
        // Get a reference to user defaults
        let defaults = UserDefaults.standard
        
        // Clear the values for the keys
        defaults.set(nil, forKey: Constants.LocalStorage.userIdKey)
        defaults.set(nil, forKey: Constants.LocalStorage.usernameKey)
    }
}
