//
//  LocalWeather.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 09/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import Foundation


/// WeatherElements must implement this protocol
/// to be saved locally.
protocol LocalWeatherElement: WeatherElement {
    
    /// Key-Value representation of a Weather Element
    /// will be used to serialize that object
    /// and store it locally.
    ///
    /// - Returns: Dictionary representing the data to save locally.
    func serialize() -> [String: Any]
}

extension Weather {
    
    /// Store locally the openweathermap data
    /// retrieved from a specific endpoint and a specific city.
    ///
    /// - Parameters:
    ///   - service: The API endpoint of the data to save.
    ///   - city: The specific city of the data to save.
    ///   - data: Data to store locally, must implement LocalWeatherElement protocol.
    func save<T: LocalWeatherElement>(service: APIEndpoints, city: String, data: T?) {
        guard let data = data else {
            return
        }

        let serializedData = data.serialize()

        guard let encodedData = try? JSONSerialization.data(withJSONObject: serializedData, options: JSONSerialization.WritingOptions(rawValue: 0)) else {
            return
        }

        UserDefaults.standard.set(encodedData, forKey: "\(service.rawValue):\(city)")
    }

    /// Retrieve locally previously stored data from the openweathermap API.
    /// If no data correspond to the search parameters (APIEndpoint and city)
    /// nil is returned, otherwise the data's serialized representation is returned.
    ///
    /// - Parameters:
    ///   - service: The APIEndpoint te retrieve the data from.
    ///   - city: The city to retrieve the data from.
    /// - Returns: Serialized representation of the data.
    func get(service: APIEndpoints, city: String) -> [String: Any]? {
        
        guard let data = UserDefaults.standard.object(forKey: "\(service.rawValue):\(city)") as? Data else {
                return nil
        }

        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any]
    }
}
