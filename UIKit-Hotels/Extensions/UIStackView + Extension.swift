//
//  UIStackView + Extension.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 12.01.2022.
//

import UIKit

extension UIStackView {
    
    // convenience init - расширение инициализатора
    // делаем универсальный инициализатор для стеквью
    convenience init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat
    ) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
    }
}
