//
//  UIView + Extension.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 01.02.2022.
//

import UIKit

extension UIView {
  func addSubviews(_ views: [UIView]) {
    views.forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
  }
}
