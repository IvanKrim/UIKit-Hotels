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
    private let avatarBackground: UIImageView = {
        var image = UIImageView()
        image.contentMode   = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
//
//    private var uiImageAva = UIImage(systemName: "stars")
//    private let uiImageViewAva = UIImageView()
    
    private let networkService: NetworkServiceSingleHotelProtocol = NetworkService()
    
    private var distanceIconImage = UIImageView(image: UIImage.distanseIcon(), tintColor: .textGray())
    private var hotelNameLabel = UILabel(style: .titleText(), numberOfLines: 2)
    private let distanceToCenterLabel = UILabel(text: "5км до центра", textColor: .gray)
    
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: has not been implemented")
    }
    
    // MARK: - Public Methods
    public func setupContent(with hotel: Hotel) {
        hotelNameLabel.text = hotel.name
        distanceToCenterLabel.text = "\(hotel.distance) м до центра"
        
        setupConstraints(with: hotel.stars)
        fetchImage(with: hotel.id)
    }
}

// MARK: - Setup Stars Array
extension HotelViewCell {
    private func starIcon(image: UIImage) -> UIImageView {
        let icon = UIImageView(image: image, tintColor: .starsYellow())
        
        return icon
    }
    
    private func starsConverter(input: Double) -> [UIImageView] {
        let starsMaximum = 5
        var starsArray: [UIImageView] = []
        
        for _ in 0..<Int(input) {
            starsArray.append(starIcon(image: UIImage.filledStarIcon()))
        }
        
        while starsArray.count !=  starsMaximum {
            starsArray.append(starIcon(image: UIImage.emptyStarIcon()))
        }
        return starsArray
    }
}

// MARK: - Kingfisher Image Manager
extension HotelViewCell {
    private func setupImage(with imageURL: Endpoint) {
        
        guard let downloadURL = imageURL.linkGenerator(path: imageURL) else { return }
        
        let resource    = ImageResource(downloadURL: downloadURL)
        let placeholder = UIImage(systemName: "house")
        let processor   = RoundCornerImageProcessor(cornerRadius: 100)
    
        self.avatarBackground.kf.indicatorType = .activity
        self.avatarBackground.kf.setImage(
            with: resource,
            placeholder: placeholder,
            options: [.processor(processor)]) { result in
                self.completionHandler(result)
            }
    }
    
    private func completionHandler(_ result: Result<RetrieveImageResult, KingfisherError> ) {
        switch result {
        case .success(let retrieveImageResult):
            let image = retrieveImageResult.image
            
        case .failure(let error):
            print(error)
        }
    }
    
    // MARK: Fetch Image Method
    private func fetchImage(with hotelID: Int) {
        networkService.getHotelInformation(with: hotelID) { result in
            switch result {
                
            case .success(let hotel):
                guard let imageID = hotel.image else { return }
                self.setupImage(with: .image(imageID))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Setup Constraints
extension HotelViewCell {
    private func setupConstraints(with stars: Double) {
        
        let starsArray = starsConverter(input: stars)
        
        avatarBackground.frame.size.width = self.frame.width / 3
//        avatarBackground.layer.frame.size.width = contentView.frame.width / 3
        print("avatarBackground.frame.size.width \(avatarBackground.frame.size.width)")
        print("This is self.frame.width / 3 \(self.frame.width / 3)")
        avatarBackground.layer.bounds.size.width = self.frame.width / 3
        
        let starsStackView = UIStackView(
            arrangedSubviews: starsArray,
            axis: .horizontal,
            spacing: 0)
        
        let distanseStackView = UIStackView(
            arrangedSubviews: [distanceIconImage ,distanceToCenterLabel],
            axis: .horizontal,
            spacing: 3)
        
        let informationStackView = UIStackView(
            arrangedSubviews: [hotelNameLabel, starsStackView, distanseStackView],
            axis: .vertical,
            spacing: 14)
        
//        let generalStackView = UIStackView(
//            arrangedSubviews: [avatarBackground, informationStackView],
//            axis: .horizontal,
//            spacing: 6)
        
        starsStackView.translatesAutoresizingMaskIntoConstraints        = false
        avatarBackground.translatesAutoresizingMaskIntoConstraints      = false
        distanseStackView.translatesAutoresizingMaskIntoConstraints     = false
        informationStackView.translatesAutoresizingMaskIntoConstraints  = false
        informationStackView.alignment = .leading
        
        contentView.addSubview(avatarBackground)
        contentView.addSubview(informationStackView)
        
//        generalStackView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(generalStackView)
        
//        NSLayoutConstraint.activate([
//            generalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
//            generalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
//            generalStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: 6),
//            generalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3)
//
//        ])
        
        NSLayoutConstraint.activate([
            avatarBackground.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 3),
            avatarBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            avatarBackground.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 3 / 5 ),
            avatarBackground.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -3)
        ])

        NSLayoutConstraint.activate([
            informationStackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 3),
            informationStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            informationStackView.leadingAnchor.constraint(equalTo: avatarBackground.trailingAnchor, constant: 3),
            informationStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            informationStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -3)
        ])
    }
}
