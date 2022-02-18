//
//  TableViewCell.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 06.01.2022.
//

import UIKit

class HotelViewCell: UITableViewCell {
  
  // MARK: - Properties
  private var hotelImageView: UIImageView = {
    var image = UIImageView()
    image.contentMode   = .scaleAspectFill
    image.clipsToBounds = true
    return image
  }()
  
  //  let hotelImageView = CroppedImage()
  
  private let hotelNameLabel = UILabel(
    fontStyle: .firstTitleText, textColor: .textSet, numberOfLines: 2)
  private let distanceIconImage = UIImageView(
    image: UIImage.distanseIcon(), tintColor: .textGraySet)
  private let distanceToCenterLabel = UILabel(
    textColor: .gray, numberOfLines: 2)
  private let availableSuitesLabel = UILabel(
    fontStyle: .bodyBoldText, textColor: .secondaryTextSet)
  
  private var activityIndicator = UIActivityIndicatorView()
  
  private let backgroundViewCell: UIVisualEffectView = {
    let view = UIVisualEffectView()
    let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
    view.effect = blurEffect
    
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  var viewModel: HotelCellViewModelProtocol! {
    didSet {
      hotelNameLabel.text = viewModel.hotelName
      distanceToCenterLabel.text = viewModel.distanceToCenter
      availableSuitesLabel.text = viewModel.availableSuites
      setupConstraints(with: viewModel.stars)
      
      viewModel.fetchImage { [self] imageData in
        let hotelImage = ImageManager.shared.convertImage(from: imageData)
        self.hotelImageView.image = hotelImage
        
        self.spinnerViewStopAnimating()
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

// MARK: - Setup Activity Indicator
extension HotelViewCell {
  
  private func showSpinnerView(in view: UIView) {
    activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = UIColor.textSet
    activityIndicator.startAnimating()
    activityIndicator.hidesWhenStopped = true
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    backgroundViewCell.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(backgroundViewCell)
    backgroundViewCell.contentView.addSubview(activityIndicator)
    
    NSLayoutConstraint.activate([
      backgroundViewCell.topAnchor.constraint(equalTo: view.topAnchor),
      backgroundViewCell.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      backgroundViewCell.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      backgroundViewCell.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: backgroundViewCell.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: backgroundViewCell.centerYAnchor)
    ])
  }
  
  private func spinnerViewStopAnimating() {
    activityIndicator.startAnimating()
    backgroundViewCell.isHidden = true
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
    
    let distanseStackView = UIStackView(
      arrangedSubviews: [distanceIconImage, distanceToCenterLabel],
      axis: .horizontal,
      spacing: 3)
    
    let generalStackView = UIStackView(
      arrangedSubviews: [hotelNameLabel, starsStackView, availableSuitesLabel, distanseStackView],
      axis: .vertical,
      spacing: 20)
    
    hotelImageView.translatesAutoresizingMaskIntoConstraints = false
    generalStackView.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(cellBackgroundView)
    cellBackgroundView.addSubviews([hotelImageView, generalStackView])
    showSpinnerView(in: cellBackgroundView)
    
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
  }
}
