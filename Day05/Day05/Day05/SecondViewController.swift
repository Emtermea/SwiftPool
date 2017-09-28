//
//  SecondViewController.swift
//  Day05
//
//  Created by Emmanuelle TERMEAU on 6/19/17.
//  Copyright © 2017 Emmanuelle TERMEAU. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var clickedOn : Place?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var listView: UITableView! {
        didSet {
            listView.delegate = self
            listView.dataSource = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell")
        
        cell?.textLabel?.text = places[indexPath.row].title
        cell?.detailTextLabel?.text = places[indexPath.row].subtitle
        
        return cell!
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMap" {
            if let d = segue.destination as? FirstViewController {
                d.goTo = self.clickedOn!
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(places[indexPath.row])
        self.clickedOn = places[indexPath.row]
        performSegue(withIdentifier: "goToMap", sender: self)
    }
}

