//
//  AddPersonViewController.swift
//  Day02
//
//  Created by Emmanuelle TERMEAU on 6/15/17.
//  Copyright © 2017 Emmanuelle TERMEAU. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController {

    @IBAction func back_1(_ sender: Any) {
        
        
        print("fdsafasfeas")
        self.performSegue(withIdentifier: "unwind_add_person", sender: self)
        
        
    }
    
    @IBAction func ButtonDone(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
//        dateFormatter.timeStyle = DateFormatter.Style.medium
        let strDate = dateFormatter.string(from: timeDate.date)
        if (!(nameField.text?.isEmpty)! && !(nameField.text?.isEmpty)!){
            Data.death.append((nameField.text!, descriptionField.text!, strDate))
            print (nameField.text!)
            print(descriptionField.text!)
            print(strDate)
            
            performSegue(withIdentifier: "unwind_add_person", sender: Any?.self)
        }
        
    }
    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBOutlet weak var timeDate: UIDatePicker!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timeDate.minimumDate = Date()
        self.timeDate.datePickerMode = UIDatePickerMode.date
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "unwind_add_person" {
            
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


