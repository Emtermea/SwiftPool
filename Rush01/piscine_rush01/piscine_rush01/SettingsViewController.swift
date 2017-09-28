//
//  SettingsViewController.swift
//  piscine_rush01
//
//  Created by Brian Young on 6/23/17.
//  Copyright © 2017 byoung-w. All rights reserved.
//

import UIKit
import MapboxDirections

class SettingsViewController: UIViewController
{
	static var turn_by_turn : Bool = false
	static var transport_method: MBDirectionsProfileIdentifier = MBDirectionsProfileIdentifier.walking

	@IBOutlet weak var nav_switch: UISegmentedControl!
	@IBAction func simulator_switch(_ sender: Any)
	{
		SettingsViewController.turn_by_turn = turn_by_turn_switch.isOn
		print("turn by turn SWITCH \(SettingsViewController.turn_by_turn)")
	}

	@IBOutlet weak var turn_by_turn_switch: UISwitch!
	@IBAction func change_nav_method(_ sender: Any)
	{
		switch (nav_switch.selectedSegmentIndex)
		{
		case 0:
			SettingsViewController.transport_method = MBDirectionsProfileIdentifier.walking
			break;
		case 1:
			SettingsViewController.transport_method = MBDirectionsProfileIdentifier.cycling
			break;
		case 2:
			SettingsViewController.transport_method = MBDirectionsProfileIdentifier.automobileAvoidingTraffic
			break;
		default:
			break;
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
