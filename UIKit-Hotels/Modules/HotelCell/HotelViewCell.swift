//
//  TableViewCell.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 06.01.2022.
//

import UIKit

class HotelViewCell: UITableViewCell {
  // MARK: - Properties
  private let hotelImageView = CroppedImage()
  private let activityIndicator = SpinnerView()
  
  private let hotelNameLabel = UILabel(
    fontStyle: .firstTitleText, textColor: .textSet, numberOfLines: 2)
  private let distanceIconImage = UIImageView(
    image: UIImage.distanseIcon(), tintColor: .textGraySet)
  private let distanceToCenterLabel = UILabel(
    textColor: .gray, numberOfLines: 2)
  private let availableSuitesLabel = UILabel(
    fontStyle: .bodyBoldText, textColor: .secondaryTextSet)
  
  var viewModel: HotelCellViewModelProtocol! {
    didSet {
      hotelNameLabel.text = viewModel.hotelName
      distanceToCenterLabel.text = viewModel.distanceToCenter
      availableSuitesLabel.text = viewModel.availableSuites
      setupConstraints(with: viewModel.stars)
      
      viewModel.fetchImage { imageData in
        self.hotelImageView.convertImage(from: imageData) {
          self.activityIndicator.spinnerViewStopAnimating()
          self.activityIndicator.isHidden = true
        }
      }
    }
  }
  
  // MARK: - Lifecycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.backgroundColor = .clear
  }
  
  required init?(coder: NSCoder) {
    fatalError("init?(coder: has not been implemented")
  }
}

// MARK: - Setup Constraints
extension HotelViewCell {
  private func setupConstraints(with stars: Double) {
    
    let cellBackgroundView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .cellBackgroundSet
      view.layer.cornerRadius = 2
      view.layer.shadowColor = UIColor.black.cgColor
      view.layer.shadowRadius = 5
      view.layer.shadowOpacity = 0.1
      view.layer.shadowOffset = CGSize(width: 2, height: 2)
      
      return view
    }()
    
    let starsArray = StarsIcon.shared.starsConverter(input: stars)
    
    let starsStackView = UIStackView(
      arrangedSubviews: starsArray,
      axis: .horizontal,
      spacing: 3)
    
    let distanceStackView = UIStackView(
      arrangedSubviews: [distanceIconImage, distanceToCenterLabel],
      axis: .horizontal,
      spacing: 3)
    
    let generalStackView = UIStackView(
      arrangedSubviews: [hotelNameLabel, starsStackView, availableSuitesLabel, distanceStackView],
      axis: .vertical,
      spacing: 20)
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    hotelImageView.translatesAutoresizingMaskIntoConstraints = false
    generalStackView.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(cellBackgroundView)
    addSubview(activityIndicator)
    
    cellBackgroundView.addSubviews([hotelImageView, generalStackView])
    
    NSLayoutConstraint.activate([
      cellBackgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
      cellBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
      cellBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
      cellBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6)
    ])
    
    NSLayoutConstraint.activate([
      hotelImageView.widthAnchor.constraint(equalTo: cellBackgroundView.widthAnchor, multiplier: 0.3),
      hotelImageView.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 0),
      hotelImageView.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 0),
      hotelImageView.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: 0)
    ])
    
    NSLayoutConstraint.activate([
      generalStackView.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 4),
      generalStackView.leadingAnchor.constraint(equalTo: hotelImageView.trailingAnchor, constant: 8),
      generalStackView.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -8),
      generalStackView.bottomAnchor.constraint(lessThanOrEqualTo: cellBackgroundView.bottomAnchor, constant: -4)
    ])
    
    NSLayoutConstraint.activate([
      activityIndicator.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor),
      activityIndicator.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor),
      activityIndicator.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor),
      activityIndicator.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor)
    ])
  }
}
