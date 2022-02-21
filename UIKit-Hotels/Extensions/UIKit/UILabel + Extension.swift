//
//  UILabel + Extension.swift
//  testProject
//
//  Created by Kalabishka Ivan on 10.01.2022.
//

import UIKit

extension UILabel {
  
  convenience init(
    text: String? = "",
    fontStyle: UIFont? = .bodyText,
    textColor: UIColor? = .none,
    numberOfLines: Int = 1) {
      self.init()
      self.text = text
      self.font = fontStyle
      self.textColor = textColor
      self.numberOfLines = numberOfLines
    }
}
