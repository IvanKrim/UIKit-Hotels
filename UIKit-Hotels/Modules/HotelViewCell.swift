//
//  TableViewCell.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 06.01.2022.
//

import UIKit
import Kingfisher

class HotelViewCell: UITableViewCell {
  // MARK: - Properties
  private var hotelImageView: UIImageView = {
    var image = UIImageView()
    image.contentMode   = .scaleAspectFill
    image.clipsToBounds = true
    return image
  }()
  
  private let networkService: NetworkServiceSingleHotelProtocol = NetworkService()
  private let hotelNameLabel = UILabel(
    style: .firstTitleText(),textColor: .textSet(), numberOfLines: 2)
  private let distanceIconImage = UIImageView(
    image: UIImage.distanseIcon(), tintColor: .textGraySet())
  private let distanceToCenterLabel = UILabel(
    textColor: .gray, numberOfLines: 2)
  private let availableSuitesLabel = UILabel(
    style: .bodyBoldText(), textColor: .secondaryTextSet())
  
  // MARK: - Lifecycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = .clear
  }
  
  required init?(coder: NSCoder) {
    fatalError("init?(coder: has not been implemented")
  }
  
  // MARK: - Public Methods
  public func setupContent(with hotel: Hotel) {
    hotelNameLabel.text = hotel.name
    distanceToCenterLabel.text = "\(hotel.distance) meters to the center"
    availableSuitesLabel.text = "Available rooms: \(hotel.suitesArray.count)"
    
    setupConstraints(with: hotel.stars)
    fetchImage(with: hotel.id)
  }
}

extension HotelViewCell {
  private func fetchImage(with hotelID: Int) {
    networkService.getHotelInformation(with: hotelID) { [self] result in
      
      switch result {
      case .success(let hotel):
        guard let imageURL = hotel.imageHandler else { return }
        self.cropImageProcessor(from: .image(imageURL))
        
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  private func cropImageProcessor(from imageURL: Endpoint) {
    ImageManager.shared.fetchCropedImage(from: imageURL) { [unowned self] in
      self.hotelImageView.image = $0.image
    }
  }
}

// MARK: - Setup Constraints
extension HotelViewCell {
  private func setupConstraints(with stars: Double) {
    
    let view: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .cellBackgroundSet()
      view.layer.cornerRadius = 2
      view.layer.shadowColor = UIColor.black.cgColor
      view.layer.shadowRadius = 5
      view.layer.shadowOpacity = 0.1
      view.layer.shadowOffset = CGSize(width: 2, height: 2)
      
      return view
    }()
    
    let starsArray = StarsIcon.shared.starsConverter(input: stars)
    
    let emptyImageView = UIImageView()
    emptyImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
    
    let starsStackView = UIStackView(
      arrangedSubviews: starsArray,
      axis: .horizontal,
      spacing: 3)
    
    let distanseStackView = UIStackView(
      arrangedSubviews: [distanceIconImage ,distanceToCenterLabel, emptyImageView],
      axis: .horizontal,
      spacing: 3)
    
    let generalStackView = UIStackView(
      arrangedSubviews: [hotelNameLabel, starsStackView, availableSuitesLabel, distanseStackView],
      axis: .vertical,
      spacing: 20)
    
    hotelImageView.translatesAutoresizingMaskIntoConstraints = false
    generalStackView.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(view)
    view.addSubviews([hotelImageView, generalStackView])
    
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
      view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
      view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
      view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6)
    ])
    
    NSLayoutConstraint.activate([
      hotelImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
      hotelImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
      hotelImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
      hotelImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
    ])
    
    NSLayoutConstraint.activate([
      generalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
      generalStackView.leadingAnchor.constraint(equalTo: hotelImageView.trailingAnchor, constant: 8),
      generalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
      generalStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -4)
    ])
  }
}
