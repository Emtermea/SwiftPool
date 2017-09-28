//
//  PinAnnotation.swift
//  votreapplication
//
//  Created by swift on 20/12/14.
//  Copyright (c) 2014 votreapplication. All rights reserved.
//

import UIKit
import MapKit


class PinAnnotation : NSObject, MKAnnotation
{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

	var pinColor: UIColor?
    init(location coord:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:0,longitude:0))
	{
        self.coordinate = coord
		self.pinColor = UIColor.red
        super.init()
        
    }
	func setColor(pinColor: UIColor)
	{
		self.pinColor = pinColor
	}
}

