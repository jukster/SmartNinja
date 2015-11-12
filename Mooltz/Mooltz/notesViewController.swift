//
//  notesViewController.swift
//  Mooltz
//
//  Created by Marko Jukic on 11/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    var selectedItem: Item?
    
    @IBOutlet weak var taskDetails: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedItem?.name)
        print(selectedItem?.priority)
        let atributi = [NSFontAttributeName : mojFont!]
        let atributi_bold = [NSFontAttributeName : UIFont.boldSystemFontOfSize(19.0)]
        let makingString = NSMutableAttributedString(string: "Ime: ", attributes: atributi)
        
        makingString.appendAttributedString(NSAttributedString(string: (selectedItem?.name)!, attributes: atributi_bold))

        makingString.appendAttributedString(NSAttributedString(string: "\n", attributes: atributi))
        
        makingString.appendAttributedString(NSAttributedString(string: "Prioriteta: ", attributes: atributi))

        makingString.appendAttributedString(NSAttributedString(string: selectedItem!.priority!.description, attributes: atributi_bold))

        
        taskDetails.attributedText = makingString
    }

    
}