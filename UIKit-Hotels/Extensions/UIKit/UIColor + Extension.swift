//
//  UIColor + Extension.swift
//  testProject
//
//  Created by Kalabishka Ivan on 10.01.2022.
//

import UIKit

/// Сolor palette
extension UIColor {
  
//  static func textSet() -> UIColor {
//    return UIColor(named: "TextSet") ?? .systemBlue
//  }
//  
//  static func secondaryTextSet() -> UIColor {
//    return UIColor(named: "SecondaryTextSet") ?? .systemBlue
//  }
//  
//  static func textGraySet() -> UIColor {
//    return UIColor(named: "TextGraySet") ?? .systemBlue
//  }
//  
//  static func backgroundSet() -> UIColor {
//    return UIColor(named: "BackgroundSet") ?? .systemBackground
//  }
//  
//  static func secondaryBackgroundSet() -> UIColor {
//    return UIColor(named: "SecondaryBackgroundSet") ?? .systemBackground
//  }
//  
//  static func cellBackgroundSet() -> UIColor {
//    return UIColor(named: "CellBackgroundSet") ?? .systemBackground
//  }
//  
//  static func buttonColorSet() -> UIColor {
//    return UIColor(named: "ButtonColorSet") ?? .systemGray
//  }
//  
//  static func starIconColor() -> UIColor {
//    return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
//  }
  
  
  //
  static var textSet: UIColor {
    return UIColor(named: "TextSet") ?? .systemBlue
  }
  
  static var secondaryTextSet: UIColor {
    return UIColor(named: "SecondaryTextSet") ?? .systemBlue
  }
  
  static var textGraySet: UIColor {
    return UIColor(named: "TextGraySet") ?? .systemBlue
  }
  
  static var backgroundSet: UIColor {
    return UIColor(named: "BackgroundSet") ?? .systemBackground
  }
  
  static var secondaryBackgroundSet: UIColor {
    return UIColor(named: "SecondaryBackgroundSet") ?? .systemBackground
  }
  
  static var cellBackgroundSet: UIColor {
    return UIColor(named: "CellBackgroundSet") ?? .systemBackground
  }
  
  static var buttonColorSet: UIColor {
    return UIColor(named: "ButtonColorSet") ?? .systemGray
  }
  
  static var starIconColor: UIColor {
    return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
  }
}
