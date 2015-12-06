//
//  ViewController.swift
//  Mooltz
//
//  Created by Marko Jukic on 21/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class AddTasksViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, receivesNotes {
    
    // outlets
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var lastAddedLabel: UILabel!
    @IBOutlet weak var taskNameSelection: UITextField!
    @IBOutlet weak var taskPrioritySelection: UISegmentedControl!
    @IBOutlet weak var outputLabel: UILabel!
    
    let myItemManager = ItemManager.sharedInstance
    
    let photoPicker = UIImagePickerController()
    
    var didSetPhoto = false
    
    var notes: String?
        
    // add Photo funcionality
    
    @IBAction func addPhoto(sender: AnyObject) {        
        photoPicker.allowsEditing = false
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            photoPicker.sourceType = .Camera
        } else {
            photoPicker.sourceType = .PhotoLibrary
        }
        
        presentViewController(photoPicker, animated: true, completion: nil)

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {

            addPhotoButton.setImage(pickedImage, forState: .Normal)
            didSetPhoto = true
            
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    // Saving Item
    @IBAction func saveItem(sender: AnyObject) {
        // no task name
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
        
        //self.textFieldShouldReturn(taskNameSelection)
        
        print("normal item")
        
        myItemManager.addItem(taskNameSelection.text!, priority: Priority(rawValue: taskPrioritySelection.selectedSegmentIndex)!, notes: notes, hasImage: addPhotoButton.imageView?.image)
        
        //myItemManager.loadAllItems()
       
        self.navigationController?.popViewControllerAnimated(true)
        
        //outputLabel.text = myItemManager.description()
        //lastAddedLabel.text = "Last item added was \(aItem.name)"
            
    }
    
    func setItemNotes(incomingNotes: String) {
        notes = incomingNotes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.taskNameSelection.delegate = self
        
        self.photoPicker.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        
        }
        
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewNotesSegue" {
            let destViewController = segue.destinationViewController
            
            (destViewController as! NotesViewController).delegate = self
        }
    }

    func textFieldShouldReturn(textfield: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true
    }
    

}