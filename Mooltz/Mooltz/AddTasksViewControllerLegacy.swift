//
//  ViewController.swift
//  Mooltz
//
//  Created by Marko Jukic on 21/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//
/*
import UIKit

class AddTasksViewControllerLegacy: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, receivesNotes {
    
    
    // outlets
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var lastAddedLabel: UILabel!
    @IBOutlet weak var taskNameSelection: UITextField!
    @IBOutlet weak var taskPrioritySelection: UISegmentedControl!
    @IBOutlet weak var outputLabel: UILabel!
    
    let myTaskManager = TaskManager.sharedInstance
    
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
        
        self.textFieldShouldReturn(taskNameSelection)
        
        var aItem: Item
        
        if let forceBackwardsDateInt = Int(taskNameSelection.text!) {
            aItem = Item(forceBackwardsDate: forceBackwardsDateInt)
            print("fudging item with backwardsDate")
            if myTaskManager.items!.contains(aItem) {
                outputLabel.text = "Item already exists"
            } else {
                myTaskManager.addItems(aItem)
                outputLabel.text = myTaskManager.description()
                lastAddedLabel.text = "Last item added was \(aItem.name)"
            }
            
        } else {
            print("normal item")
            aItem = Item(name: taskNameSelection.text!, priority: Priority(rawValue: taskPrioritySelection.selectedSegmentIndex)!)
            
            if let currentNotes = notes {
                aItem.notes = currentNotes
            }
            
            // priprava slike, če je bila ta vnešena, predvideva se, da je slika nova.
            if didSetPhoto {
                print("image je vnešen!")
                // tukaj določimo imagePath in shranimo sliko.
                
                let chosenImage = addPhotoButton.imageView!.image!
                
                let generatedName = generateImageName()
                
                let documentPath = getDocumentPath(generatedName)
                
                // v GCD queue damo shranjevanje
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                    
                    let imageData = NSData(data: UIImagePNGRepresentation(chosenImage)!)
                    
                    imageData.writeToFile(documentPath, atomically: true)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        NSNotificationCenter.defaultCenter().postNotificationName("didSaveImage", object: nil)
                        
                    })
                    
                }
                
                // Item dobi pot:
                
                aItem.imagePath = documentPath
    }
            
    // Item Saving
            
            //demo za prejšnje dni
            
            print("about to add \(aItem.name) with id \(aItem.uID)")
            print(myTaskManager.items.contains(aItem))
            print(TaskManager.sharedInstance.items.contains(aItem))
            print(myTaskManager.items)
            if myTaskManager.items.contains(aItem) {
                outputLabel.text = "Item already exists"
            } else {
                myTaskManager.addItems(aItem)
                print("Dodani item je tipa \(aItem.active)")
                print("just added \(aItem.name) with status \(aItem.active)")
                
                if let path = aItem.imagePath {
                    print("pot do slike: \(path)")
                }
                
                self.navigationController?.popViewControllerAnimated(true)
                
                print(myTaskManager.items)
                outputLabel.text = myTaskManager.description()
                lastAddedLabel.text = "Last item added was \(aItem.name)"
                
            }
        }
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
*/