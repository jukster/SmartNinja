//
//  ViewController.swift
//  imageViewer
//
//  Created by Marko Jukic on 02/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       let vc = segue.destinationViewController as! DetailViewController
       let button = sender as! UIButton
            
       vc.slika = button.imageForState(.Normal)!
    
    }


}

