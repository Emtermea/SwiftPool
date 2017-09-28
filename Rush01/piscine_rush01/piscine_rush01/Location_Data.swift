//
//  Location_Data.swift
//  piscine_d05
//
//  Created by Brian Young on 16/6/17.
//  Copyright © 2017 Brian Young. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Location_Data
{
	private var _name :String
	private var _title :String
	private var _description :String!
	var latitude:CLLocationDegrees?
	var longitude:CLLocationDegrees?

	var color:UIColor!

	init(name : String, title: String, description : String)
	{
		self._name = name
		self._title = title
		self._description = description
		self.color = UIColor.red
	}

	func set_coordinates(lat : CLLocationDegrees, long : CLLocationDegrees)-> Location_Data
	{
		self.latitude = lat
		self.longitude = long
		return self
	}
	func set_color(thecolor : UIColor)-> Location_Data
	{
		self.color = thecolor
		return self
	}

	func get_latitude() ->CLLocationDegrees
	{
		return self.latitude!
	}
	func get_longitude() ->CLLocationDegrees
	{
		return self.longitude!
	}

	func get_name() ->String
	{
		return self._name
	}

	func get_title() ->String
	{
		return self._title
	}

	func get_description() ->String
	{
		return self._description
	}

}
