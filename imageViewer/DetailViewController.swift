//
//  DetailViewController.swift
//  imageViewer
//
//  Created by Marko Jukic on 02/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    var slika: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = slika
    }
}