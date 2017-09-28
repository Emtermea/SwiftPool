//
//  ViewController.swift
//  Day00
//
//  Created by Emmanuelle TERMEAU on 6/12/17.
//  Copyright © 2017 Emmanuelle TERMEAU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ResultLabel: UILabel!
    
    var num_display : String?
   
    @IBOutlet weak var display_number: UILabel!
    
    var display_length_limit: Int = 8 // 99999999 * (-)99999999 = marche sans overflow
    var left_number : Double!
    var right_number : Double!
    var final_result : Double!
    var current_operation : String!
    var just_equaled : Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        reset()
         display_number.text = "0"
        just_equaled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reset()
    {
       final_result = 0
        num_display = "0"
        left_number = 0;
        right_number = 0;
        current_operation = ""
        
    }
    
   @IBAction func buttonPressed(sender: UIButton)
   {
        if (just_equaled == true) {
            right_number = 0
            just_equaled = false
        }
        if ((num_display?.characters.count)! >= display_length_limit) {
            return
        }
        print("buttonPressed")
        if (sender.tag >= 0 && sender.tag <= 9) {
            num_display?.append("\(String(sender.tag))")
            //Number buttons
            if num_display?.characters.first == "0" {
                num_display?.remove(at: (num_display?.startIndex)!)
                print("remove")
            }
            display_number.text = num_display
            right_number = Double(num_display!)
        }
   }

    @IBAction func ACPressed(_ sender: Any) {
         print("ACPressed")
            reset()
         display_number.text = "0"
        just_equaled = false
    }
    
    @IBAction func NEGPressed(_ sender: Any) {
        print("NEGPressed")
        if right_number != 0 {
            right_number = right_number * -1
            display_number.text = String(right_number)
        }
    }
    
    @IBAction func AddPressed(_ sender: Any) {
         do_operation(new_op:"+")
    }
    @IBAction func SubtractPressed(_ sender: AnyObject) {
         do_operation(new_op:"-")
    }
    @IBAction func DividePressed(_ sender: AnyObject) {
         do_operation(new_op: "/")
    }
    @IBAction func MultiplyPressed(_ sender: AnyObject) {
        do_operation(new_op:"*")
    }
    @IBAction func EqualPressed(_ sender: AnyObject) {
        // take left number and right number, then do current_operation
         do_operation(new_op:"=")
    }
    
    func do_operation(new_op: String) {
        //take right number, and do current operation with left number, then change left number to operation result
        if (new_op == "=") {
            calculate()
            final_result = left_number
            
            display_number.text = "\(String(final_result))"
            
            let  tmp  = final_result
            reset()
            
            right_number = tmp;
            current_operation = ""
            just_equaled = true
        }
        else {
            if (current_operation == "") {
                left_number = right_number
                right_number = 0
                current_operation = new_op
                num_display = "0"
                return
            }
            calculate()
            num_display = "0"
            right_number = 0
            current_operation = new_op
        }
    }
    func calculate() {
        if (current_operation == "+") {
            left_number = left_number + right_number
        }
        else if(current_operation == "-") {
            left_number = left_number - right_number
        }
        else if(current_operation == "/") {
            left_number = left_number / right_number
        }
        else if(current_operation == "*") {
            left_number = left_number * right_number
        }
    }
}

