//
//  LocationsManager.swift
//  WeatherLayout
//
//  Created by Marko Jukic on 28/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import Foundation

class LocationsManager {
    
    static let sharedInstance = LocationsManager()

    //var locations: [WeatherData] = [WeatherData]()
    
    var locations: [String] = [String]()
    
    func addLocation(location: String){

        locations.append(location)

    }
    
    var selectedLocationIndex: UInt?

    func removeLocation(location: String){

        locations.removeAtIndex(locations.indexOf(location)!)
        
        if UInt(locations.indexOf(location)!) == selectedLocationIndex {
                selectedLocationIndex = nil
            }

    }
    
    func saveItems(){
        
        NSUserDefaults.standardUserDefaults().setObject(locations, forKey: "locations")
        
        NSUserDefaults.standardUserDefaults().setObject(selectedLocationIndex, forKey: "selectedLocationIndex")

        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    func loadItems(){
        
        if let savedLocationIndex = NSUserDefaults.standardUserDefaults().objectForKey("selectedLocationIndex") as? UInt {
                selectedLocationIndex = savedLocationIndex
        }
        
        if let savedLocations = NSUserDefaults.standardUserDefaults().objectForKey("locations") as? [String] {
            locations = savedLocations
        }
        
    }

}