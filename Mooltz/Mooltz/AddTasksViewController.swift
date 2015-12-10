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

    @IBOutlet weak var locationSelection: UISegmentedControl!
    @IBOutlet weak var outputLabel: UILabel!
    
    let myItemManager = ItemManager.sharedInstance
    
    let photoPicker = UIImagePickerController()
    
    var didSetPhoto = false
    
    var savedImageName: String?
    
    var notes: String?
        
    // add Photo funcionality
    
    @IBAction func addPhoto(sender: AnyObject) {        
        photoPicker.allowsEditing = true

        let tapAlert = UIAlertController(title: "Add photo", message: "Choose photo source:", preferredStyle:UIAlertControllerStyle.ActionSheet)
        
        tapAlert.addAction(UIAlertAction(title: "Take photo", style: .Default) { action in
            
            self.photoPicker.sourceType = .Camera
    
            
            self.presentViewController(self.photoPicker, animated: true, completion: nil)

            })
        
        tapAlert.addAction(UIAlertAction(title: "Choose from library", style: .Default) { action in
            
            
            self.photoPicker.sourceType = .PhotoLibrary
            
            
            self.presentViewController(self.photoPicker, animated: true, completion: nil)
            
            })
        
        self.presentViewController(tapAlert, animated: true, completion: nil)    
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            savedImageName = ItemManager.sharedInstance.storeImage(pickedImage)
                    
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
        
        myItemManager.addItem(taskNameSelection.text!, location: Location(rawValue: locationSelection.selectedSegmentIndex)!, notes: notes, savedImageName: savedImageName)
        
        //myItemManager.refreshItemsFromCD()
        
       
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
    
    override func viewDidAppear(animated: Bool) {
        self.taskNameSelection.becomeFirstResponder()
        print(didSetPhoto)
        if let savedImageName = savedImageName {
            print(savedImageName)
        } else {
            print("no saved Image")
        }
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