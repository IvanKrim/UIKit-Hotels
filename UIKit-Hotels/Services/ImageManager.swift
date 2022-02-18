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
  
  var simpleImage = UIImage()
  
  func fetchImage(from imageURL: Endpoint) -> Data? {
    guard let url = imageURL.linkManager(path: imageURL) else { return nil}
    guard let imageData = try? Data(contentsOf: url) else { return nil }
    
    return imageData
  }
  
  func convertImage(from data: Data?) -> UIImage {
    if let imageData = data {
      let rawImage = UIImage(data: imageData)!
      simpleImage = cropImage(input: rawImage)!
    } else {
      simpleImage = UIImage(named: "Golf")!
    }
    return simpleImage
  }
  
  private func cropImage(input image: UIImage) -> UIImage? { // получаем исходное изображение
    let cgImage = image.cgImage
    
    let croppedCGImage = cgImage?.cropping(to: CGRect(
      x: 1, y: 1,
      width: image.size.width * 0.9,
      height: image.size.height * 0.9))
    
    return UIImage(cgImage: croppedCGImage!) // возвращаем кропнутое
  }
}

class HotelImage: UIImageView {
  
  let placeHolder: HotelImage = {
    let image = HotelImage()
    image.image = UIImage(systemName: "Golf")
    image.contentMode = .scaleToFill
    image.layer.cornerRadius = 2
    image.clipsToBounds = true
    
    return image
  }()
  
  private func fetchImage(from imageURL: Endpoint) -> Data? {
    guard let url = imageURL.linkManager(path: imageURL) else { return nil}
    guard let imageData = try? Data(contentsOf: url) else { return nil }
    
    return imageData
  }
  
  func convertImage(from imageURL: String) {
    let fetchImage = fetchImage(from: .image(imageURL))
    
    if let imageData = fetchImage {
      let rawImage = UIImage(data: imageData)!
      image = cropImage(input: rawImage)!
    } else {
      
    }
  }
  
  private func cropImage(input image: UIImage) -> UIImage? { // получаем исходное изображение
    let cgImage = image.cgImage
    
    let croppedCGImage = cgImage?.cropping(to: CGRect(
      x: 1, y: 1,
      width: image.size.width * 0.9,
      height: image.size.height * 0.9))
    
    return UIImage(cgImage: croppedCGImage!) // возвращаем кропнутое
  }
}
