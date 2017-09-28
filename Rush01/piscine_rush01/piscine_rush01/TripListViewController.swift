//
//  TripListViewController.swift
//  piscine_rush01
//
//  Created by Brian Young on 6/23/17.
//  Copyright © 2017 byoung-w. All rights reserved.
//

import UIKit

class TripListViewController: UIViewController , UITableViewDelegate,
    UITableViewDataSource
{
    @IBOutlet weak var table_view: UITableView!
    
    static var locations = [[Location_Data]]()
    
    static func load_locations()
    {
        TripListViewController.locations.append(
			[Location_Data(name: "Ecole 42", title: "My School", description: "Study Place")
            .set_coordinates(lat: 48.896566, long: 2.318398)
				.set_color(thecolor: UIColor.blue),
			 Location_Data(name: "My Home", title: "Porte De Saint Ouen", description: "Student Residence")
				.set_coordinates(lat: 48.9011387, long: 2.3310106)
				.set_color(thecolor: UIColor.green)
			 ]
		)
		
        TripListViewController.locations.append(
		[Location_Data(name: "My Home", title: "Porte De Saint Ouen", description: "Student Residence")
            .set_coordinates(lat: 48.9011387, long: 2.3310106)
            .set_color(thecolor: UIColor.green),
		Location_Data(name: "My Gym", title: "Centre Sportif Max Rousie", description: "I run here")
			.set_coordinates(lat: 48.8996896, long: 2.3237007)
			.set_color(thecolor: UIColor.purple)]
		)
        
        TripListViewController.locations.append(
			[Location_Data(name: "My Gym", title: "Centre Sportif Max Rousie", description: "I run here")
            .set_coordinates(lat: 48.8996896, long: 2.3237007)
            .set_color(thecolor: UIColor.purple),
		Location_Data(name: "Ecole 42", title: "My School", description: "Study Place")
			.set_coordinates(lat: 48.896566, long: 2.318398)
			.set_color(thecolor: UIColor.blue)])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table_view.delegate = self
        table_view.dataSource = self
		TripListViewController.load_locations()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let current_cell: Location_Cell = table_view.cellForRow(at: indexPath) as? Location_Cell
        {
            let tababarController = AppDelegate.getRootController() as! UITabBarController
            tababarController.selectedIndex = 0
            let ref: ViewController = tababarController.selectedViewController as! ViewController
           // ref.search_map(data: current_cell.location_data_local!)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Location_Cell", for: indexPath)
            as? Location_Cell
        {
            let tmp_note = TripListViewController.locations[indexPath.row]
            cell.updateUI(note: tmp_note)
            return cell
        }
        return UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return TripListViewController.locations.count
    }
}
