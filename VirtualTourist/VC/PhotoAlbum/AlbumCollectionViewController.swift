//
//  AlbumCollectionViewController.swift
//  Virtual Tourist
//
//  Created by 강선미 on 21/10/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import UIKit
import CoreData
import MapKit


class AlbumCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var newCollectionButton: UIButton!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var mapView: MKMapView!
    
    var fetchedResultsController: NSFetchedResultsController<Photo>!
    var pin: Pin!
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check pin data or not
      guard let pin = pin else {
            showAlert(title: "Can't load photo album", message: "Try Again!!")
            fatalError("No pin ")
        }
        
        navTitle.title = pin.locationName ?? "Album"
        setUpMapView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func showAlert(title: String, message: String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    // remove all existing images from current place
    @IBAction func newCollection(_ sender: Any) {
        guard let imageObject = fetchedResultsController.fetchedObjects else { return }
        for image in imageObject {
            dataController.viewContext.delete(image)
    
        }
    }
    
    func downloadPhotoData() {
      
        // manage activity indicator : start running
        guard fetchedResultsController.fetchedObjects != nil else {
            // show alarm
            print("image metadata is already present. no need to re download")
            return
        }
        
        let pagesCount = Int(self.pin.pages)
        let annotation = AnnotationPin(pin: pin)
        FlickrClient.getPhotos(latitude: annotation.pin.latitude,longitude: annotation.pin.longitude,
                               totalPageAmount: pagesCount) { (photos, totalPages, error) in
            
        guard photos.count == 0 else {
            print("Error!")
            return
        }
                        
        if pagesCount == 0 {
            self.pin.pages = Int32(totalPages)
        }
        // run for loop
        for photo in photos {
            let newPhoto = Photo(context: self.dataController.viewContext)
            newPhoto.imageUrl = URL(string: photo.url_m)
            newPhoto.imageData = nil
            newPhoto.pin = self.pin
            newPhoto.imageID = UUID().uuidString
            
            do {
                try self.dataController.viewContext.save()
            } catch {
                print("Can't save photoes!!")
            }
            
        }
         
        // manage activity indicator : stop
      }
        
    }
    
    
    
    

}



