//
//  ViewController.swift
//  RandomPersonViewer
//
//  Created by Marko Jukic on 23/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        let request = NSMutableURLRequest()
        request.URL = NSURL(string: "https://randomuser.me/api/")
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            if let data = data {
                
                do {
                    let object = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
                    
                    if let dictionary = object as? [String: AnyObject]{
                        if let results = dictionary["results"] as? [AnyObject] {
                            if results.count > 0 {
                                if let user = results[0]["user"] as? [String: AnyObject] {
                                    
                                    let name = user["name"]!["first"]! as! String
                                    
                                    let url = user["picture"]!["large"]! as! String
                                    
                                    let imageData = NSData(contentsOfURL: NSURL(string: url)!)
                                    
                                    let image = UIImage(data: imageData!)
                                    
                                    dispatch_async(dispatch_get_main_queue(), {
                                        self.label.text = name
                                        self.imageView.image = image
                                    })
                                }
                            }
                        }
                    }
                } catch {
                    
                }
            }
            }
        task.resume()
        }
    
    }
