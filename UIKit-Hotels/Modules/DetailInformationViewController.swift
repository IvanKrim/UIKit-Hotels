//
//  DetailInformationViewController.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 10.01.2022.
//

import UIKit
import Kingfisher

class DetailInformationViewController: UIViewController {
  
  private let networkService: NetworkServiceSingleHotelProtocol = NetworkService()
  
  private let hotelImageView: UIImageView = {
    var image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.layer.cornerRadius = 2
    image.clipsToBounds = true
    
    return image
  }()
  
  private let hotelNameLabel = UILabel(style: .firstTitleText(), textColor: .textSet(), numberOfLines: 0)
  private let hotelStarsLabel = UILabel()
  private let hotelAddres = UILabel(textColor: .textGraySet(), numberOfLines: 0)
  private let suitesAvailability = UILabel(textColor: .secondaryTextSet(), numberOfLines: 0)
  private let availableSuitesLabel = UILabel(
    text: "Available rooms:", style: .bodyBoldText(), textColor: .secondaryTextSet())
  
  private let mapButton: UIButton = {
    let button = UIButton(
      title: "Watch on map", titleColor: .white,
      backgroundColor: .buttonColorSet(), font: .bodyText(),
      isShadow: true, cornerRadius: 10)
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    
    return button
  }()
  
  private var hotel: Hotel?
  
  lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 1)
  
  lazy var scrollView: UIScrollView = {
    let view = UIScrollView(frame: .zero)
    view.backgroundColor = .systemBackground
    view.frame = self.view.bounds
    view.contentSize = contentViewSize
    view.autoresizingMask = .flexibleHeight
    view.bounces = true
    view.showsHorizontalScrollIndicator = true
    return view
  }()
  
  lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBackground
    view.frame = self.view.bounds
    view.frame.size = contentViewSize
    
    return view
  }()
  
  var hotelID: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    fetchData(with: hotelID)
  }
  
  private func setupContent(whith hotel: Hotel) {
    setupConstraints(with: hotel.stars)
    
    navigationItem.title = hotel.name
    hotelNameLabel.text = hotel.name
    hotelAddres.text = hotel.address
    suitesAvailability.text = suitesArrayConverter(array: hotel.suitesArray)
  }
  
  @objc private func buttonTapped() {
    let mapScreenVC = MapScreenViewController()
    mapScreenVC.hotel = hotel
    
    navigationController?.pushViewController(mapScreenVC, animated: true)
  }
  
  private func suitesArrayConverter(array: [String]) -> String {
    var convertedArray = ""
    
    array.forEach { room in
      convertedArray += "・\(room)"
    }
    
    return convertedArray
  }
}

// MARK: - Fetch Data
extension DetailInformationViewController {
  func fetchData(with hotelID: Int?) {
    guard let id = hotelID else { return }
    
    networkService.getHotelInformation(with: id) { result in
      switch result {
      case .success(let hotel):
        self.hotel = hotel
        self.setupContent(whith: hotel)
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
extension DetailInformationViewController {
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
      arrangedSubviews: [hotelNameLabel, starsStackView, hotelAddres, availableRoomsStackView, mapButton],
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
      contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
    ])
  }
}
