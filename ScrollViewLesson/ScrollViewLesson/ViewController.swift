//
//  ViewController.swift
//  ScrollViewLesson
//
//  Created by Marko Jukic on 19/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageView: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
        let image = UIImage(named:"1.jpg")
        
        imageView = UIImageView(image: image)
        
        scrollView.addSubview(imageView!)
        
        scrollView.contentSize = image!.size
        
        scrollView.delegate = self
        
        scrollView.maximumZoomScale = 2.0
        
        /* višina viewa / višina slike. Zakaj pusti 32px?  */
        
        scrollView.minimumZoomScale = scrollView.bounds.height / image!.size.height
        
        let recognizer = UIRotationGestureRecognizer(target: self, action: "rotated:")
        
        imageView!.addGestureRecognizer(recognizer)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
    
    func rotated(recognizer: UIRotationGestureRecognizer) {
        if recognizer.state == .Changed {
            imageView!.transform = CGAffineTransformMakeRotation(recognizer.rotation)
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return imageView
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
    }


}