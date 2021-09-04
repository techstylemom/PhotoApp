//
//  PhotoService.swift
//  photoapp
//
//  Created by Irish on 9/1/21.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class PhotoService {
    
    static func retrievePhotos(completion: @escaping ([Photo]) -> Void) {
        
        // Get a database reference
        let db = Firestore.firestore()
        
        db.collection("photos").getDocuments { (snapshot, error) in
            
            // Check if there's an error
            if error != nil {
                
                // Error in retrieving photos
                return
            }
            
            // Get all the documents from the photos collection
            let documents = snapshot?.documents
            
            if let documents = documents {
                
                // Create an array to hold all of our Photo struct
                var photoArray = [Photo]()
                
                // Loop through each document and make it into photo struct
                for doc in documents {
                    
                    let p = Photo(snapshot: doc)
                    
                    if p != nil {
                        
                        // Store it in the array
                        photoArray.insert(p!, at: 0)
                    }
                }
                
                // Pass back the photo array
                completion(photoArray)
            }
        }
    }
    
    static func savePhoto(image: UIImage, progressUpdate: @escaping (Double) -> Void) {
        
        // Check that there is a current user
        guard Auth.auth().currentUser != nil else {
            return
        }
        
        // Create a data representation of the image
        let photoData = image.jpegData(compressionQuality: 0.1)
        
        // Check that the photo data is not nil
        guard photoData != nil else {
            return
        }
        
        // Get the userId of the uploader
        let userId = Auth.auth().currentUser!.uid
        
        // Create a filename
        let filename = UUID().uuidString
        
        // Get a reference to the firebase storage
        let ref = Storage.storage().reference().child("images/\(userId)/\(filename).jpg")
        
        // Upload the data
        let uploadTask = ref.putData(photoData!, metadata: nil) { (metadata, error) in
            
            // Check if the upload was successful
            if error == nil {
                
                // Upon successful upload, create a database entry
                self.createDatabaseEntry(ref: ref)
            }
        }
        
        uploadTask.observe(.progress) { (taskSnapshot) in
            
            let pct = Double(taskSnapshot.progress!.completedUnitCount) / Double(taskSnapshot.progress!.totalUnitCount)
           
            progressUpdate(pct)
        }
    }
    
    private static func createDatabaseEntry(ref: StorageReference) {
        
        // Download the image url
        ref.downloadURL { (url, error) in
            
            if error == nil {
                
                // Get the full path as the photo Id
                let photoId = ref.fullPath
                
                // Get the user id and username
                let photoUser = LocalStorageService.loadUser()
                let userId = photoUser?.userId
                let username = photoUser?.username
                
                // Get the date
                let df = DateFormatter()
                df.dateStyle = .full
                
                let dateString = df.string(from: Date())
                
                // Create a dictionary of the photo metadata
                let metadata = ["photoId": photoId, "byId": userId!, "byUsername": username!, "date": dateString, "url": url!.absoluteString]
                
                // Save the metadata to the firestore database
                let db = Firestore.firestore()
                
                db.collection("photos").addDocument(data: metadata) { (error) in
                    
                    // Check if the saving is of data was successful
                    if error == nil {
                        
                        // Successfully created database entry
                    }
                }
            }
        }
    }
}
