//
//  ViewController.swift
//  piscine_rush01
//
//  Created by Brian Young on 6/23/17.
//  Copyright © 2017 byoung-w. All rights reserved.
//

import UIKit
import Mapbox
import MapboxGeocoder
import CoreLocation


class ViewController: UIViewController, MGLMapViewDelegate
{
    var searchController : UISearchController!

	@IBOutlet weak var stackview_searchbar_sub_1: UIStackView!
	@IBOutlet weak var stackview_searchbar_sub_2: UIStackView!
    @IBOutlet weak var stackview_searchbar: UIStackView!
    @IBOutlet weak var stackview_searchbar_sub: UIStackView!
    @IBOutlet var MapBoxView: MGLMapView!
    @IBOutlet weak var mapcontrol: UISegmentedControl!

    var manager:CLLocationManager!
	var 	search_start : Search_Controller_Delegate!

	var 	search_dest : Search_Controller_Delegate!

	var    mAPI_Direction : API_Direction!
    
    @IBAction func GoButton(_ sender: Any)
    {
        print("Go")
		mAPI_Direction.turn_by_turn_navigation(vc: self)
    }
	
	func   zoom_user_location()
	{
		MapBoxView.setCenter(CLLocationCoordinate2D(latitude: _NAV_.user().latitude_user,  longitude:_NAV_.user().longitude_user),
		                     zoomLevel: 15, animated: true)
		mAPI_Direction.cancel_points()
	}

	
    override func viewDidLoad()
    {
        super.viewDidLoad()
		MapBoxView.delegate = self
		_NAV_.set_view_ref(theref: self)
		_TOAST_.controller = self
		// Do any additional setup after loading the view, typically from a nib.

		self.search_start = Search_Controller_Delegate(theview: self)
		self.search_start.add_to_uiview(theview : self.stackview_searchbar_sub_1)
		self.search_start.callback(thecallback: search_destination)

		self.search_dest = Search_Controller_Delegate(theview: self)
		self.search_dest.add_to_uiview(theview : self.stackview_searchbar_sub_2)
		self.search_dest.callback(thecallback: search_departure)
		self.search_dest.get_search_controller().searchBar.placeholder = "Starting From?"

		mAPI_Direction = API_Direction(themap: MapBoxView)
    }
    
    func search_destination(marks: [GeocodedPlacemark])
	{
        print("search_destination")
//        print(marks)
	    if (marks.count == 0)
		{
			return
		}
        mAPI_Direction.set_end(placemark : marks.first!)
	}

	func search_departure(marks: [GeocodedPlacemark])
	{
 		 print("search_departure")
		if (marks.count == 0)
		{
			return
		}
		mAPI_Direction.set_start(placemark : marks.first!)
	}

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLocationClick(_ sender: Any)
    {
        zoom_user_location()
    }
    
    func movemap(coord:CLLocationCoordinate2D)
    {
        
    }
	
    @IBAction func segcontrol(sender: AnyObject)
    {
        switch (mapcontrol.selectedSegmentIndex) {
        case 0:
			MapBoxView.styleURL = MGLStyle.streetsStyleURL(withVersion: 9)
            break;
        case 1:
			MapBoxView.styleURL = MGLStyle.satelliteStyleURL(withVersion: 9)
            break;
        case 2:
			MapBoxView.styleURL = MGLStyle.satelliteStreetsStyleURL(withVersion: 10)
            break;
        default:
            break;
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
		print("cellforRowat");
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

	func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool
	{
		return true
	}
}





