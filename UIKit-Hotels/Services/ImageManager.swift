//
//  ImageManager.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 27.01.2022.
//

import UIKit

class ImageManager {
  static let shared = ImageManager()
  
  private init() {}
  
  func fetchImageData(from imageURL: Endpoint) -> Data? {
    guard let url = imageURL.linkManager(path: imageURL) else { return nil}
    guard let imageData = try? Data(contentsOf: url) else { return nil }
    
    return imageData
  }
}
