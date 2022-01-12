//
//  UIImageView + Extension.swift
//  testProject
//
//  Created by Kalabishka Ivan on 29.12.2021.
//

import UIKit

extension UIImageView {

    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        self.image = image
        self.contentMode = contentMode
    }
}
