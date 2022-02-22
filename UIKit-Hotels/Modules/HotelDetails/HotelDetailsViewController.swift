//
//  HotelDetailsViewController.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 10.01.2022.
//

import UIKit

class HotelDetailsViewController: UIViewController {
  // MARK: - Properties
  private let activityIndicator = SpinnerView()
  private let hotelImageView = CroppedImage()
  
  private let hotelNameLabel = UILabel(
    fontStyle: .firstTitleText,
    textColor: .textSet,
    numberOfLines: 0)
  
  private let hotelAddress = UILabel(textColor: .textGraySet, numberOfLines: 0)
  private let suitesAvailability = UILabel(textColor: .secondaryTextSet, numberOfLines: 0)
  
  private let availableSuitesLabel = UILabel(
    text: "Available rooms:", fontStyle: .bodyBoldText, textColor: .secondaryTextSet)
  
  private lazy var mapButton: UIButton = {
    let button = UIButton(
      title: "Watch on map", titleColor: .white,
      backgroundColor: .buttonColorSet, font: .bodyText,
      isShadow: true, cornerRadius: 10)
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    
    return button
  }()
  
  private lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 1)
  
  private lazy var scrollView: UIScrollView = {
    let view = UIScrollView(frame: .zero)
    view.backgroundColor = .systemBackground
    view.frame = self.view.bounds
    view.contentSize = contentViewSize
    view.autoresizingMask = .flexibleHeight
    view.bounces = true
    view.showsHorizontalScrollIndicator = true
    
    return view
  }()
  
  private lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBackground
    view.frame = self.view.bounds
    view.frame.size = contentViewSize
    
    return view
  }()
  
  var viewModel: HotelDetailsViewModelProtocol! {
    didSet {
      viewModel.fetchHotel { imageData in
        print(imageData)
        self.hotelImageView.convertImage(from: imageData) {
          self.activityIndicator.spinnerViewStopAnimating()
          self.activityIndicator.isHidden = true
        }
      }
    }
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    setupUI()
  }
  
  // MARK: - Private Methods
  private func setupUI() {
    setupConstraints(with: viewModel.stars)
    navigationItem.title = viewModel.hotelName
    hotelNameLabel.text = viewModel.hotelName
    hotelAddress.text = viewModel.hotelAddress
    suitesAvailability.text = viewModel.suitesAvailability
    
  }
  
  @objc private func buttonTapped() {
    let mapScreenVC = MapScreenViewController()
    mapScreenVC.hotel = viewModel.transferData
    
    navigationController?.pushViewController(mapScreenVC, animated: true)
  }
}

// MARK: - Setup Constraints
extension HotelDetailsViewController {
  private func setupConstraints(with stars: Double) {
    
    let starsArray = StarsIcon.shared.starsConverter(input: stars)
    
    let starsStackView = UIStackView(
      arrangedSubviews: starsArray,
      axis: .horizontal,
      spacing: 0)
    
    let availableRoomsStackView = UIStackView(
      arrangedSubviews: [availableSuitesLabel, suitesAvailability],
      axis: .vertical,
      spacing: 6)
    
    let contentStackView = UIStackView(
      arrangedSubviews: [hotelNameLabel, starsStackView, hotelAddress, availableRoomsStackView, mapButton],
      axis: .vertical,
      spacing: 20)
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    hotelImageView.translatesAutoresizingMaskIntoConstraints = false
    contentStackView.translatesAutoresizingMaskIntoConstraints = false
    mapButton.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(scrollView)
    view.addSubview(activityIndicator)
    scrollView.addSubview(containerView)
    containerView.addSubview(hotelImageView)
    containerView.addSubview(contentStackView)
    
    NSLayoutConstraint.activate([
      mapButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15)
    ])
    
    NSLayoutConstraint.activate([
      hotelImageView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
      hotelImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
      hotelImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
      hotelImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3 / 4)
    ])
    
    NSLayoutConstraint.activate([
      contentStackView.topAnchor.constraint(equalTo: hotelImageView.bottomAnchor, constant: 20),
      contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
      contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
    ])
    
    NSLayoutConstraint.activate([
      activityIndicator.topAnchor.constraint(equalTo: view.topAnchor),
      activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    ])
  }
}
