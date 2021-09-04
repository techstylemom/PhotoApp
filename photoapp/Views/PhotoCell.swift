//
//  PhotoCell.swift
//  photoapp
//
//  Created by Irish on 9/3/21.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var photo:Photo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayPhoto(photo:Photo) {
        
        // Reset the image
        self.photoImageView.image = nil
        
        // Set photo property
        self.photo = photo
        
        // Set the username
        usernameLabel.text = photo.byUsername
        
        // Set the date
        dateLabel.text = photo.date
        
        let url = photo.url
        
        // Check if photo has url
        guard url != nil else {
            return
        }
        
        // Check if the image is in cache, if it is, use it
        if let cachedImage = ImageCacheService.getImage(url: url!) {
            
            DispatchQueue.main.async {
                // Used the cached image
                self.photoImageView.image = cachedImage
            }
            
            // Return because we no longer need to download the image
            return
        }
        
        // Create path from url string
        let urlPath = URL(string: url!)
        
        guard urlPath != nil else {
            return
        }
        
        // Initiate url session
        let session = URLSession.shared
        
        // Download the photo
        let dataTask = session.dataTask(with: urlPath!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                // Set the image view
                let image = UIImage(data: data!)
                
                // Store the image data in cache
                ImageCacheService.saveImage(url: urlPath!.absoluteString, image: image)
                
                // Check the image data we downloaded the matches the photo the cell is supposed to display
                if urlPath!.absoluteString != self.photo?.url! {
                    return
                }
                
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                }
            }
        }
        dataTask.resume()
    }
}
