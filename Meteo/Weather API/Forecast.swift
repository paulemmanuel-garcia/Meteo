//
//  Forecast.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 09/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import Foundation

public struct Forecast {
    
    var days: [DayWeather]
    
    public init?(with JSON: [String: Any]) {
        guard let list = JSON["list"] as? [[String: Any]] else {
            return nil
        }
        
        var _days: [DayWeather] = []
        
        for element in list {
            guard let dayWeather = DayWeather(with: element) else {
                continue
            }
            
            let currentDaysWeather = _days.filter { $0.date.compare(with: dayWeather.date) }.flatMap { $0 }
            
            if currentDaysWeather.isEmpty  {
                _days.append(dayWeather)
                continue
            }
        }
        
        self.days = _days
    }
}
