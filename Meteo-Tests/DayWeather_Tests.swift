//
//  DayWeather_Tests.swift
//  Meteo
//
//  Created by Paul-Emmanuel on 09/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import XCTest

class DayWeather_Tests: XCTestCase {
    
    let validData: [[String: Any]] = [
        ["id": 500, "description": "light showers", "icon": "10n"],
        ["id": 701, "description": "mist", "icon": "50n"]
    ]
    let halfValidData: [[String: Any]] = [
        ["id": "500", "description": "light showers", "icon": "10n"],
        ["id": 701, "description": "mist", "icon": "50n"]
    ]
    let invalidData: [[String: Any]] = [
        ["id": "500", "description": "light showers", "icon": "10n"],
        ["id": "701", "description": "mist", "icon": "50n"]
    ]
    
    func testConditionCreation() {
        let condition = Condition(with: validData.first!)
        XCTAssert(condition != nil)
    }
    
    func testContionsCreation() {
        let conditions = Condition.create(contidions: validData)
        XCTAssert(conditions != nil && !(conditions!.isEmpty))
    }
    
    func testHalfConditionsCreation() {
        let conditions = Condition.create(contidions: halfValidData)
        XCTAssert(conditions != nil && conditions!.count == 1)
    }
    
    func testFailedConditionsCreation() {
        let conditions = Condition.create(contidions: invalidData)
        XCTAssert(conditions == nil)
    }
}
