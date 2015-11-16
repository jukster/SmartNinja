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
    @IBOutlet weak var addTask: UIButton!
    
    @IBAction func addTask(sender: AnyObject) {

        guard taskNameSelection.text != "" else {
            outputLabel.text = "Please enter a task name"
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(CGPoint: CGPointMake(taskNameSelection.center.x - 10, taskNameSelection.center.y))
            animation.toValue = NSValue(CGPoint: CGPointMake(taskNameSelection.center.x + 10, taskNameSelection.center.y))
            taskNameSelection.layer.addAnimation(animation, forKey: "position")
            
            return
        }
        
        self.textFieldShouldReturn(taskNameSelection)
        let aItem = Item(name: taskNameSelection.text!, priority: Priority(rawValue: taskPrioritySelection.selectedSegmentIndex)!)
            print("about to add \(aItem.name) with id \(aItem.uID)")
            print(myTaskManager.items.contains(aItem))
            print(TaskManager.sharedInstance.items.contains(aItem))
            print(myTaskManager.items)
            if myTaskManager.items.contains(aItem) {
                outputLabel.text = "Item already exists"
            } else {
                myTaskManager.addItems(aItem)
                print("just added \(aItem.name)")
                print(myTaskManager.items)
                outputLabel.text = myTaskManager.description()
                lastAddedLabel.text = "Last item added was \(aItem.name)"
                
                UIView.animateWithDuration(0.1, delay: 0, options: [], animations: {
                        self.addTask.transform = CGAffineTransformMakeScale(1.5, 1.5)
                    
                    }, completion: {
                        completed in UIView.animateWithDuration(0.1, animations: {
                            self.addTask.transform = CGAffineTransformIdentity
                        })

                    })
            }
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.taskNameSelection.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "novItemLog", name: "itemName", object: nil)
        
        outputLabel.font = mojFont
        taskNameSelection.font = mojFont
        
        }
        
        
    func novItemLog() {
        //print("dodan item")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        saveItems(self)
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addImage" {
            let destViewController = segue.destinationViewController
            (destViewController as! AddImageViewController).delegate = self
        } else if segue.identifier == "viewNotesSegue" {
            let destViewController = segue.destinationViewController
            var lastItem: Item?
            for item in myTaskManager.items {
                if item.name == taskNameSelection.text {
                    lastItem = item
                }
            }
            (destViewController as! NotesViewController).selectedItem = lastItem!
        }
    }
    

    func textFieldShouldReturn(textfield: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true
    }
    
    func setImage(image: UIImage) {
        chosenImageView.contentMode = .ScaleAspectFit
        chosenImageView.image = image
        
        outputLabel.text = "Added image: " + String(image.size.width) + " x " + String(image.size.height)
    }


}