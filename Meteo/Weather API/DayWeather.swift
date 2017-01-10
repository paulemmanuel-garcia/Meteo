//
//  DayWeather.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 09/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import Foundation

/// Represent the condition of the weather.
public struct Condition: WeatherElement {
    
    /// Conditions's Id
    public var id: Int
    
    /// Conditions's description
    public var description: String
    
    /// Conditions's icon
    public var icon: String
    
    /// Custom init.
    /// Instanciation from the API.
    /// Return nil if the Condition could not be well created.
    public init?(with JSON: [String: Any]) {
        guard let id = JSON["id"] as? Int, let description = JSON["description"] as? String,
            let icon = JSON["icon"] as? String else {
                return nil
        }
        
        self.id = id
        self.description = description
        self.icon = icon
    }
    
    /// Method to handle multiple conditions creation.
    /// The method return nil if no condition could have been created.
    /// If one condition could have been created we return a valid array.
    ///
    /// - Parameter JSON: Data from the API.
    /// - Returns: Array of conditions or nil.
    public static func create(contidions JSON: [[String: Any]]) -> [Condition]? {
        let result = JSON.map { return Condition(with: $0) }.flatMap { $0 }
        return result.count > 0 ? result : nil
    }
    
//    public required init?(coder aDecoder: NSCoder) {
//        guard let description = aDecoder.decodeObject(forKey: "description") as? String,
//            let icon = aDecoder.decodeObject(forKey: "icon") as? String else {
//                return nil
//        }
//        
//        self.id = Int(aDecoder.decodeInt64(forKey: "id"))
//        self.description = description
//        self.icon = icon
//    }
//    
//    public func encode(with aCoder: NSCoder) {
//        aCoder.encode(id, forKey: "id")
//        aCoder.encode(description, forKey: "description")
//        aCoder.encode(icon, forKey: "icon")
//    }
}

/// Represent a single day of weather.
public struct DayWeather: WeatherElement {
    
    /// Day's celcius temperature
    public var temp: Double
    
    /// Day's celcius minimum temperature
    public var tempMin: Double
    
    /// Day's celcius maximum temperature
    public var tempMax: Double
    
    /// Day's conditions
    public var conditions: [Condition]
    
    public var date: Date
    
    /// Custom init.
    /// Instanciation from the API.
    /// Return nil if the Condition could not be well created.
    public init?(with JSON: [String: Any]) {
        guard let main = JSON["main"] as? [String: Any], let temp = main["temp"] as? Double,
            let tempMin = main["temp_min"] as? Double, let tempMax = main["temp_max"] as? Double,
            let timeInterval = JSON["dt"] as? TimeInterval,
            let weather = JSON["weather"] as? [[String: Any]], let conditions = Condition.create(contidions: weather) else {
                return nil
        }

        self.temp = temp
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.conditions = conditions
        self.date = Date(timeIntervalSince1970: timeInterval)
    }
    
//    required public init?(coder aDecoder: NSCoder) {
//        guard let conditions = aDecoder.decodeObject(forKey: "conditions") as? [Condition] else {
//                return nil
//        }
//
//        self.tempMax = aDecoder.decodeDouble(forKey: "tempMax")
//        self.temp = aDecoder.decodeDouble(forKey: "temp")
//        self.tempMin = aDecoder.decodeDouble(forKey: "tempMin")
//        self.conditions = conditions
//    }
//    
//    public func encode(with aCoder: NSCoder) {
//        aCoder.encode(temp, forKey: "temp")
//        aCoder.encode(tempMin, forKey: "tempMin")
//        aCoder.encode(tempMax, forKey: "tempMax")
//        aCoder.encode(conditions, forKey: "conditions")
//    }
}
