//
//  ViewController.swift
//  Mooltz
//
//  Created by Marko Jukic on 21/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class AddTasksViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    let myTaskManager = TaskManager()

    @IBOutlet weak var taskNameSelection: UITextField!
    
    @IBOutlet weak var taskPrioritySelection: UITextField!
    
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBAction func addTask(sender: AnyObject) {
        
        guard taskNameSelection.text != "" else {
            outputLabel.text = "Please enter a task name"
            return
            
        }
        
        guard ["Normal", "High"].contains(taskPrioritySelection.text!) else {
            outputLabel.text = "Please enter a priority of Normal or High!"
            return
            }

        let aItem = Item(name: taskNameSelection.text!, priority: Priority(rawValue: taskPrioritySelection.text!)!)
            if myTaskManager.items.contains(aItem) {
                outputLabel.text = "Item already exists"
            } else {
                myTaskManager.addItems(aItem)
                outputLabel.text = myTaskManager.description()
            }
        }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}