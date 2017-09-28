//
//  Places.swift
//  Day05
//
//  Created by Emmanuelle TERMEAU on 6/19/17.
//  Copyright © 2017 Emmanuelle TERMEAU. All rights reserved.
//

import Foundation
import MapKit

class Place : NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
    
    init (title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.subtitle = info
    }
    
    override var description: String {
        return "\(title)"
    }
}

var places : [Place] = [Place(title: "École 42", coordinate: CLLocationCoordinate2D(latitude: 48.896788, longitude: 2.318520), info: "ça sent pas bon dedans"), Place(title: "La Tour Eiffel", coordinate: CLLocationCoordinate2D(latitude: 48.858525, longitude: 2.294508), info: "ouah c'est haut!"), Place(title: "Coldfoot", coordinate: CLLocationCoordinate2D(latitude: 67.250989, longitude: -150.176134), info: "c'est loin et il fait froid")]
