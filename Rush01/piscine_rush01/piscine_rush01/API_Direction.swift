//
//  API_Direction.swift
//  piscine_rush01
//
//  Created by Brian Young on 6/25/17.
//  Copyright © 2017 byoung-w. All rights reserved.
//

import UIKit
import Mapbox
import MapboxNavigation
import MapboxDirections
import MapboxGeocoder

class API_Direction: NSObject
{
	var location_start : Location_Data!
	var location_end : Location_Data!
	let directions = Directions.shared

	var set_start : Bool = false
	var set_end : Bool = false
	var set_route: Bool = false
	
	var annotation_start : MGLPointAnnotation!
	var annotation_end : MGLPointAnnotation!
	var route_line : MGLPolyline?
	var route_data : Route?
	
	var map_ref: MGLMapView!

	var bound_box : MGLCoordinateBounds!
	
	let formatter = CNPostalAddressFormatter()
	
	init(themap: MGLMapView)
	{
		location_start = nil;
		location_end = nil;
		map_ref = themap
		annotation_start = MGLPointAnnotation()
		annotation_end = MGLPointAnnotation()
		
	}
	func set_start(placemark : GeocodedPlacemark)
	{
		print("set_start")
		set_start = true
		location_start = Location_Data(name: placemark.qualifiedName, title: placemark.name, description: formatter.string(from: placemark.postalAddress!))
		location_start.latitude = placemark.location.coordinate.latitude
		location_start.longitude = placemark.location.coordinate.longitude
		annotation_start.coordinate = CLLocationCoordinate2D(latitude: location_start.latitude!, longitude: location_start.longitude!)
		annotation_start.title = location_start.get_title()
		annotation_start.subtitle = placemark.qualifiedName
		map_ref.addAnnotation(annotation_start)
		bound_box = MGLCoordinateBounds(sw:
		CLLocationCoordinate2D(
				latitude: _NAV_.user().latitude_user,
				longitude:_NAV_.user().longitude_user)
				, ne: CLLocationCoordinate2D(
				latitude: location_start.latitude!,
				longitude:location_start.longitude!))
		calculate_route()
	}

	func set_end(placemark : GeocodedPlacemark)
	{
		print("set_end")
		set_end = true
		location_end = Location_Data(name: placemark.qualifiedName, title: placemark.name, description: formatter.string(from: placemark.postalAddress!))
		
		if (!set_start)
		{
			location_start = Location_Data(name: "User GPS", title: "Custom Location", description: "User GPS Location")
			location_start.latitude = _NAV_.user().latitude_user
			location_start.longitude = _NAV_.user().longitude_user
		}
		
		location_end.latitude = placemark.location.coordinate.latitude
		location_end.longitude = placemark.location.coordinate.longitude
		annotation_end.coordinate = CLLocationCoordinate2D(latitude: location_end.latitude!, longitude: location_end.longitude!)
		annotation_end.title = location_end.get_title()
		annotation_end.subtitle = placemark.qualifiedName
		map_ref.addAnnotation(annotation_end)
		bound_box = MGLCoordinateBounds(sw:
		CLLocationCoordinate2D(
				latitude: _NAV_.user().latitude_user,
				longitude:_NAV_.user().longitude_user)
				, ne: CLLocationCoordinate2D(
				latitude: location_end.latitude!,
				longitude:location_end.longitude!))
		calculate_route()
	}

	func cancel_points()
	{
		if (set_start)
		{
			map_ref.removeAnnotation(annotation_start)
		}
		if (set_end)
		{
			map_ref.removeAnnotation(annotation_end)
		}
		if (set_route)
		{
			map_ref.removeAnnotation(route_line!)
		}
		set_end = false
		set_start = false
		set_route = false
	}

