//
//  ViewController.swift
//  Demo1
//
//  Created by Marko Jukic on 19/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.enterAmount.delegate = self
    }
    
    @IBOutlet weak var enterAmount: UITextField!
	
    @IBOutlet weak var destinationCurrency: UISegmentedControl!
	
	@IBOutlet weak var result: UILabel!

	@IBOutlet weak var locationInformation: UILabel!
	
	@IBAction func convert(sender: AnyObject) {
		
		let formatter = NSNumberFormatter()
		formatter.locale = NSLocale.currentLocale()
		
		guard let destinationCurrencySelected = destinationCurrency.titleForSegmentAtIndex(destinationCurrency.selectedSegmentIndex) else {
				result.text = ""
				return
		}
			
		guard let amount = formatter.numberFromString(enterAmount.text!) else {
			print(Double(enterAmount.text!))
			result.text = ""
			return
		}

		let targetCurrency = Currency(destinationCurrencySelected)
		
		if let convertedValue = (amount as Double).convert(targetCurrency) {
			result.text = String(format: "%.2f ", convertedValue.convertedValue) + targetCurrency.description + " @ " + String(format: "%.4f", convertedValue.rate)
			self.textFieldShouldReturn(enterAmount)
		}
	}

	var locationManager: CLLocationManager!

    @IBAction func getLocation(sender: AnyObject) {
		locationManager = CLLocationManager()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.requestLocation()
    }
	
	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
		let geocoder = CLGeocoder()
		geocoder.reverseGeocodeLocation(locations.first!, completionHandler: {(placemarks, error) -> Void in
			guard error == nil else {
				self.locationInformation.text = "Error: \(error)"
				return
			}
			if let aPlacemark = placemarks?[0]{
				// rabim index for segment with title
				if let index = locationsCurrencies[aPlacemark.ISOcountryCode!] {
					self.destinationCurrency.selectedSegmentIndex = index
					if index == -1 {
						self.locationInformation.text = "You are in Euroland! No conversion necessary."
					} else {
						self.locationInformation.text = "Now in \(aPlacemark.ISOcountryCode!)"
					}
				} else {
					self.destinationCurrency.selectedSegmentIndex = 0
					self.locationInformation.text = "No rate for \(aPlacemark.ISOcountryCode!), assuming USD"
				}
			}
		})
	}
	
	func locationManager(manager: CLLocationManager,
		didFailWithError error: NSError) {
			print("Error determining user location: \(error)")
	}
	
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		self.view.endEditing(true)
	}

	func textFieldShouldReturn(textfield: UITextField) -> Bool {
		textfield.resignFirstResponder()
		return true
	}

}

