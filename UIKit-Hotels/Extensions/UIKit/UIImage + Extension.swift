//
//  UIImage + Extension.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 14.01.2022.
//

import UIKit

extension UIImage {
    static func emptyStarIcon() -> UIImage! {
        return UIImage.init(systemName: "star")
    }
    
    static func filledStarIcon() -> UIImage! {
        return UIImage.init(systemName: "star.fill")
    }
    
    static func distanseIcon() -> UIImage! {
        return UIImage.init(systemName: "mappin.circle")
    }
    
}
