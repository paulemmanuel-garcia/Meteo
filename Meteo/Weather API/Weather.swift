//
//  Weather.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 09/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import Foundation

public typealias GenericCompletion = ([String: Any]?, NSError?) -> ()
public typealias ForecastCompletion = (Forecast?, NSError?) -> ()
public typealias CurrentWeatherCompletion = (CurrentWeather?, NSError?) -> ()

enum APIEndpoints: String {
    case forecast = "forecast"
    case weather = "weather"
}

/// Wrapper to the openweathermap.org API.
public class Weather: NSObject {

    /// The API
    public static let api: Weather = Weather()

    override init() {
        self.apiKey = Bundle.main.object(forInfoDictionaryKey: "OWM_API_KEY") as? String ?? ""
        self.baseURL = "http://api.openweathermap.org/data/2.5"
        super.init()
        precondition(!self.apiKey.isEmpty)
    }

    private let apiKey: String

    private let baseURL: String

    // Get forecast: http://api.openweathermap.org/data/2.5/forecast/city?q=Paris,fr&units=metric&APPID=c9212844cf3e14d7624a016a3830327c

    // Get Current Weather: http://api.openweathermap.org/data/2.5/weather?q=Paris&units=metric&APPID=c9212844cf3e14d7624a016a3830327c
    public func getCurrentWeather(for city: String, completion: @escaping CurrentWeatherCompletion) {
        fetchData(service: .weather, city: city) {
            json, error in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let json = json else {
                completion(nil, NSError(domain: domain, code: GenericError.noData.rawValue, userInfo: [NSLocalizedDescriptionKey: "No data."]))
                return
            }

            DispatchQueue.main.async { completion(CurrentWeather(with: json), nil) }
        }
    }

    /// Fetch data either locally or through the API if the network is reachable.
    ///
    /// - Parameters:
    ///   - service: The specific endpoint of the API (eg: forecast, weather)
    ///   - city: The city to get the data for.
    ///   - completion: GenericCompletion handler.
    private func fetchData(service: APIEndpoints, city: String, completion: @escaping GenericCompletion) {
        if Reachability.isConnectedToNetwork() {
            fetchAPIData(service: service, city: city, completion: completion)
        } else {
            fetchLocalData(service: service, city: city, completion: completion)
        }
    }

    /// Fetch data from services the openweathermap API.
    ///
    /// - Parameters:
    ///   - service: The specific endpoint of the API (eg: forecast, weather)
    ///   - city: The city to get the data for.
    ///   - completion: GenericCompletion handler.
    private func fetchAPIData(service: APIEndpoints, city: String, completion: @escaping GenericCompletion) {
        
        /// Create the url to get the data from.
        guard let url = URL(string: "\(baseURL)/\(service.rawValue)?q=\(city)&units=metric&APPID=\(apiKey)") else {
            completion(nil, NSError(domain: domain, code: GenericError.urlCreation.rawValue, userInfo: [NSLocalizedDescriptionKey: "Unable to create url."]))
            return
        }
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            data, response, error in
            
            if let error = error {
                completion(nil, error as NSError?)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: domain, code: GenericError.noData.rawValue, userInfo: [NSLocalizedDescriptionKey: "No data."]))
                return
            }
            
            // Unserialize data
            completion((try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any], nil)
        }
        
        task.resume()
    }
    
    func fetchLocalData(service: APIEndpoints, city: String, completion: @escaping GenericCompletion) {
        fatalError("No implementation yet")
    }
}
