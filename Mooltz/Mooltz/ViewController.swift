//
//  ViewController.swift
//  Mooltz
//
//  Created by Marko Jukic on 21/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class AddTasksViewController: UIViewController, UITextFieldDelegate, receivesImage {
    
    let myTaskManager = TaskManager.sharedInstance
    
    @IBOutlet weak var lastAddedLabel: UILabel!
    @IBOutlet weak var taskNameSelection: UITextField!
    @IBOutlet weak var taskPrioritySelection: UISegmentedControl!
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var chosenImageView: UIImageView!
    
    @IBAction func addTask(sender: AnyObject) {

        guard taskNameSelection.text != "" else {
            outputLabel.text = "Please enter a task name"
            return
        }

        self.textFieldShouldReturn(taskNameSelection)
        let aItem = Item(name: taskNameSelection.text!, priority: Priority(rawValue: taskPrioritySelection.selectedSegmentIndex)!)
            if myTaskManager.items.contains(aItem) {
                outputLabel.text = "Item already exists"
            } else {
                myTaskManager.addItems(aItem)
                outputLabel.text = myTaskManager.description()
                lastAddedLabel.text = "Last item added was \(aItem.name)"
            }
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded: \(self.debugDescription)")
        self.taskNameSelection.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // outputLabel.text = ""
        
        if let itemName = NSUserDefaults.standardUserDefaults().objectForKey("itemName") as? String {
            taskNameSelection.text = itemName
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "novItemLog", name: "itemName", object: nil)
        
        }
        
        
    func novItemLog() {
        print("dodan item")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addImage" {
            let destViewController = segue.destinationViewController
            (destViewController as! AddImageViewController).delegate = self
        }
    }
    
    func textFieldShouldReturn(textfield: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true
    }
    
    func setImage(image: UIImage) {
        chosenImageView.contentMode = .ScaleAspectFit
        chosenImageView.image = image
        
        //outputLabel.text = "Added image: " + String(image.size.width) + " x " + String(image.size.height)
    }


}