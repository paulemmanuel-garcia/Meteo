//
//  CurrentViewController.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 09/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import UIKit

public class CurrentWeatherViewController: UIViewController, UIWeatherElement {
    
    public var city: String = ""
    
    private var _currentWeather: CurrentWeather?
    private var currentWeather: CurrentWeather? {
        set {
            _currentWeather = newValue
            
            if let temp = newValue?.temp {
                tempLabel.text = "\(temp)"
            } else {
                tempLabel.text = "No temperature available"
            }

            conditionLabel.text = newValue?.conditions.first?.description
        }
        get {
            return _currentWeather
        }
    }
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        cityLabel.text = city
        // Do any additional setup after loading the view.
        Weather.api.getCurrentWeather(for: city) {
            currentWeather, error in
            
            self.currentWeather = currentWeather
        }
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
