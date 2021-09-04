//
//  ImageCacheService.swift
//  photoapp
//
//  Created by Irish on 9/3/21.
//

import Foundation
import UIKit

class ImageCacheService {
    
    static var imageCache = [String: UIImage]()
    
    static func saveImage(url: String?, image: UIImage?) {
        
        if url == nil || image == nil {
            return
        }
        
        // Save the image
        imageCache[url!] = image!
    }
    
    static func getImage(url: String?) -> UIImage? {
        
        if url == nil {
            return nil
        }
        
        // Return the image associated with the url provided
        return imageCache[url!]
    }
    
}
