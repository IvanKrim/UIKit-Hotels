//
//  UIColor + Extension.swift
//  testProject
//
//  Created by Kalabishka Ivan on 10.01.2022.
//

import UIKit

extension UIColor {

    static func textGray() -> UIColor {
        return #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
    }
    
    static func blueTextSet() -> UIColor {
        return UIColor(named: "textBlue") ?? .blue
    }
    
    static func generalTextSet() -> UIColor {
        return UIColor(named: "textGeneral") ?? .systemBackground
    }
    
    static func cellBackgroundSet() -> UIColor {
        return UIColor(named: "cellBackground") ?? .systemBackground
    }
    
    static func buttonColorSet() -> UIColor {
        return UIColor(named: "buttonColorSet") ?? .systemBackground
    }
    
    static func appBackgroundSet() -> UIColor {
        return UIColor(named: "appBackgroundSet") ?? .systemBackground
    }
    
    static func sortHotelVCBackgroundSet() -> UIColor {
        return UIColor(named: "sortHotelVCBackgroundSet") ?? .systemBackground
    }
    
    
    static func starsYellow() -> UIColor {
        return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    }
}
