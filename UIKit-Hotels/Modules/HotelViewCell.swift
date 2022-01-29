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
        image.layer.cornerRadius = 10
        return image
    }()
    
    private let networkService: NetworkServiceSingleHotelProtocol = NetworkService()
    private let hotelNameLabel = UILabel(style: .titleText(), numberOfLines: 2)
    private let distanceIconImage = UIImageView(image: UIImage.distanseIcon(), tintColor: .textGray())
    private let distanceToCenterLabel = UILabel(textColor: .gray)
    private let availableSuitesLabel = UILabel(style: .bodyTextBold(), textColor: .textGreen())

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
        distanceToCenterLabel.text = "\(hotel.distance) meters to the center"
        availableSuitesLabel.text = "Available rooms: \(hotel.suitesArray.count)"

        setupConstraints(with: hotel.stars)
        fetchImage(with: hotel.id)
    }
}

// MARK: - Setup Stars Array
extension HotelViewCell {
    private func starIcon(image: UIImage) -> UIImageView {
        let icon = UIImageView(image: image, tintColor: .starsYellow())
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        return icon
    }
    
    private func starsConverter(input: Double) -> [UIImageView] {
        let starsMaximum = 5
        let emptyView: UIImageView = {
            let imageView = UIImageView()
            imageView.setContentHuggingPriority(
                UILayoutPriority(rawValue: 1),
                for: .horizontal)
            
            return imageView
        }()
        
        var starsArray: [UIImageView] = []
        
        for _ in 0..<Int(input) {
            starsArray.append(starIcon(image: UIImage.filledStarIcon()))
        }
        
        while starsArray.count !=  starsMaximum {
            starsArray.append(starIcon(image: UIImage.emptyStarIcon()))
        }
        starsArray.append(emptyView)
        
        return starsArray
    }
}

extension HotelViewCell {
    private func fetchImage(with hotelID: Int) {
        
        networkService.getHotelInformation(with: hotelID) { [self] result in
            switch result {
                
            case .success(let hotel):
                guard let imageURL = hotel.imageHandler else { return }
                
                ImageManager.shared.fetchImage(
                    from: .image(imageURL),
                    image: self.hotelImageView
                )
               
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
            arrangedSubviews: [hotelNameLabel,availableSuitesLabel, starsStackView, distanseStackView],
            axis: .vertical,
            spacing: 10)
        
        hotelImageView.translatesAutoresizingMaskIntoConstraints = false
        generalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(hotelImageView)
        self.addSubview(generalStackView)
    
        NSLayoutConstraint.activate([
            hotelImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            hotelImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            hotelImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            hotelImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
        ])

        NSLayoutConstraint.activate([
            generalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            generalStackView.leadingAnchor.constraint(equalTo: self.hotelImageView.trailingAnchor, constant: 8),
            generalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            generalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
        ])
    }
}
