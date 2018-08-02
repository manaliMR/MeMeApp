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
        
       @IBOutlet var ImageView: UIImageView!
       @IBOutlet var AlbumButton: UIBarButtonItem!
       @IBOutlet var CameraButton: UIBarButtonItem!
       @IBOutlet var ShareButton: UIBarButtonItem!
       @IBOutlet var CancelButton: UIBarButtonItem!
       @IBOutlet var TopTextField: UITextField!
       @IBOutlet var BottomTextField: UITextField!
       @IBOutlet var Toolbar: UIToolbar!
       @IBOutlet var NavigationBar: UINavigationBar!
    
    // TextAttributes
    
    let memeTextAttributes:[String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,
        NSAttributedStringKey.strokeWidth.rawValue: -3.0
    
      ]
    
    // Function ViewDidLoad for top and bottom TextFields
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TopTextField.defaultTextAttributes = memeTextAttributes
        TopTextField.text = "TOP"
        TopTextField.textAlignment = .center
        TopTextField.delegate = self
        
        BottomTextField.defaultTextAttributes = memeTextAttributes
        BottomTextField.text = "BOTTOM"
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
    
    @IBAction func resettingController(_ sender: AnyObject) {
        ImageView.image = nil
        ShareButton.isEnabled = false
        TopTextField.text = "TOP"
        BottomTextField.text = "BOTTOM"
    }
    
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
    
    @IBAction func ShareOption(_ sender: Any) {
    

    let memeImage = generateMemeImage()
        let activityController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil); activityController.completionWithItemsHandler = { activity, success, items, error in
            self.saveMemeImage()
            self.dismiss(animated: true, completion: nil)
        }
        
        present(activityController, animated: true, completion: nil)
    }
    
    
    
    // Saving the memeImage in library
    
    func saveMemeImage() {
        let memeImage = generateMemeImage()
        
        let meme = MemeEditor(topText: TopTextField.text!, bottomText: BottomTextField.text!, originalImage: ImageView.image!, memeImage: memeImage)
        
        // adding memeEditor to the application delegate swift file
        
        (UIApplication.shared.delegate as!
          AppDelegate).memes.append(meme)
    }
    
   
    // Image that combines ImageView and TextField
    
    func generateMemeImage()  -> UIImage {
        
        NavigationBar.isHidden = true
        Toolbar.isHidden = true
        
        // Editor view added to the image to be memed
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memeImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        NavigationBar.isHidden = false
        Toolbar.isHidden = false
        
        return memeImage
    }
    
    func prefersStatusBarHidden() -> Bool {
        return true
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
   
    // textField Editor
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == TopTextField && textField.text! == "TOP") || (textField == BottomTextField && textField.text! == "BOTTOM") {
            textField.text = ""
        }
    }
    
    //textFieldShouldReturn
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
        
        return false
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if BottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if BottomTextField.isFirstResponder {
            view.frame.origin.y = +getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat  {
        let userInfo = notification.userInfo
        let KeyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return KeyboardSize.cgRectValue.height
        
    }
}

