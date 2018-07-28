//
//  ViewController.swift
//  MemeApp
//
//  Created by Manali Rami on 2018-06-25.
//  Copyright © 2018 Manali Rami. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    
    
    @IBOutlet var ImageViewPicker: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

   

    @IBAction func PickImageFromAlbum(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        present(pickerController, animated: true, completion: nil)
        
        let ImageViewPicker = UIImagePickerController()
        ImageViewPicker.delegate = self
        ImageViewPicker.sourceType = .photoLibrary
        present(ImageViewPicker, animated: true, completion: nil)
    }

    @IBAction func PickAnImageFromCamera(_ sender: Any) {
        let pickerController = UIImagePickerController()
        present(pickerController, animated: true, completion: nil)
        
        let ImageViewPicker = UIImagePickerController()
        ImageViewPicker.delegate = self
        present(ImageViewPicker, animated:true, completion: nil)
    }
}


