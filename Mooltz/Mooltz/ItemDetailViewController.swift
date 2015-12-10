//
//  ItemDetailViewController.swift
//  Mooltz
//
//  Created by Marko Jukic on 06/12/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemTextDetails: UITextView!
    
    var selectedItem: CDItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        if let thisItem = selectedItem {
            itemImage.image = thisItem.hasImage?.imageRef!

            let displayString = NSMutableAttributedString()

            displayString.appendAttributedString(NSAttributedString(string: "Location: \(thisItem.location.description)\n", attributes: [NSFontAttributeName: mojFontBold!]))
            
            if let itemNotes = thisItem.notes {
                
                displayString.appendAttributedString(NSAttributedString(string: itemNotes, attributes: [NSFontAttributeName: mojFont!]))
            }


            
            itemTextDetails.attributedText = displayString
            
            self.title = thisItem.name

            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
