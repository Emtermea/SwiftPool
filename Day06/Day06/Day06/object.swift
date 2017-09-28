//
//  object.swift
//  Day06
//
//  Created by Emmanuelle TERMEAU on 6/20/17.
//  Copyright © 2017 Emmanuelle TERMEAU. All rights reserved.
//

import Foundation
import UIKit

class object: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var height : CGFloat = 100
    var width : CGFloat = 100
    var objColor : UIColor = UIColor.random()
    var design : String?
    
    func getForm() -> String {
        let rdm = Int(arc4random_uniform(2))
        return rdm == 0 ? "circle" : "rectangle"
    }
    
    init(x: CGFloat, y: CGFloat) {
        super.init(frame: CGRect(x: x - self.width / 2 , y: y - self.height / 2, width: self.width , height: self.height))
        self.backgroundColor = objColor
        self.layer.cornerRadius = 2
        self.design = getForm()
        if self.design == "circle" {
            self.layer.cornerRadius = self.frame.size.width / 2
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random () -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
