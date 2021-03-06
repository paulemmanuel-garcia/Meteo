//
//  LocalForecast.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 09/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import Foundation

extension Forecast: LocalWeatherElement {
    func serialize() -> [String: Any] {
        return ["list": days.map { $0.serialize() }]
    }
}
