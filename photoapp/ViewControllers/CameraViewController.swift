//
//  CameraViewController.swift
//  photoapp
//
//  Created by Irish on 8/27/21.
//

import UIKit

class CameraViewController: UIViewController {
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Hide and reset all element
        progressBar.alpha = 0
        progressBar.progress = 0
        doneButton.alpha = 0
        progressLabel.alpha = 0
    }
    
    
    @IBAction func doneTapped(_ sender: UIButton) {
        
        // Get a reference to the tab bar controller
        let tabBarVC = self.tabBarController as? MainTabBarController
        
        if let tabBarVC = tabBarVC {
            
            // Call goToFeed
            tabBarVC.goToFeed()
        }
    }
    
    func savePhoto(image: UIImage) {
        
        PhotoService.savePhoto(image: image) { (pct) in
            
            DispatchQueue.main.async {
                
                // Update the progress bar
                self.progressBar.alpha = 1
                self.progressBar.progress = Float(pct)
                
                // Update the label
                let roundedPct = Int(pct * 100)
                self.progressLabel.text = "\(roundedPct)%"
                self.progressLabel.alpha = 1
                
                // Check if it's done
                if roundedPct == 100 {
                    self.doneButton.alpha = 1
                }
            }
        }
    }
}
