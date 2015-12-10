//
//  TestingPlaygroundTests.swift
//  TestingPlaygroundTests
//
//  Created by Marko Jukic on 07/12/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import XCTest
@testable import TestingPlayground

class TestingPlaygroundTests: XCTestCase {
    
    var car: Car?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        car = Car()
        
        car!.make = "VW"
        car!.model = "Passat"
        car!.speed = 40.0
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        car = nil
    }
    
    func testCarString() {
        
        let string = car?.carString()
        
        XCTAssert(string == "VW Passat", "String should be equal")
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testMaxSpeed() {
        
        let value = car!.maxSpeed()
        
        XCTAssert(value == car!.speed * 1.5, "Max speed should be the same")
        
        XCTAssert(true, "")
        
    }
    
}
