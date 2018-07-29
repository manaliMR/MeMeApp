//
//  ViewController.swift
//  MemeApp
//
//  Created by Manali Rami on 2018-06-25.
//  Copyright © 2018 Manali Rami. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

   
        
    @IBOutlet var ImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //text
        //textAlingment
        //defaultTextAttributes
        //textFieldDidBeginEditing
        
        //textFieldShouldReturn
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }
        
        @objc func keyboardWillShow(_ notification:Notification) {
            view.frame.origin.y = -getKeyboardHeight(notification)
            
        }
        func getKeyboardHeight(_ notification:Notification) -> CGFloat  {
        let userInfo = notification.userInfo
        let KeyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return KeyboardSize.cgRectValue.height
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
        func subscribeToKeyboardNotifications() {
            
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        }
        func unsubscribeToKeyboardNotifications() {
            NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        
    }
        


    
   
    @IBAction func PickImageFromAlbum(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
        let pickerController = UIImagePickerController()
       // present(pickerController, animated: true, completion: nil)
        
        let ImageViewPicker = UIImagePickerController()
        ImageViewPicker.delegate = self
        ImageViewPicker.sourceType = .photoLibrary
        self.present(ImageViewPicker, animated: true, completion: nil)
    }
    }

    @IBAction func PickAnImageFromCamera(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        let pickerController = UIImagePickerController()
        //present(pickerController, animated: true, completion: nil)
        
        let ImageViewPicker = UIImagePickerController()
        ImageViewPicker.delegate = self
        ImageViewPicker.sourceType = .camera
        self.present(ImageViewPicker, animated:true, completion: nil)
    }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        ImageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SaveImage(_ sender: Any) {
        let imageData = UIImageJPEGRepresentation(ImageView.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
    }
}


