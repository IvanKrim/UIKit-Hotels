//
//  StarsIcon.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 01.02.2022.
//

import UIKit

class StarsIcon {
  
  static let shared = StarsIcon()
  
  private init() {}
  
  private func starIcon(image: UIImage) -> UIImageView {
    let icon = UIImageView(image: image, tintColor: .starIconColor)
    icon.translatesAutoresizingMaskIntoConstraints = false
    
    return icon
  }
  
  func starsConverter(input: Double) -> [UIImageView] {
    let starsMaximum = 5
    let emptyView: UIImageView = {
      let imageView = UIImageView()
      imageView.setContentHuggingPriority(
        UILayoutPriority(rawValue: 1),
        for: .horizontal)
      
      return imageView
    }()
    
    var starsArray: [UIImageView] = []
    for _ in 0..<Int(input) {
      starsArray.append(starIcon(image: UIImage.filledStarIcon()))
    }
    
    while starsArray.count !=  starsMaximum {
      starsArray.append(starIcon(image: UIImage.emptyStarIcon()))
    }
    starsArray.append(emptyView)
    return starsArray
  }
}
