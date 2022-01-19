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
    ////     временно заглушка для картинок
    private let avatarBackground: UIImageView = {
        var image = UIImageView()
        image.image         = UIImage(systemName: "house")
        image.contentMode   = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    let imageUrl = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/1.jpg"
    
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
    
    public func setupContent(with hotel: Hotel) {
        hotelNameLabel.text = hotel.name
        distanceToCenterLabel.text = "\(hotel.distance) м до центра"

        setupConstraints(with: hotel.stars)
        setupImage(with: imageUrl)
    }
    
}
// MARK: - Setup Stars Array UIImageView
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

// MARK: - Image Manager
extension HotelViewCell {
    func setupImage(with imageURL: String) {
        guard let downloadURL = URL(string: imageURL) else { return }
        
        let resource    = ImageResource(downloadURL: downloadURL)
        let placeholder = UIImage(systemName: "star")
        let processor   = RoundCornerImageProcessor(cornerRadius: 100) // настривать размеры нужно тут
        
        print(avatarBackground.frame.size) // тут размеры 0
        
        self.avatarBackground.kf.indicatorType = .activity
        self.avatarBackground.kf.setImage(
            with: resource,
            placeholder: placeholder,
            options: [.processor(processor)]) { result in
                self.completionHandler(result)
            }
    }
    
    func completionHandler(_ result: Result<RetrieveImageResult, KingfisherError> ) {
        switch result {
        case .success(let retrieveImageResult):
            let image = retrieveImageResult.image
            
        case .failure(let error):
            print(error)
        }
        print(avatarBackground.frame.size) // тут корректные
    }
}

// MARK: - Setup Constraints
extension HotelViewCell {
    private func setupConstraints(with stars: Double) {
        
        let starsArray = starsConverter(input: stars)
        
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
        
        starsStackView.translatesAutoresizingMaskIntoConstraints        = false
        avatarBackground.translatesAutoresizingMaskIntoConstraints      = false
        distanseStackView.translatesAutoresizingMaskIntoConstraints     = false
        informationStackView.translatesAutoresizingMaskIntoConstraints  = false
        informationStackView.alignment = .leading
        
        contentView.addSubview(avatarBackground)
        contentView.addSubview(informationStackView)
        
        NSLayoutConstraint.activate([
            avatarBackground.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 3),
            avatarBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            avatarBackground.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 3 / 5 ),
            avatarBackground.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -3)
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
