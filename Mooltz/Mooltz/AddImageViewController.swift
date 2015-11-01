//
//  addImageViewController.swift
//  Mooltz
//
//  Created by Marko Jukic on 01/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class AddImageViewController: UIViewController {
    var delegate: receivesImage?
    
    @IBOutlet weak var addedImage: UIImageView!
    
    @IBOutlet weak var imageSize: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let height = addedImage.image?.size.height
        let width = addedImage.image?.size.width

        imageSize.text = String(Int(width!)) + " * " + String(Int(height!))
    }
    
    @IBAction func confirmImageSelection(sender: AnyObject) {
        delegate?.setImage(addedImage.image!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}