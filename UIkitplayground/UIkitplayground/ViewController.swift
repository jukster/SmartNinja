//
//  ViewController.swift
//  UIkitplayground
//
//  Created by Marko Jukic on 09/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func sliderChanged(sender: UISlider) {
        spinner.alpha = CGFloat(sender.value)
    }

    @IBAction func switchChanged(sender: UISwitch) {
        if sender.on {
            UIView.animateWithDuration(2.0, animations: {
                self.spinner.center = CGPointMake(20.0, 20.0)
                }, completion: { success in UIView.animateWithDuration(1.0, animations: {
                        self.spinner.center = self.view.center
                    }
                )}
            )
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

