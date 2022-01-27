//
//  ImageManager.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 27.01.2022.
//

import Foundation
import Kingfisher

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func setupImage(from imageURL: Endpoint, image: UIImageView)  {
        guard let downloadURL = imageURL.linkGenerator(path: imageURL) else { return }
        
        let placeholder = UIImage(systemName: "photo.fill")
        let processor   = CroppingImageProcessor(size: CGSize(width: 700, height: 350))
        
        image.kf.setImage(
            with: downloadURL,
            placeholder: placeholder,
            options: [
                .processor(processor)
            ])
        { result in
            
            switch result {
            case .success(let value):
                print(value.cacheType)
                print(value.image.size)
            case .failure(let error):
                print(error.isInvalidResponseStatusCode)
            }
        }
    }
}
