//
//  MemeViewController.swift
//  MemeApp
//
//  Created by Manali Rami on 2018-06-25.
//  Copyright © 2018 Manali Rami. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // IBOutlets added
        
       @IBOutlet weak var ImageView: UIImageView!
       @IBOutlet weak var AlbumButton: UIBarButtonItem!
       @IBOutlet weak var CameraButton: UIBarButtonItem!
       @IBOutlet weak var CancelButton: UIBarButtonItem!
       @IBOutlet weak var ShareButton: UIBarButtonItem!
       @IBOutlet weak var TopTextField: UITextField!
       @IBOutlet weak var BottomTextField: UITextField!
       @IBOutlet weak var Toolbar: UIToolbar!
       @IBOutlet weak var Navigationbar: UINavigationItem!
    
    // TextAttributes
    
    let memeTextAttributes:[String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -3.0
    
      ]
    
    // Function ViewDidLoad for top and bottom TextFields
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TopTextField.defaultTextAttributes = memeTextAttributes
        TopTextField.text = "Top"
        TopTextField.textAlignment = .center
        TopTextField.delegate = self
        
        BottomTextField.defaultTextAttributes = memeTextAttributes
        BottomTextField.text = "Bottom"
        BottomTextField.textAlignment = .center
        BottomTextField.delegate = self
    }
    
    // Function ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // availability of camera
        CameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        if ImageView.image == nil {
            ShareButton.isEnabled = false
        } else {
            ShareButton.isEnabled = true
        }
        
        // Keyboard will appear
        
        subscribeToKeyboardNotifications()
        
    }
   
    // Function viewWillDisappear
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Keyboard will Disappear
        
        unsubscribeToKeyboardNotifications()
    }
    
    // Resetting textFields and Image
    
    
    // Picking image from Album
   
    @IBAction func PickImageFromAlbum(_ sender: AnyObject) {
        
      if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
        
           let ImageViewPicker = UIImagePickerController()
           ImageViewPicker.delegate = self
           ImageViewPicker.sourceType = .photoLibrary
           self.present(ImageViewPicker, animated: true, completion: nil)
        }
        }
    
    // Picking image from direct camera
    
    @IBAction func PickImageFromCamera(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        
            let ImageViewPicker = UIImagePickerController()
            ImageViewPicker.delegate = self
            ImageViewPicker.sourceType = .camera
            self.present(ImageViewPicker, animated:true, completion: nil)
        }
        }
    
    // Sharing Function
    
    
    @IBAction func ShareOption(_ sender: AnyObject) {
    let memeImage = generateMemeImage()
        let activityController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil activityController.completionWithItemsHandler = { activity, success, items, error in
            self.saveMemeImage()
            self.dismiss(animated: true, completion: nil)
        }
        
            presentViewController(activityCntroller, animated: true, completion: nil)
    }
    
    // UIImagePickerControllerDelegate functions
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        ImageView.image = image
        dismiss(animated: true, completion: nil)
       
       }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
   
    
        
        //textFieldShouldReturn
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        view.frame.origin.y = -getKeyboardHeight(notification)
        
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat  {
        let userInfo = notification.userInfo
        let KeyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return KeyboardSize.cgRectValue.height
        
    }

    
}

