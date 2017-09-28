//
//  SecondViewController.swift
//  rush01
//
//  Created by Emmanuelle TERMEAU on 6/24/17.
//  Copyright © 2017 Emmanuelle TERMEAU. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController {

    var localSearchRequest : MKLocalSearchRequest!
    var localSearch : MKLocalSearch!
    var source : MKMapItem?
    let request = MKDirectionsRequest()
    var route : MKOverlay?
    
    
    @IBOutlet weak var fromTextField: UITextField!
    
    
    @IBOutlet weak var toTextField: UITextField!
    
    
    @IBAction func GoButton(_ sender: Any) {
        self.view.endEditing(true)
        getRoute()
    }
    
    func getDestination()
    {
        let geocoder = CLGeocoder()
        print("GET DESTINATION")
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = toTextField.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (localSearchResponse, error) -> Void in
//            if localSearchResponse == nil{
//                let alertController = UIAlertController(title: "Not found", message: "To Place Not Found", preferredStyle: UIAlertControllerStyle.alert)
//                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
//                self.present(alertController, animated: true, completion: nil)
//                return
//            }
            let location = CLLocation(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
            print(location)
            geocoder.reverseGeocodeLocation(location, completionHandler: {
                (placemarks:[CLPlacemark]?, error:Error?) -> Void in
                print("REVERSE")
                if placemarks != nil && (placemarks?.count)! > 0 {
                    print("COUNT")
                    if let addressDict = placemarks?[0].addressDictionary as? [String: Any] {
                        print("ADRESSE DICT")
                        let coordinate = placemarks?[0].location?.coordinate
                        let mkPlacemark = MKPlacemark(coordinate: coordinate!, addressDictionary: addressDict)
                        self.request.destination =  MKMapItem(placemark: mkPlacemark)
                        self.request.transportType = MKDirectionsTransportType.automobile;
                        self.request.requestsAlternateRoutes = true
                        let directions = MKDirections(request: self.request)
                        directions.calculate (completionHandler: {
                            (response: MKDirectionsResponse?, error: Error?) in
                            if error == nil {
                                let ctrl : FirstViewController = self.parent?.childViewControllers[0] as! FirstViewController
                                ctrl.localiseRealTime = false
                                if (self.route != nil) {
                                    ctrl.mapView.remove(self.route!)
                                }
                                let span = MKCoordinateSpanMake(0.005, 0.005)
                                let reg = MKCoordinateRegion(center: (self.request.source?.placemark.coordinate)!, span :span)
                                ctrl.mapView.setRegion(reg, animated: true)
                                self.route = (response?.routes[0].polyline)!
                                print("self.route", self.route!)
//                                ctrl.mapView.add(self.route!)
                                ctrl.mapView.add(self.route!)
                                print("ok1")
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                print("ok2")
                                self.tabBarController?.selectedIndex = 0
                            } else {
                                self.handleError(errorMessage: "Unable to find route", errorTitle: "No route")
                            }
                        })
                    } else {
                        self.handleError(errorMessage: "Adress dict is empty", errorTitle: "Empty adress dict")
                    }
                } else {
                    self.handleError(errorMessage: "Placemark is empty", errorTitle: "Empty placemark")
                }
            })
        }
    }
    
    func getRoute()
    {
        if (fromTextField.text == toTextField.text) {
            handleError(errorMessage: "From and to are the same", errorTitle: "Same locations")
            return
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let geocoder = CLGeocoder()
        
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = fromTextField.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (localSearchResponse, error) -> Void in
            if localSearchResponse == nil {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let alertController = UIAlertController(title: "Not found", message: "From Place Not Found", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            let location = CLLocation(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
            print(location)
            geocoder.reverseGeocodeLocation(location, completionHandler: {
                (placemarks:[CLPlacemark]?, error:Error?) -> Void in
                if placemarks != nil && (placemarks?.count)! > 0 {
                    if let addressDict = placemarks?[0].addressDictionary as? [String: Any] {
                        let coordinate = placemarks?[0].location?.coordinate
                        let mkPlacemark = MKPlacemark(coordinate: coordinate!, addressDictionary: addressDict)
                        self.request.source =  MKMapItem(placemark: mkPlacemark)
                        self.getDestination()
                    } else {
                        self.handleError(errorMessage: "Adress dict is empty", errorTitle: "Empty adress dict")
                    }
                } else {
                    self.handleError(errorMessage: "Placemark is empty", errorTitle: "Empty placemark")
                }
            })
        }
    }

    
    func handleError(errorMessage:String, errorTitle:String)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("second view")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
}

