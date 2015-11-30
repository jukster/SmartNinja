//
//  ViewController.swift
//  ThreadingPlay
//
//  Created by Marko Jukic on 26/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView.progress = 0.6
        
        /*
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(10) * Int64(NSEC_PER_SEC)), dispatch_get_main_queue(), {
                self.progressView.progress = 0.9
            }

        )
        */
        
    }
    
    override func viewDidAppear {
        super.viewDidAppear()
        
}
        
        dispatch_async(<#T##queue: dispatch_queue_t##dispatch_queue_t#>, <#T##block: dispatch_block_t##dispatch_block_t##() -> Void#>)
        
        // Do any additional setup after loading the view, typically from a nib.
    }



}

