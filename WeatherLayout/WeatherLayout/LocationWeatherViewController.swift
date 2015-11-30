//
//  ViewController.swift
//  WeatherLayout
//
//  Created by Marko Jukic on 07/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class LocationWeatherViewController: UIViewController {

    @IBOutlet weak var weatherDescription: UILabel!

    @IBOutlet weak var cityName: UILabel!

    @IBOutlet weak var degreesLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBAction func changeLocationButton(sender: AnyObject) {
    }

    let queue = NSOperationQueue()
    
    var currentWeather: WeatherData? {
        
        didSet {
            switch currentWeather!.weatherIcon {
            case .Cloudy:
                weatherIcon.image = UIImage(named: "cloud32.png")
            case .Rainy:
                weatherIcon.image = UIImage(named: "rain20.png")
            case .Sunny:
                weatherIcon.image = UIImage(named: "sun79.png")
            case .Unknown:
                weatherIcon.image = UIImage(named: "question-mark.png")
            }
            
            degreesLabel.text = currentWeather!.getTemperatureAsString()
            
            weatherDescription.text = currentWeather!.description
            
            cityName.text = currentWeather?.cityName.capitalizedString
        }
    }
        
    override func viewDidLoad() {
            
        super.viewDidLoad()
        
        queue.name = "queue za singleLocationVC"
        
        queue.maxConcurrentOperationCount = 1

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        if let currentLocationIndex = LocationsManager.sharedInstance.selectedLocationIndex {
            
            queue.addOperation(refreshWeatherForCell(indexPathOfCellToRefresh: NSIndexPath(forRow: Int(currentLocationIndex), inSection: 0), locationForCell: LocationsManager.sharedInstance.locations[Int(currentLocationIndex)], thisVC: self))
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}