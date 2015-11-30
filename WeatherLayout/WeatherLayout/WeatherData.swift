//
//  WeatherData.swift
//  WeatherLayout
//
//  Created by Marko Jukic on 25/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import Foundation
import UIKit

struct WeatherData {
    
    let cityName: String
    
    let temperature: Double?
    
    let description: String
    
    let weatherIcon: Weather
    
    init() {
        
        self.cityName = "Unknown"
        
        self.description = ""
        
        self.weatherIcon = Weather.Unknown
        
        self.temperature = nil
    
    }
    
    init(cityName: String, temperature: Double, description: String, main: String) {
        
        self.cityName = cityName
        
        self.temperature = temperature
        
        self.description = description

        switch main {
        case "Sunny":
            self.weatherIcon = Weather.Sunny
        case "Rain":
            self.weatherIcon = Weather.Rainy
        default:
            self.weatherIcon = Weather.Cloudy
        }
    }
    
    func getTemperatureAsString() -> String? {
        
        if temperature != nil {
            return NSString.localizedStringWithFormat("%.0f°", temperature!) as String
        } else {
            return nil
        }
        
    }
}


enum Weather: String {
    case Cloudy, Sunny, Rainy, Unknown
}

class CustomView: UIView {
    var weatherData: WeatherData?
}

class refreshWeatherForCell: NSOperation {
    
    var indexPathOfCellToRefresh: NSIndexPath
    
    let thisVC: UIViewController?
    
    let locationForCell: String
    
    init(indexPathOfCellToRefresh: NSIndexPath, locationForCell: String, thisVC: UIViewController) {
        
        self.thisVC = thisVC
        
        self.indexPathOfCellToRefresh = indexPathOfCellToRefresh
        
        self.locationForCell = locationForCell
        
    }
    
    override func main() {
        let request = NSMutableURLRequest()
        
        request.URL = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + self.locationForCell.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())! + "&appid=ff1b0f99ca54bb95eaa651b7409bcef2&units=metric")
        
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            
            guard (data != nil) else {
                return
            }
            
            guard error == nil else {
                return
            }
            
            do {
                
                let object = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
                
                let dictionary = object as! [String: AnyObject]
                
                let nodeWeatherResults = dictionary["weather"] as? [AnyObject]
                
                let main = (nodeWeatherResults![0]["main"] as? String)!
                
                let description = (nodeWeatherResults![0]["description"] as? String)!
                
                let temperature = dictionary["main"]!["temp"] as! Double
                
                let returnedWeatherData = WeatherData(cityName: self.locationForCell, temperature: temperature, description: description, main: main)
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    if let singleLocationVC = self.thisVC as? LocationWeatherViewController {
                        
                        singleLocationVC.currentWeather = returnedWeatherData
                        
                    }
                    
                    if let tableVC = self.thisVC as? WeatherLocationsTableController {

                        tableVC.tableView.cellForRowAtIndexPath(self.indexPathOfCellToRefresh)?.detailTextLabel?.text = returnedWeatherData.getTemperatureAsString()
                        
                    }
                    
                    
                    
                    //tableView.cellForRowAtIndexPath(self.indexPathOfCellToRefresh)?.detailTextLabel?.text = returnedWeatherData.getTemperatureAsString()
                    //self.delegate?.currentWeather = WeatherData(cityName: enteredLocation, temperature: temperature, description: description, main: main)
                    
                    
                })
                
                
                
            } catch {
                print("Error reaching API")
            }
        }
        task.resume()
    }
}