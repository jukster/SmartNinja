//
//  MoneyConverter.swift
//  Demo1
//
//  Created by Marko Jukic on 20/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import Foundation


class Currency: CustomStringConvertible, Equatable, Comparable {
	var currencyName: String
	
	var description: String {
		get {
			return currencyName
		}
	}
	
	var rate: Double? {
		let rates: [String:Double] = ["USD": 1.1, "EUR": 1.0, "JPY": 135.0]
		return rates[self.currencyName]
	}
	
	init (_ currencyName: String){
		self.currencyName = currencyName
	}
	
}

func == (lhs: Currency, rhs: Currency) -> Bool {
	return lhs.rate == rhs.rate
}

func < (lhs: Currency, rhs: Currency) -> Bool {
	return lhs.rate < rhs.rate
}


class MoneyConverter {
	
	static let sharedInstance = MoneyConverter()
	
	func convert (value: Double, startCurrency: Currency, targetCurrency: Currency) -> (convertedValue : Double, rate: Double, targetCurrency: Currency)? {
		if let rate = targetCurrency.rate {
			return (convertedValue: value * rate, rate: rate, targetCurrency: targetCurrency)
		} else {
			return nil
		}
	
	}
	
}

extension Double {
	func convert (targetCurrency: Currency) -> (convertedValue: Double, rate: Double)? {
		let startCurrency = Currency("EUR")
		let moneyConveter = MoneyConverter.sharedInstance
		if let converted = moneyConveter.convert(self, startCurrency: startCurrency, targetCurrency: targetCurrency) {
			return (converted.convertedValue,converted.rate)
		} else {
			return nil
		}
	}

}