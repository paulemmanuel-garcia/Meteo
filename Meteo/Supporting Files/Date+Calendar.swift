//
//  Date+Calendar.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 10/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import Foundation

extension Date {
    
    func format(as formatPattern: String) -> String {
        let dateFormatter = DateFormatter()
        
        // "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.dateFormat = formatPattern
        return dateFormatter.string(from: self)
    }
    
    var hour: Int {
        get {
            let calendar = Calendar(identifier: .gregorian)
            return calendar.component(.hour, from: self)
        }
    }
    
    var day: Int {
        get {
            let calendar = Calendar(identifier: .gregorian)
            return calendar.component(.day, from: self)
        }
    }
    
    var month: Int {
        get {
            let calendar = Calendar(identifier: .gregorian)
            return calendar.component(.month, from: self)
        }
    }
    
    var year: Int {
        get {
            let calendar = Calendar(identifier: .gregorian)
            return calendar.component(.year, from: self)
        }
    }
    
    func compare(with date: Date) -> Bool {
        return date.day == self.day && date.month == self.month && date.year == self.year
    }
}
