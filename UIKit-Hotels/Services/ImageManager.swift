//
//  ImageManager.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 27.01.2022.
//

import UIKit
import Kingfisher

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from imageURL: Endpoint, image: UIImageView)  {
        guard let downloadURL = imageURL.linkGenerator(path: imageURL) else { return }
        let placeholder = UIImage(systemName: "photo.fill")
        
        image.kf.setImage( with: downloadURL, placeholder: placeholder)
    }
}


