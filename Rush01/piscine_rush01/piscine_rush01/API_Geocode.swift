//
//  API_Geocode.swift
//  piscine_rush01
//
//  Created by Brian Young on 6/24/17.
//  Copyright © 2017 byoung-w. All rights reserved.
//

import UIKit
import MapboxGeocoder

class API_Geocode: NSObject
{
    var geocoder : Geocoder!
    override init()
    {
        super.init()
        geocoder = Geocoder(accessToken: _MC_.MAPBOX_TOKEN)

    }
    
    func search_address(the_address : String, loc_user: Location_User,
                     callback: @escaping ([GeocodedPlacemark]) -> Void)
    {
        print("search_address")
        let options = ForwardGeocodeOptions(query: the_address)
        
        // To refine the search, you can set various properties on the options object.
        options.focalLocation = CLLocation(latitude: loc_user.latitude_user, longitude: loc_user.longitude_user)
        options.allowedScopes = [.address, .pointOfInterest]
        
        geocoder.geocode(options)
        {
            (placemarks, attribution, error) in
            print("search_address reply")

            guard let placemark = placemarks?.first else
            {
                return
            }
            callback(placemarks!)
            
            print(placemark.name)
            // 200 Queen St
            print(placemark.qualifiedName)
            // 200 Queen St, Saint John, New Brunswick E2L 2X1, Canada
            
            let coordinate = placemark.location.coordinate
            print("\(coordinate.latitude), \(coordinate.longitude)")
            // 45.270093, -66.050985
            
     
            let formatter = CNPostalAddressFormatter()
            print(formatter.string(from: placemark.postalAddress!))
            // 200 Queen St
            // Saint John New Brunswick E2L 2X1
            // Canada
            
        }
    }
}
