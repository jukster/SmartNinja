//
//  DelegateExample.swift
//  Mooltz
//
//  Created by Marko Jukic on 29/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import Foundation

@objc protocol CarDriver: NSObjectProtocol {
    func turnOnEngine()
    func driveCar(loop: Int)
    optional func turnOffEngine(engineType: UInt)
}

class Car {
    var delegate: CarDriver?
    
    func runCar() {
        if let driver = delegate {
            driver.turnOnEngine()
            
            for i in 1...5 {
                driver.driveCar(i)
            }
            if driver.respondsToSelector("turnOffEngine:") {
                driver.performSelector("turnOffEngine:", withObject: 0)
            }
        }
    }
}

class Person: NSObject, CarDriver {
    func turnOnEngine() {
        print("TURN ON ENGINE")
    }
    
    func driveCar(loop: Int) {
        print("DRIVING MY TESLA \(loop)x")
    }
    
    func turnOffEngine(engineType: UInt) {
        print("TURN OFF ENGINE")
    }
}

func driverExample() {
    let car = Car()
    
    let person = Person()
    
    car.delegate = person
    
    car.runCar()
}