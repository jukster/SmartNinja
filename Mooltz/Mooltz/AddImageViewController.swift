//
//  addImageViewController.swift
//  Mooltz
//
//  Created by Marko Jukic on 01/11/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import UIKit

class AddImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var delegate: receivesImage?

    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var addedImage: UIImageView!
    @IBOutlet weak var imageSize: UILabel!
    
    @IBAction func addImage(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            addedImage.contentMode = .ScaleAspectFit
            addedImage.image = pickedImage
            imageSize.text = String(addedImage.image!.size.width) + "x" + String(addedImage.image!.size.height)
            
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }

    @IBAction func confirmImageSelection(sender: AnyObject) {
        self.delegate!.setImage(addedImage.image!)
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}