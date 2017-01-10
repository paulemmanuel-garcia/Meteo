//
//  LocalDayWeather.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 09/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import Foundation

extension Condition: LocalWeatherElement {
    static func get(with city: String) {
    }
    
    func serialize() -> [String : Any] {
        return [
            "id": id,
            "description": description,
            "icon": icon
        ]
    }
}

extension DayWeather: LocalWeatherElement {
    static func get(with city: String) {
    }
    
    func serialize() -> [String: Any] {
        return [
            "main": [
                "temp": temp,
                "temp_min": tempMin,
                "temp_max": tempMax,
            ],
            "weather": conditions.map { $0.serialize() }
        ]
    }
}

