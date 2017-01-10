//
//  Constants.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 09/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import Foundation

let domain: String = "com.rstudio.Meteo"
let iconBaseUrl: String = "http://openweathermap.org/img/w/"

/// Enum grouping general error code
///
/// - urlCreation: Error when trying to create an URL from a String
/// - noData: No data retrieved from network call
enum GenericError: Int {
    case urlCreation = 1
    case noData = 2
}
