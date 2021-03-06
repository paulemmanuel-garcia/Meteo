//
//  ForecastViewController.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 09/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import UIKit

public class ForecastViewController: UIViewController, UIWeatherElement {
    
    public var city: String = ""
    
    
    fileprivate var forecast: Forecast?
    
    @IBOutlet weak var tableView: UITableView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        
        Weather.api.getForecast(for: city) {
            forecast, error in
            self.forecast = forecast
            if let _ = forecast {
                self.tableView.reloadData()
            }
        }
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast?.days.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DayWeather") as? ForecastTableViewCell else {
            return UITableViewCell()
        }
        
        cell.dayWeather = forecast!.days[indexPath.row]
        
        return cell
    }
}
