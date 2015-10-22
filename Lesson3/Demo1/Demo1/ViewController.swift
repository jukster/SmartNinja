//
//  ViewController.swift
//  Demo1
//
//  Created by Marko Jukic on 19/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var enterAmount: UITextField!
	
    @IBOutlet weak var destinationCurrency: UISegmentedControl!
	
	@IBOutlet weak var result: UILabel!

	@IBAction func convert(sender: AnyObject) {
		
		guard let destinationCurrencySelected = destinationCurrency.titleForSegmentAtIndex(destinationCurrency.selectedSegmentIndex) else {
				result.text = ""
				return
		}
			
		guard let amount = Double(enterAmount.text!) else {
			result.text = ""
			return
		}

		let from = Currency("EUR")

		let to = Currency(destinationCurrencySelected)
			
		
		let aConverter = MoneyConverter()
			
		let conversion = aConverter.convert(amount, startCurrency: from, targetCurrency: to)
			
		result.text = String(format: "%.2f ",conversion!.convertedValue) + conversion!.targetCurrency.description
		}

	
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

