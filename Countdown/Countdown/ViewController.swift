//
//  ViewController.swift
//  Countdown
//
//  Created by Marko Jukic on 13/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var nstimer: NSTimer?
    var counting = false
    var counter = 0 {
        didSet(counter) {
            timer.text = String(self.counter)
            
            if self.counter > 0 && self.counter < 10 {
                timer.textColor = UIColor.redColor()
            } else {
                timer.textColor = UIColor.blackColor()
            }
            
            if self.counter == 0 {
                UIView.animateWithDuration(0.1, animations: {
                        self.timer.transform = CGAffineTransformMakeScale(10, 10)
                    }, completion: {
                        completed in UIView.animateWithDuration(0.1, animations: {
                            self.timer.transform = CGAffineTransformIdentity
                        })
                    
                    })
                timer.textColor = UIColor.greenColor()
                timer.text = "00000000"
            }
        }
    }

    @IBOutlet weak var timer: UILabel!

    @IBOutlet weak var startButton: UIButton!
    @IBAction func addTime(sender: AnyObject) {
        counter += 1000
    }
    
    @IBAction func startTimer(sender: AnyObject) {
        if counting {
            counting = false
            self.nstimer!.invalidate()
            counter = 0
            startButton.setTitle("Start", forState: UIControlState.Normal)
        } else {
            counting = true
            if counter == 0 {
                counter = 10
            }
            countDown()
            startButton.setTitle("Stop", forState: UIControlState.Normal)
        }
    }
    
    func countDown() -> Void {
        self.nstimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "reduceTimer", userInfo: nil, repeats: false)
    }
    
    func reduceTimer() -> Void {
        guard counter > 0 else {
            self.nstimer!.invalidate()
            startButton.setTitle("Start", forState: UIControlState.Normal)
            counting = false
            return
        }
        counter -= 1
        countDown()
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

