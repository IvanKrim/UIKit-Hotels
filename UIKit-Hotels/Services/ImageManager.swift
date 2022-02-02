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
    
    func fetchCropedImage(from imageURL: Endpoint) -> UIImageView  {
        let imageView = UIImageView()
        let downloadURL = imageURL.linkGenerator(path: imageURL)
        let placeholder = UIImage(systemName: "photo.fill")
        
        imageView.kf.setImage(
            with: downloadURL,
            placeholder: placeholder) { result in
                switch result {
                    
                case .success(let imageData):
                    let croppedImage = imageData.image.kf.crop(
                        to: CGSize(width: imageData.image.size.width * 0.95, height: imageData.image.size.height * 0.95),
                        anchorOn: CGPoint(x: 0.5, y: 0.5))
                    imageView.image = croppedImage
                    
                case .failure(let error):
                    print(error.isInvalidResponseStatusCode)
                }
            }
        
        return imageView
    }
    //    func fetchImage(from imageURL: Endpoint, completion: @escaping(Data, URLResponse) -> Void) {
    //        guard let downloadedURL = imageURL.linkGenerator(path: imageURL) else { return }
    //        URLSession.shared.dataTask(with: downloadedURL) { data, response, error in
    //            guard let data = data, let response = response else {
    //                print(error?.localizedDescription ?? "No Description")
    //                return
    //            }
    //
    //            DispatchQueue.main.async {
    //                completion(data, response)
    //            }
    //        }.resume()
    //    }
}
