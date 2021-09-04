//
//  Constants.swift
//  photoapp
//
//  Created by Irish on 8/28/21.
//

import Foundation

struct Constants {
    
    struct Storyboard {
        static let profileSegue = "goToCreateProfile"
        static let tabBarController = "mainTabBarController"
        static let loginNavController = "loginNavController"
        
        static let photoCellId = "PhotoCell"
    }
    
    struct LocalStorage {
        static let userIdKey = "storeUserId"
        static let usernameKey = "storedUsername"
    }
}
