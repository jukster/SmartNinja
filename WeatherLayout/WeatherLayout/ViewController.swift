//
//  ViewController.swift
//  WeatherLayout
//
//  Created by Marko Jukic on 07/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var degreesLabel: UILabel!
    
    let iconview = CustomView()
    
    let frame = CGRect(x: 20, y: 20, width: 150, height: 150)
    
    let iconImageView = UIImageView()
    
    
    override func viewDidLoad() {
        //iconview.backgroundColor = UIColor.redColor()
        iconview.frame = frame
        iconview.alpha = 0
        iconview.addSubview(iconImageView)

        self.view.addSubview(iconview)

        iconImageView.frame = frame

        iconview.weather = Weather.Rainy

        switch iconview.weather {
        case .Cloudy:
            iconImageView.image = UIImage(named: "cloud32.png")
        case .Rainy:
            iconImageView.image = UIImage(named: "rain20.png")
        case .Sunny:
            iconImageView.image = UIImage(named: "sun79.png")
        }

        UIView.animateWithDuration(2.0, animations: {
            self.cityName.center.x = 0
            self.degreesLabel.center.y = 400
            self.iconview.alpha = 1
            })

        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

enum Weather: String {
    case Cloudy, Sunny, Rainy
}

class CustomView: UIView {
    var weather: Weather = Weather.Sunny
}