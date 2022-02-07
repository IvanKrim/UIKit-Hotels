//
//  String + Extension.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 07.02.2022.
//

import Foundation

extension String {
  static func suitesArrayConverter(array: [String]) -> String {
    var convertedArray = ""
    
    array.forEach { room in
      convertedArray += "・\(room)"
    }
    
    return convertedArray
  }
}
