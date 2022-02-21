//
//  CroppedImage.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 17.02.2022.
//

import UIKit

class CroppedImage: UIView {
  private let hotelImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    
    return imageView
  }()
  
  private var imageCache = NSCache<AnyObject, AnyObject>()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .cellBackgroundSet
    
    addSubview(hotelImage)
    setupConstraint()
  }
  
  func convertImage(from imageURL: String, completion: @escaping() -> Void) {
    ImageManager.shared.fetchImageData(from: .image(imageURL)) { imageData in
      
      if let rawImage = UIImage(data: imageData) {
        self.hotelImage.image = self.cropImage(input: rawImage)
        self.hotelImage.contentMode = .scaleAspectFill
      } else {
        self.hotelImage.image = UIImage(systemName: "photo.on.rectangle.angled") // placeholder
      }
      completion()
    }
  }
  
  private func cropImage(input image: UIImage) -> UIImage? {
    let cgImage = image.cgImage
    let croppedCGImage = cgImage?.cropping(to: CGRect(
      x: 1, y: 1,
      width: image.size.width * 0.9,
      height: image.size.height * 0.9))
    
    return UIImage(cgImage: croppedCGImage!)
  }
  
  // MARK: - SetupConstraints
  func setupConstraint() {
    hotelImage.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      hotelImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
      hotelImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
      hotelImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
      hotelImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
