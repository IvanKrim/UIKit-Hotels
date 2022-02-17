//
//  ImageManager.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 27.01.2022.
//

import UIKit

// class ImageManager {
//  
//  static let shared = ImageManager()
//  
//  private init() {}
//  
//  func fetchCropedImage(from imageURL: Endpoint, completion: @escaping (UIImageView) -> Void) {
//    let imageView = UIImageView()
//    let downloadURL = imageURL.linkManager(path: imageURL)
//    let placeholder = UIImage(systemName: "photo.fill")
//    
//    imageView.kf.setImage(
//      with: downloadURL,
//      placeholder: placeholder) { result in
//        switch result {
//          
//        case .success(let imageData):
//          let croppedImage = imageData.image.kf.crop(
//            to: CGSize(width: imageData.image.size.width * 0.95, height: imageData.image.size.height * 0.95),
//            anchorOn: CGPoint(x: 0.5, y: 0.5))
//          imageView.image = croppedImage
//          completion(imageView)
//          
//        case .failure(let error):
//          print(error.isInvalidResponseStatusCode)
//          completion(imageView)
//        }
//      }
//  }
// }

class ImageManager {
  static let shared = ImageManager()
  
  private init() {}
  
  func fetchImage(from imageURL: Endpoint) -> Data? {
    guard let url = imageURL.linkManager(path: imageURL) else { return nil}
    print(url)
    guard let imageData = try? Data(contentsOf: url) else { return nil }
    
    return imageData
  }
}
