//
//  HotelDetailsViewController.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 10.01.2022.
//

import UIKit

class HotelDetailsViewController: UIViewController {
  
  private let hotelImageView: UIImageView = {
    var image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.layer.cornerRadius = 2
    image.clipsToBounds = true
    
    return image
  }()
  
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
//    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    
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
  
  var viewModel: HotelDetailsViewModelProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    setupUI()
  }
  
  private func setupUI() {
    setupConstraints(with: viewModel.stars)
    
    navigationItem.title = viewModel.hotelName
    hotelNameLabel.text = viewModel.hotelName
    hotelAddress.text = viewModel.hotelAddress
    suitesAvailability.text = viewModel.suitesAvailability
  }
  
//  @objc private func buttonTapped() {
//    let mapScreenVC = MapScreenViewController()
//    mapScreenVC.hotel = hotel
//
//    navigationController?.pushViewController(mapScreenVC, animated: true)
//  }
}

// MARK: - Fetch Data
//extension HotelDetailsViewController {
//  func fetchData(with hotelID: Int?) {
//    guard let id = hotelID else { return }
//
//    networkService.getHotelInformation(with: id) { result in
//
//      switch result {
//      case .success(let hotel):
//        self.hotel = hotel
//        self.setupContent(with: hotel)
//        guard let imageURL = hotel.imageHandler else { return }
//
//        self.cropImageProcessor(from: .image(imageURL))
//
//      case .failure(let error):
//        self.showAlert(
//          with: error.localizedDescription,
//          and: "Please try again later or contact Support.")
//      }
//    }
//  }
//
//}

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
    
    hotelImageView.translatesAutoresizingMaskIntoConstraints = false
    contentStackView.translatesAutoresizingMaskIntoConstraints = false
    mapButton.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(scrollView)
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
  }
}