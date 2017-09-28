//
//  Navigation_Delegate.swift
//  piscine_rush01
//
//  Created by Brian Young on 6/24/17.
//  Copyright © 2017 byoung-w. All rights reserved.
//

import UIKit
import CoreLocation

class Navigation_Delegate: NSObject, CLLocationManagerDelegate
{
	var     placemarksarray:NSMutableArray = NSMutableArray();
	var     placemarkdictionary:Dictionary<String, PinAnnotation>! = Dictionary();
	var manager:CLLocationManager!
	private let  user_loc = Location_User()
	var    view_ref : ViewController? = nil

	var     isStart : Bool = false
	override init()
	{
		super.init()
		setup_location_manager()
	}
    
    func user() -> Location_User
    {
        return user_loc
    }
	
	func set_view_ref(theref: ViewController)
	{
		self.view_ref = theref
	}

	func setup_location_manager()
	{
		manager = CLLocationManager()
		manager.delegate = self
		manager.requestAlwaysAuthorization()
		manager.desiredAccuracy = kCLLocationAccuracyBest
		manager.requestWhenInUseAuthorization()
		manager.startUpdatingLocation()
	}

	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
	{
		if status == .authorizedAlways {
			if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self)
			{
				if CLLocationManager.isRangingAvailable()
				{
					manager.desiredAccuracy = kCLLocationAccuracyBest
					manager.requestWhenInUseAuthorization()
					manager.startUpdatingLocation()
				}
			}
		}
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
	{
		let userLocation:CLLocation = locations[0]
		user_loc.latitude_user = userLocation.coordinate.latitude
		user_loc.longitude_user = userLocation.coordinate.longitude
		if (!isStart)
		{
			isStart = true
			if (view_ref != nil)
			{
				view_ref?.zoom_user_location()
			}
		}
		
	}
}

let    _NAV_ : Navigation_Delegate = Navigation_Delegate()

