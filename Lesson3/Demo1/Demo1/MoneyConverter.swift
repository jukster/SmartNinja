//
//  MoneyConverter.swift
//  Demo1
//
//  Created by Marko Jukic on 20/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import Foundation

class Currency: CustomStringConvertible {
	var currencyName: String
	
	var description: String {
		get {
			return currencyName
		}
	}
	
	init (_ currencyName: String){
		self.currencyName = currencyName
	}
}

class MoneyConverter {
	
	let rates: [String:Double] = ["EURUSD": 1.1, "EUREUR": 1.0, "EURJPY": 135.0]
	
	func convert (value: Double, startCurrency: Currency, targetCurrency: Currency) -> (convertedValue : Double, targetCurrency: Currency)? {
		
		if let thisRate = rates[startCurrency.currencyName + targetCurrency.currencyName] {
			return (value * thisRate, targetCurrency)
		}
		else {
			print("Za \(startCurrency.currencyName)\(targetCurrency.currencyName) nimam tečaja.")
			return nil
		}
	}
	
	func displayRates() -> String {
		return "Te tečaje imam: " + rates.description
	}
}
