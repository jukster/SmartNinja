//
//  ImageDetailViewController.swift
//  CollectionViewTest
//
//  Created by Marko Jukic on 18/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    var image: UIImage?

    @IBOutlet weak var imageDetailView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = self.image {
            imageDetailView.image = image
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