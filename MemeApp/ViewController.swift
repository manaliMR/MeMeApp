//
//  ViewController.swift
//  MemeApp
//
//  Created by Manali Rami on 2018-06-25.
//  Copyright © 2018 Manali Rami. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
        
    @IBOutlet var ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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


