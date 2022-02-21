//
//  ImageManager.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 27.01.2022.
//

import Foundation

class ImageManager {
  static let shared = ImageManager()
  
  private init() {}
  
  private var imageCache = NSCache<NSURL, NSData>()
  
  func fetchImageData( from imageURL: Endpoint, completion: @escaping(Data) -> Void) {
    guard let imageURL = imageURL.linkManager(path: imageURL) else { return }
    
    if let imageDataFromCache = imageCache.object(forKey: imageURL as NSURL) as Data? {
      completion(imageDataFromCache)
    } else {
      URLSession.shared.dataTask(with: imageURL) { data, _, _ in
        guard let imageData = data else { return }
        
        DispatchQueue.main.async {
          self.imageCache.setObject(NSData(data: imageData), forKey: imageURL as NSURL)
          completion(imageData)
        }
      } .resume()
    }
  }
}
