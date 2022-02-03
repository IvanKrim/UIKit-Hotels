//
//  UIButton + Extension.swift
//  testProject
//
//  Created by Kalabishka Ivan on 10.01.2022.
//

import UIKit

extension UIButton {
  
  convenience init(
    title: String,
    titleColor: UIColor,
    backgroundColor: UIColor,
    font: UIFont? = .bodyText(),
    isShadow: Bool? = true,
    cornerRadius: CGFloat = 0
  ) {
    self.init(type: .system)
    self.setTitle(title, for: .normal)
    self.setTitleColor(titleColor, for: .normal)
    self.backgroundColor = backgroundColor
    self.titleLabel?.font = font
    self.layer.cornerRadius = cornerRadius
    
    if isShadow ?? false {
      self.layer.shadowColor = UIColor.black.cgColor
      self.layer.shadowRadius = 4
      self.layer.shadowOpacity = 0.2
      self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
  }
}

