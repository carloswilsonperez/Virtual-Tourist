 //
//  MapViewController.swift
//  Virtual Tourist
//
//  Created by 강선미 on 21/10/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var noticeLabel: UILabel!
    
    var pin: [Pin] = []
    var dataController:DataController!
    var fetchedResultsController:NSFetchedResultsController<Pin>!
    var selectLocation: Pin?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
          
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpFetchedResultsController()
    }
    private func setUpFetchedResultsController() {
        // FetchRequest from Location
        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
        // configure sorting rules
        let sortDescriptor = NSSortDescriptor(key: "dateCreated", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "pin")
               
        fetchedResultsController.delegate = self
         
         do {
             try fetchedResultsController.performFetch()
         } catch {
             fatalError("The fetch could not be performed: \(error.localizedDescription)")
         }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

 extension MapViewController: MKMapViewDelegate, NSFetchedResultsControllerDelegate {
 func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIButton
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
 
    
 }
