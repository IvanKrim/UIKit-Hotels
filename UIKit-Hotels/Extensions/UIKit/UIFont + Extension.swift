//
//  UIFont + Extension.swift
//  testProject
//
//  Created by Kalabishka Ivan on 10.01.2022.
//

import UIKit

extension UIFont {
    
    static func largeTitleText() -> UIFont? {
        return UIFont.init(name: "HelveticaNeue-Bold", size: 35)
    }
    
    static func firstTitleText() -> UIFont? {
        return UIFont.init(name: "HelveticaNeue-Bold", size: 22)
    }
    
    static func subheadingText() -> UIFont? {
        return UIFont.init(name: "HelveticaNeue-Bold", size: 20)
    }
    
    static func bodyText() -> UIFont? {
        return UIFont.init(name: "HelveticaNeue", size: 18)
    }
    
    static func bodyBoldText() -> UIFont? {
        return UIFont.init(name: "HelveticaNeue-Bold", size: 18)
    }
}
