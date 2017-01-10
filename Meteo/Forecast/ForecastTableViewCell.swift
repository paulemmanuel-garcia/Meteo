//
//  ForecastTableViewCell.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 10/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var _dayWeather: DayWeather?
    public var dayWeather: DayWeather? {
        get {
            return _dayWeather
        }
        set {
            _dayWeather = newValue
            dateLabel.text = _dayWeather?.date.format(as: "dd/MM") ?? ""
            
            if let temp = _dayWeather?.temp {
                tempLabel.text = "\(temp)"
            } else {
                tempLabel.text = "No temperature available"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
