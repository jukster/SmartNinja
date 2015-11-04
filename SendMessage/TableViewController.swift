//
//  TableViewController.swift
//  SendMessage
//
//  Created by Marko Jukic on 02/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var archivedTextDisplay: UITextView!
    
    override func viewWillAppear(animated: Bool) {
        let tbvc = self.tabBarController as! CustomTabController
        archivedTextDisplay.text = tbvc.currentMessage
    }

}
