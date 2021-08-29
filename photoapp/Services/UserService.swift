//
//  UserService.swift
//  photoapp
//
//  Created by Irish on 8/28/21.
//

import Foundation
import FirebaseFirestore

class UserService {
    
    static func createProfile(userId:String, username:String, completion: @escaping (PhotoUser?) -> Void) {
        
        // Create profile data
        let profileData = ["username": username]
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Save data to the database
        db.collection("users").document(userId).setData(profileData) { (error) in
            
            if error == nil {
                
                // Profile was successfully created
                
                // Return a photo user
                var u = PhotoUser()
                u.username = username
                u.userId = userId
                
                completion(u)
                
            } else {
                
                // An error occured
                
                // Return nil
                completion(nil)
            }
        }
    }
    
    static func retrieveProfile(userId:String, completion: @escaping (PhotoUser?) -> Void) {
        
        // Get a firestore reference
        let db = Firestore.firestore()
        
        // Check for a profile given the user id
        db.collection("users").document(userId).getDocument { (snapshot, error) in
            
            if error != nil || snapshot == nil {
                
                return
            }
            
            if let profile = snapshot!.data() {
               
                var u = PhotoUser()
                u.userId = snapshot!.documentID
                u.username = profile["username"] as? String
                
                // Return the user
                completion(u)
                
            } else {
                
                // Return nil
                completion(nil)
            }
        }
        
    }
}
