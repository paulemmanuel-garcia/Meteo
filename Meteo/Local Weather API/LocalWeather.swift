//
//  LocalWeather.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 09/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import Foundation

protocol LocalWeatherElement: WeatherElement {
    func serialize() -> [String: Any]
    static func get(with city: String)
}

extension Weather {
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

    func get(service: APIEndpoints, city: String) -> [String: Any]? {
        
        guard let data = UserDefaults.standard.object(forKey: "\(service.rawValue):\(city)") as? Data else {
                return nil
        }

        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any]
    }
}
