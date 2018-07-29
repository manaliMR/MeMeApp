//
//  MemeEditor.swift
//  MemeApp
//
//  Created by Manali Rami on 2018-07-29.
//  Copyright © 2018 Manali Rami. All rights reserved.
//


import Foundation
import UIKit

struct MemeEditor {
    
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memeImage: UIImage
    
    // Constructor
    
    init(topText: String, bottomText: String, originalImage: UIImage, memeImage: UIImage) {
        
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memeImage = memeImage
        
    }
}

