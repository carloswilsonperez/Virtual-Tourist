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

    var dataController:DataController!
    var fetchedResultsController: NSFetchedResultsController<Pin>!
    var pin: Pin?
    let regionKey: String = "persistedMapRegion"

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        callPersistedLcation()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         refreshData()
     }

     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
       
     }
    
    
//    dataController.viewContext.perform {
//      do {
//        let pins = try self.dataController.viewContext.fetch(request)
//        self.mapView.addAnnotations(pins.map { pin in AnnotationPin(pin: pin) })
//
//        } catch {
//            print("Error fetching Pins: \(error)")
//        }
//    }

    @IBAction func longPressOnMap(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            noticeLabel.text = "put finger to add pin"
        } else {
            // Get the coordinates of the tapped location on the map.
            let locationCoordinate = mapView.convert(sender.location(in: mapView), toCoordinateFrom: mapView)
            noticeLabel.text = "long press to add new location"
            saveGeoCoordination(from: locationCoordinate)
        }
        
    }
    
    func copyLocation(_ annotation: MKPointAnnotation) {
        let location = Pin(context: dataController.viewContext)
        location.creationDate = Date()
        location.longitude = annotation.coordinate.longitude
        location.latitude = annotation.coordinate.latitude
        location.locationName = annotation.title
        location.country = annotation.subtitle
        location.pages = 0
        try? dataController.viewContext.save()
        let annotationPin = AnnotationPin(pin: location)
        self.mapView.addAnnotation(annotationPin)
        
    }
    /// get Geo position and store value Pin viewContext
    func saveGeoCoordination(from coordinate: CLLocationCoordinate2D) {
        let geoPos = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let annotation = MKPointAnnotation()
        CLGeocoder().reverseGeocodeLocation(geoPos) { (placemarks, error) in
            guard let placemark = placemarks?.first else { return }
            annotation.title = placemark.name ?? "Not Known"
            annotation.subtitle = placemark.country
            annotation.coordinate = coordinate
            self.copyLocation(annotation)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let photoAlbumViewController = segue.destination as? AlbumCollectionViewController else { return }
        let pinAnnotation: AnnotationPin = sender as! AnnotationPin
        photoAlbumViewController.pin = pinAnnotation.pin
        photoAlbumViewController.dataController = dataController
    }

      //  let pinAnnotation: AnnotationPinView = sender as! AnnotationPinView

}

 extension MapViewController: MKMapViewDelegate, NSFetchedResultsControllerDelegate {
    
    func refreshData() {
        // clear all annotations to get new data
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        // fetch all pins
        let request: NSFetchRequest<Pin> = Pin.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        request.sortDescriptors = [sortDescriptor]
           
        dataController.viewContext.perform {
          do {
            let pins = try self.dataController.viewContext.fetch(request)
            self.mapView.addAnnotations(pins.map { pin in AnnotationPin(pin: pin) })
            

            } catch {
                print("Error fetching Pins: \(error)")
            }
        }
        
    }
    
    
    
 func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
    
        let pinAnnotation = annotation as! AnnotationPin
        pinAnnotation.title = pinAnnotation.pin.locationName
        pinAnnotation.subtitle = pinAnnotation.pin.country
    
        print("\(String(describing: pinAnnotation.title)) \(String(describing: pinAnnotation.subtitle))")
   
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
 
    func saveMapLocation() {
        let mapRegion = [
            "latitude" : mapView.region.center.latitude,
            "longitude" : mapView.region.center.longitude,
            "latitudeDelta" : mapView.region.span.latitudeDelta,
            "longitudeDelta" : mapView.region.span.longitudeDelta
        ]
        UserDefaults.standard.set(mapRegion, forKey: regionKey)
    }
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        self.saveMapLocation()
    }

    
    func callPersistedLcation() {
        if let mapRegin = UserDefaults.standard.dictionary(forKey: regionKey) {
            let location = mapRegin as! [String: CLLocationDegrees]
            let center = CLLocationCoordinate2D(latitude: location["latitude"]!, longitude: location["longitude"]!)
            let span = MKCoordinateSpan(latitudeDelta: location["latitudeDelta"]!, longitudeDelta: location["longitudeDelta"]!)
            
            mapView.setRegion(MKCoordinateRegion(center: center, span: span), animated: true)
        }
    }
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        guard let annotation = view.annotation else { return }
//
//        let pinAnnotation = annotation as! AnnotationPin
//        performSegue(withIdentifier: "showPhotoAlbum",  sender: pinAnnotation)
//
//        mapView.deselectAnnotation(view.annotation, animated: false)
//    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation else { return }

        let pinAnnotation = annotation as! AnnotationPin
        performSegue(withIdentifier: "showPhotoAlbum",  sender: pinAnnotation)

        mapView.deselectAnnotation(view.annotation, animated: false)
        
    }
  
 }
