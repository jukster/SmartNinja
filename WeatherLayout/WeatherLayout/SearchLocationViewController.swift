//
//  SearchLocationViewController.swift
//  WeatherLayout
//
//  Created by Marko Jukic on 24/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit
import Alamofire

class SearchLocationViewController: UIViewController {
    @IBOutlet weak var failureLabel: UILabel!
    
    @IBOutlet weak var enteredLocation: UITextField!
    
    @IBAction func searchForLocations(sender: AnyObject) {
        guard enteredLocation.text != "" else {
            print("nothing entered")
            return
        }
        /*
        if let newLocation = enteredLocation.text {
            delegate?.currentCity = newLocation
            LocationsManager.sharedInstance.addLocation(newLocation)
        }

        delegate?.currentWeather = WeatherData()
        */
        
        getWeatherLocationAF(enteredLocation.text!)
        
        
    }
    
    var delegate: WeatherLocationsTableController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getWeatherLocationAF("Stockholm")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeatherLocationAF(enteredLocation: String){
        Alamofire.request(.GET, "http://api.openweathermap.org/data/2.5/weather",
                parameters:[
                "q": enteredLocation.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())!,
                "appid":"ff1b0f99ca54bb95eaa651b7409bcef2",
                "units":"metric"]
            ).responseJSON() { response in
            
            if response.result.isSuccess {
                
                guard let _ = response.result.value!.valueForKey("weather") else {
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.failureLabel.text = "No matches for location."
                        
                    })
                    return
                    
                }
                
                LocationsManager.sharedInstance.addLocation(enteredLocation)
                
                let locationIndex = LocationsManager.sharedInstance.locations.indexOf(enteredLocation)
                
                LocationsManager.sharedInstance.selectedLocationIndex = UInt(locationIndex!)
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.navigationController?.popToRootViewControllerAnimated(true)
                })
            }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func getWeatherData(enteredLocation: String) {
    
    let request = NSMutableURLRequest()
    
    request.URL = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + enteredLocation.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())! + "&appid=ff1b0f99ca54bb95eaa651b7409bcef2&units=metric")
    
    request.HTTPMethod = "GET"
    
    let session = NSURLSession.sharedSession()
    
    let task = session.dataTaskWithRequest(request) {
    (data, response, error) -> Void in
    
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    do {
    let object = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
    
    let dictionary = object as! [String: AnyObject]
    
    guard let nodeWeatherResults = dictionary["weather"] as? [AnyObject] else {
    dispatch_async(dispatch_get_main_queue(), {
    
    //self.delegate?.currentWeather = WeatherData()
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    
    })
    
    return
    
    }
    
    let main = (nodeWeatherResults[0]["main"] as? String)!
    
    let description = (nodeWeatherResults[0]["description"] as? String)!
    
    let temperature = dictionary["main"]!["temp"] as! Double
    
    dispatch_async(dispatch_get_main_queue(), {
    
    //self.delegate?.currentWeather = WeatherData(cityName: enteredLocation, temperature: temperature, description: description, main: main)
    //LocationsManager.sharedInstance.addLocation(WeatherData(cityName: enteredLocation, temperature: temperature, description: description, main: main))
    LocationsManager.sharedInstance.addLocation(enteredLocation)
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    
    
    
    })
    
    
    
    } catch {
    print("Error reaching API")

    guard (data != nil) else {
    return
    }
    
    guard error == nil else {
    return
    }
    
    do {
    let object = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
    
    let dictionary = object as! [String: AnyObject]
    
    guard let nodeWeatherResults = dictionary["weather"] as? [AnyObject] else {
    dispatch_async(dispatch_get_main_queue(), {
    
    //self.delegate?.currentWeather = WeatherData()
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    
    })
    
    return
    
    }
    
    let main = (nodeWeatherResults[0]["main"] as? String)!
    
    let description = (nodeWeatherResults[0]["description"] as? String)!
    
    let temperature = dictionary["main"]!["temp"] as! Double
    
    dispatch_async(dispatch_get_main_queue(), {
    
    //self.delegate?.currentWeather = WeatherData(cityName: enteredLocation, temperature: temperature, description: description, main: main)
    LocationsManager.sharedInstance.addLocation(WeatherData(cityName: enteredLocation, temperature: temperature, description: description, main: main))
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    
    
    })
    
    
    
    } catch {
    print("Error reaching API")
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    }
    task.resume()
    }
    */

}
