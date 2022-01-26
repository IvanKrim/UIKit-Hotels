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
    private let hotelImageView: UIImageView = {
        var image = UIImageView()
        image.contentMode   = .scaleAspectFill
        image.clipsToBounds = true

        return image
    }()
    
//    let hotelImageView: UIView = {
//       var view = UIView()
//        view.backgroundColor = .red
//
//        return view
//    }()
    
    private let networkService: NetworkServiceSingleHotelProtocol = NetworkService()
    
    private let distanceIconImage = UIImageView(image: UIImage.distanseIcon(), tintColor: .textGray())
    
    private var hotelNameLabel = UILabel(style: .titleText(), numberOfLines: 2)
    private let distanceToCenterLabel = UILabel(textColor: .gray)
    
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

// MARK: - Kingfisher Image Manager
extension HotelViewCell {

    private func setupImage(with imageURL: Endpoint) {
       
        self.hotelImageView.kf.indicatorType = .activity
        
        guard let downloadURL = imageURL.linkGenerator(path: imageURL) else { return }
        print("это downloadURL\(downloadURL) \n")
        let resource    = ImageResource(downloadURL: downloadURL)
        let placeholder = UIImage(systemName: "house")
        let processor   = RoundCornerImageProcessor(cornerRadius: 5)

        self.hotelImageView.kf.setImage(
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
//        let starsArray = starsConverter(input: stars)
        
        let emptyImageView = UIImageView()
        emptyImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
        
        hotelImageView.translatesAutoresizingMaskIntoConstraints = false
//        let imageStackView = UIStackView(
//            arrangedSubviews: [hotelImageView],
//            axis: .horizontal,
//            spacing: 0)
        
//        let starsStackView = UIStackView(
//            arrangedSubviews: starsArray,
//            axis: .horizontal,
//            spacing: 0)
        
        let distanseStackView = UIStackView(
            arrangedSubviews: [distanceIconImage ,distanceToCenterLabel],
            axis: .horizontal,
            spacing: 3)
        
        let informationStackView = UIStackView(
            arrangedSubviews: [hotelNameLabel, distanseStackView, emptyImageView],
            axis: .vertical,
            spacing: 0)

//
//        let generalStack = UIStackView(
//            arrangedSubviews: [imageStackView, informationStackView],
//            axis: .horizontal,
//            spacing: 6)
//
//        generalStack.translatesAutoresizingMaskIntoConstraints = false
        informationStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
                    
        self.addSubview(hotelImageView)
        self.addSubview(informationStackView)
        
//        NSLayoutConstraint.activate([
//            imageStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
//            imageStackView.heightAnchor.constraint(equalToConstant: self.frame.height)
//        ])
        
        NSLayoutConstraint.activate([
            hotelImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            hotelImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            hotelImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            hotelImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
        ])
        
        NSLayoutConstraint.activate([
            informationStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            informationStackView.leadingAnchor.constraint(equalTo: self.hotelImageView.trailingAnchor, constant: 8),
            informationStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            informationStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
            
        ])
    }
}
