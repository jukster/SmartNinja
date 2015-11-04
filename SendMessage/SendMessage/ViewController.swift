//
//  ViewController.swift
//  SendMessage
//
//  Created by Marko Jukic on 02/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var enteredText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let lastMessage = NSUserDefaults.standardUserDefaults().objectForKey("currentMessage") as? String {
            enteredText.text = lastMessage
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func send(sender: AnyObject) {
        let tbvc = self.tabBarController as! CustomTabController
        tbvc.currentMessage = enteredText.text
        NSUserDefaults.standardUserDefaults().setObject(enteredText.text, forKey: "currentMessage")
    }

}