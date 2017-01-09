//
//  MainViewController.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 09/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import UIKit

protocol UIWeatherElement {
    var city: String { get set }
}

class MainViewController: UIViewController {


    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var forecastView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        performSegue(withIdentifier: "Detail", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if var destination = segue.destination as? UIWeatherElement {
            destination.city = "Paris"
        }
    }
}

class UIWeatherElementViewSegue: UIStoryboardSegue {
    override func perform() {
        if let source = source as? MainViewController {
            destination.willMove(toParentViewController: source)
            source.addChildViewController(destination)
            
            var containerView: UIView?
            
            switch identifier {
            case "Detail"?:
                containerView = source.detailView
            case "Forecast"?:
                containerView = source.forecastView
            default:
                containerView = nil
            }
            
            containerView?.addSubview(destination.view)

            // Stretching `destination.view` to the `EventsViewController.headerview`
            destination.view.translatesAutoresizingMaskIntoConstraints = false
            containerView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[destinationView]|", options: NSLayoutFormatOptions(rawValue: UInt(0)), metrics: nil, views: ["destinationView": destination.view]))
            containerView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[destinationView]|", options: NSLayoutFormatOptions(rawValue: UInt(0)), metrics: nil, views: ["destinationView": destination.view]))
            
            destination.didMove(toParentViewController: source)
        }

    }
}
