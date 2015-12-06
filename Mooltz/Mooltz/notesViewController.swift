//
//  notesViewController.swift
//  Mooltz
//
//  Created by Marko Jukic on 11/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    @IBOutlet weak var inputTextView: UITextView!

    var delegate: receivesNotes?
    
    override func viewDidLoad() {

        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
   
    }

    @IBAction func saveNotes(sender: AnyObject) {

        delegate!.setItemNotes(inputTextView.text)
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    
}