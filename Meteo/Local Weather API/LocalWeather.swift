//
//  LocalWeather.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 09/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import Foundation

protocol LocalWeatherElement {
    func save()
    static func get(with city: String)
}
