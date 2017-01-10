//
//  ForecastTableViewCell.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 10/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import UIKit
import ImageLoader

class ForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    private var _dayWeather: DayWeather?
    public var dayWeather: DayWeather? {
        get {
            return _dayWeather
        }
        set {
            _dayWeather = newValue
            guard let weather = newValue else {
                return
            }
            
            dateLabel.text = weather.date.format(as: "dd/MM")

            tempLabel.text = "\(weather.temp)"
            iconImageView.load(with: iconBaseUrl + (weather.conditions.first?.icon ?? "01d") + ".png")
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
    
    
    override func prepareForReuse() {
        iconImageView.image = nil
    }
}
