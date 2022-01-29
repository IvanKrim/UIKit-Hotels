//
//  UIImageView + Extension.swift
//  testProject
//
//  Created by Kalabishka Ivan on 10.01.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    convenience init(image: UIImage?, tintColor: UIColor) {
        self.init()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = image
        self.tintColor = tintColor
        self.contentMode = .scaleAspectFit
        
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        
        
    }
}




