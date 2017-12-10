//
//  ViewController.swift
//  Day02
//
//  Created by Emmanuelle TERMEAU on 6/15/17.
//  Copyright © 2017 Emmanuelle TERMEAU. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
//        self.tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.death.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "deathCell", for: indexPath) as? deathTableViewCell {
            cell.death = Data.death[indexPath.row]
            let reason = Data.death[indexPath.row]
            cell.reasonLabel.text = reason.1
            return cell
            
        }
        
        return deathTableViewCell()
    }
    
    @IBAction func unwind_add_person( segue: UIStoryboardSegue)
    {
        self.tableView.reloadData()
    
    }
}

