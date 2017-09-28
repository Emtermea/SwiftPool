//
//  ViewController.swift
//  Day07
//
//  Created by Emmanuelle TERMEAU on 6/21/17.
//  Copyright © 2017 Emmanuelle TERMEAU. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO

class ViewController: UIViewController {

    var bot : RecastAIClient?
    var forecast : DarkSkyClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bot = RecastAIClient(token : "4be569f727aab11c9bb0df79bad0a566", language: "en")
        self.forecast = DarkSkyClient(apiKey: "708b467ba0624cd1c935ac542b6a418e")
        
        self.forecast?.units = .auto
        self.forecast?.language = .english
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var answerLabel: UILabel!

    @IBOutlet weak var textField: UITextField!
    
    @IBAction func requestButton(_ sender: Any) {
        if self.textField.text != nil {
            self.bot?.textRequest(self.textField.text!, successHandler: successRequest, failureHandle: failRequest)
        }
        else {
            self.answerLabel.text = "- Error -"
        }
    }
    
    
    func successRequest(resp: Response) {
        
        if resp.intents?[0].slug != nil {
            if let c = resp.entities?["location"] as? [[String:Any]] {
                forecast?.getForecast(latitude: (c[0]["lat"] as? Double)!, longitude: (c[0]["lng"]! as? Double)!) { result in
                    switch result {
                    case .success(let currentForecast, _):
                        let str = "\(c[0]["formatted"]!) is \((currentForecast.hourly?.summary!)!)"
                        print(str)
                        self.answerLabel.text = str
                        print(self.answerLabel.text!)
                    case .failure( _):
                        self.answerLabel.text = "Error 😕"
                    }
                }
            }
        }
    }
    
    func failRequest(err: Error) {
        print(err.localizedDescription)
    }
    
}