	func calculate_route()
	{
		print("calculate_route \(set_route) \(set_start) \(set_end)")
		if (set_route)
		{
			map_ref.removeAnnotation(route_line!)
			set_route = false
		}
		if (set_start && set_end)
		{
			bound_box = MGLCoordinateBounds(sw:
			CLLocationCoordinate2D(
					latitude: location_start.latitude!,
					longitude:location_start.longitude!)
					, ne: CLLocationCoordinate2D(
					latitude: location_end.latitude!,
					longitude:location_end.longitude!))
			map_ref.setVisibleCoordinateBounds(bound_box, animated: true)
			api_server_calculate_route(start:
			CLLocationCoordinate2D(
					latitude: location_start.latitude!,
					longitude:location_start.longitude!)
					, end:
			CLLocationCoordinate2D(
					latitude: location_end.latitude!,
					longitude:location_end.longitude!))
			return
		}
		else if (!set_start && set_end)
		{
			map_ref.setVisibleCoordinateBounds(bound_box, animated: true)
			api_server_calculate_route(start:
			CLLocationCoordinate2D(
					latitude: _NAV_.user().latitude_user,
					longitude:_NAV_.user().longitude_user)
					, end:
			CLLocationCoordinate2D(
					latitude: location_end.latitude!,
					longitude:location_end.longitude!))
			
			return
		}
		map_ref.setVisibleCoordinateBounds(bound_box, animated: true)
	}

	func turn_by_turn_navigation(vc : UIViewController)
	{
		if (!set_route)
		{
			return
		}
		let viewController = NavigationViewController(for: route_data!)
		print("turn by turn nav sim \(SettingsViewController.turn_by_turn)")
		viewController.simulatesLocationUpdates = SettingsViewController.turn_by_turn
		vc.present(viewController, animated: true, completion: nil)
		TripListViewController.locations.append(
			[location_start, location_end])
		
		let tababarController = AppDelegate.getRootController() as! UITabBarController
		tababarController.selectedIndex = 1
		let ref: TripListViewController = tababarController.selectedViewController as! TripListViewController
		ref.table_view.reloadData()
		tababarController.selectedIndex = 0
	}

	func api_server_calculate_route(start :CLLocationCoordinate2D, end: CLLocationCoordinate2D)
	{
		print("api_server_calculate_route")
		let strongSelf = self
		/*DispatchQueue.global(qos: .background).async { [weak self]
		() -> Void in

			guard let strongSelf = self
					else {return}*/
			let waypoints = [
					Waypoint(coordinate: start, name: "Departure"),
					Waypoint(coordinate: end, name: "Destination"),
			]
			let options = RouteOptions(waypoints: waypoints, profileIdentifier: SettingsViewController.transport_method)
			options.includesSteps = true

			strongSelf.directions.calculate(options) { (waypoints, routes, error) in
				guard error == nil else
				{
					print("Error calculating directions: \(error!)")
					return
				}
				if let route = routes?.first, let leg = route.legs.first
				{
					
					let distanceFormatter = LengthFormatter()
					let formattedDistance = distanceFormatter.string(fromMeters: route.distance)

					let travelTimeFormatter = DateComponentsFormatter()
					travelTimeFormatter.unitsStyle = .short
					let formattedTravelTime = travelTimeFormatter.string(from: route.expectedTravelTime)

					
						_TOAST_.showToast(message: "Route via \(leg): Distance: \(formattedDistance); ETA: \(formattedTravelTime!)")
						if route.coordinateCount > 0
						{
							strongSelf.set_route = true
							// Convert the route’s coordinates into a polyline.
							var routeCoordinates = route.coordinates!
							strongSelf.route_line = MGLPolyline(coordinates: &routeCoordinates, count: route.coordinateCount)
							self.route_data = route
							// Add the polyline to the map and fit the viewport to the polyline.
							strongSelf.map_ref.addAnnotation(strongSelf.route_line!)
							strongSelf.map_ref.setVisibleCoordinates(&routeCoordinates, count: route.coordinateCount, edgePadding: .zero, animated: true)
						}
					
					/*for step in leg.steps {
							print("\(step.instructions)")
							let formattedDistance = distanceFormatter.string(fromMeters: step.distance)
							print("— \(formattedDistance) —")
						}*/
				}
			//}
		}
	}
}
