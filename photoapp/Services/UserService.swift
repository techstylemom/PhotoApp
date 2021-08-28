//
//  UserService.swift
//  photoapp
//
//  Created by Irish on 8/28/21.
//

import Foundation
import FirebaseFirestore

class UserService {
    
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
                u.userId = profile["username"] as? String
                
                // Return the user
                completion(u)
                
            } else {
                
                // Return nil
                completion(nil)
            }
        }
        
    }
}
