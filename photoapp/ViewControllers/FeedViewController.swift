//
//  FeedViewController.swift
//  photoapp
//
//  Created by Irish on 8/27/21.
//

import UIKit

class FeedViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set view controller as the datasource and delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        // Add pull to refresh
        addRefresControl()

        // Call the photo service to retrieve the photos
        PhotoService.retrievePhotos { (retrievedPhotos) in
            
            self.photos = retrievedPhotos
            
            self.tableView.reloadData()
        }
    }
    
    func addRefresControl() {
        
        // Create refresh control
        let refresh = UIRefreshControl()
        
        // Set target
        refresh.addTarget(self, action: #selector(refreshFeed(refreshControl:)), for: .valueChanged)
        
        // Add to tableview
        self.tableView.addSubview(refresh)
    }
    
    @objc func refreshFeed(refreshControl: UIRefreshControl) {
        
        // Call the Photo service
        PhotoService.retrievePhotos { (newPhotos) in
            
            // Assign new photos to the photos property
            self.photos = newPhotos
            
            DispatchQueue.main.async {
                
                // Refresh table view
                self.tableView.reloadData()
                
                // stop the spinner
                refreshControl.endRefreshing()
            }
        }
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.photoCellId, for: indexPath) as? PhotoCell
        
        let photo = self.photos[indexPath.row]
        
        cell?.displayPhoto(photo: photo)
        
        return cell!
    }
    
    
}
