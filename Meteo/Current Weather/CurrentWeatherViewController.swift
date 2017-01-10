//
//  CurrentViewController.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 09/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import UIKit
import ImageLoader

public class CurrentWeatherViewController: UIViewController, UIWeatherElement {
    
    public var city: String = ""
    
    private var _currentWeather: CurrentWeather?
    private var currentWeather: CurrentWeather? {
        set {
            _currentWeather = newValue
            
            guard let weather = newValue else {
                return
            }
            
            tempLabel.text = "\(weather.temp)"

            conditionLabel.text = weather.conditions.first?.description
            
            iconImageView.load(with: iconBaseUrl + (weather.conditions.first?.icon ?? "01d") + ".png")
        }
        get {
            return _currentWeather
        }
    }
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
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
