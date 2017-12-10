//
//  deathTableViewCell.swift
//  Day02
//
//  Created by Emmanuelle TERMEAU on 6/15/17.
//  Copyright © 2017 Emmanuelle TERMEAU. All rights reserved.
//

import UIKit

class deathTableViewCell: UITableViewCell {
    
    @IBOutlet weak var deathLabel: UILabel!
    
    @IBOutlet weak var reasonLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    var death : (String, String, String)? {
        didSet {
            if let d = death {
                deathLabel?.text = d.0
//                reasonLabel?.text = d.1
                dateLabel?.text = d.2
            }
        }
    }
}
