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
}



