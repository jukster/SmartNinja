//
//  Car.swift
//  TestingPlayground
//
//  Created by Marko Jukic on 07/12/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class Car: NSObject {
    var model: String = "Golf"
    
    var make: String = "WV"
    
    var engine: String = "2.0 TDI"
    
    var engineSpeedFactor = 1.5
    
    var speed: Double = 250.0
    
    func carString() -> String {

        return make + " " + model

    }
    
    func maxSpeed() -> Double {

        return speed * engineSpeedFactor

    }

}
