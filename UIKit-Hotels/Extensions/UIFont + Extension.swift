//
//  UIFont + Extension.swift
//  testProject
//
//  Created by Kalabishka Ivan on 28.12.2021.
//

import UIKit

extension UIFont {    
    static func titleText() -> UIFont? {
        return UIFont.init(name: "HelveticaNeue-Bold", size: 22)
    }
    
    static func bodyText() -> UIFont? {
        return UIFont.init(name: "HelveticaNeue", size: 18)
    }
    
    static func subheadingText() -> UIFont? {
        return UIFont.init(name: "HelveticaNeue-Bold", size: 20)
    }
}
