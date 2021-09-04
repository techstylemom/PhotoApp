//
//  MainTabBarController.swift
//  photoapp
//
//  Created by Irish on 8/30/21.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
 
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        // Detect which tab bar the user tapped on
        if item.tag == 2 {
            
            // The Photo Upload tab was tapped
            
            // Create the action sheet
            let actionSheet = UIAlertController(title: "Add a Photo", message: "Select a source", preferredStyle: .actionSheet)
            
            // Only add camera button if it's available
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                // Add the camera button
                let cameraButton = UIAlertAction(title: "Camera", style: .default) { (action) in
                    
                    // Display the UIImagePickerController set to camera mode
                    self.showImagePickerController(mode: .camera)
                }
                
                actionSheet.addAction(cameraButton)
            }
            
            // Only add photo libray button if it's available
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                // Add the photo library button
                let libraryButton = UIAlertAction(title: "Photo Library", style: .default) { (action) in
                    
                    // Display the UIImagePickerController set to libradey moe
                    self.showImagePickerController(mode: .photoLibrary)
                }
                
                actionSheet.addAction(libraryButton)
                
            }
            
            // Add the cancel button
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            actionSheet.addAction(cancelButton)
            
            // Display action sheet
            present(actionSheet, animated: true, completion: nil)
        }
  
    }
    
    func showImagePickerController(mode: UIImagePickerController.SourceType) {
        
        // Create the picker controller and set the mode
        var imagePicker = UIImagePickerController()
        imagePicker.sourceType = mode
        
        // Set the tab bar as the delegate
        imagePicker.delegate = self
        
        // Display the image picker controller
        present(imagePicker, animated: true, completion: nil)
    }
}

extension MainTabBarController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // Dismiss the image picker
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Get a reference to the selected image
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        // Check if the selected image is not nil
        if let selectedImage = selectedImage {
            
            // Get a reference to the camera controller vc
            let cameraVC = self.selectedViewController as? CameraViewController
            
            if let cameraVC = cameraVC {
                
                // Upload the photo
                cameraVC.savePhoto(image: selectedImage)
            }
        }
        
        // Dismiss the image picker
        dismiss(animated: true, completion: nil)
    }
    
    func goToFeed() {
        
        // Switch tab to the first one
        selectedIndex = 0
    }
}
