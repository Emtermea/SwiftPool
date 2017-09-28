//
//  FirstViewController.swift
//  Day05
//
//  Created by Emmanuelle TERMEAU on 6/19/17.
//  Copyright © 2017 Emmanuelle TERMEAU. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 1
//        locationManager.startUpdatingLocation()
        mapView.delegate = self
        mapView.addAnnotations(places)
        if self.goTo != nil {
            centerMapOnLocation(location: self.goTo!.coordinate)
            self.goTo = nil
        } else {
            centerMapOnLocation(location: places[0].coordinate)
        }
//        centerMapOnLocation(location: places[0].coordinate)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var mapView: MKMapView!

    var locationManager = CLLocationManager()
    var currentLoc : Place?
    let regionRadius: CLLocationDistance = 200
    var goTo : Place?
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let titre = annotation.title
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Place") as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Place")
            annotationView?.pinTintColor = UIColor.random()
//            annotationView?.pinTintColor = getColor(place: titre!)
        }
        else {
            annotationView!.annotation = annotation
        }
        annotationView!.canShowCallout = true
        return annotationView
    }
    
    
    func centerMapOnLocation(location : CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations : [CLLocation]) {
        if self.currentLoc != nil {
            self.mapView.removeAnnotation(self.currentLoc!)
        }
        self.currentLoc = Place(title: "Current position", coordinate: locations[0].coordinate, info: "you are here")
        self.mapView.addAnnotation(self.currentLoc!)
        centerMapOnLocation(location : locations[0].coordinate)
        locationManager.stopUpdatingLocation()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
//        print(self.currentLoc!)
        print("yolo")
    }


    @IBAction func segmentedBar(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
            case 0:
                self.mapView.mapType = MKMapType.standard
            case 1:
                self.mapView.mapType = MKMapType.satellite
            case 2:
                self.mapView.mapType = MKMapType.hybrid
            default:
                self.mapView.mapType = MKMapType.standard
        }
    }
    
    @IBAction func locationButton(_ sender: Any) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        locationManager.startUpdatingLocation()
        print("location button actif")
    }
    
    @IBAction func unWindSegue (segue: UIStoryboardSegue){
        if mapView == nil {
            mapView = MKMapView()
        } else {
            centerMapOnLocation(location: self.goTo!.coordinate)
            self.goTo = nil
        }
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random () -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
