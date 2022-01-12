//
//  TableViewCell.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 06.01.2022.
//

import UIKit

//protocol CellConfiguration {
//
//}

class HotelViewCell: UITableViewCell {
    
    // MARK: - Properties
    // временно заглушка для картинок
    private let avatarBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private var distanceIconImage: UIImageView = {
        let imageView = UIImageView()
        //        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "mappin.circle")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var hotelNameLabel = UILabel(style: .titleText(), numberOfLines: 2)
    private var hotelStarsLabel = UILabel(text: "⭐️⭐️⭐️⭐️⭐️")
    private var distanceToCenter = UILabel(text: "5км до центра", textColor: .gray)
    
    //    var hotelsImage = UIImageView(image: UIImage(named: "Hotel"), contentMode: .scaleAspectFill)
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: has not been implemented")
    }
   
    public func setupContent(with hotel: Hotel) {
        hotelNameLabel.text = hotel.name
        hotelStarsLabel.text = starsConverter(input: hotel.stars)
        distanceToCenter.text = "\(hotel.distance) м до центра"
    }
    
    private func starsConverter(input: Double) -> String {
        let star = "⭐️"
        let stars = String(repeating: star, count: Int(input))
        
        return stars
    }
}

// MARK: - Setup Constraints
extension HotelViewCell {
    private func setupConstraints() {
        let distanseStackView = UIStackView(
            arrangedSubviews: [distanceIconImage ,distanceToCenter],
            axis: .horizontal,
            spacing: 3)
        
        let informationStackView = UIStackView(
            arrangedSubviews: [hotelNameLabel, hotelStarsLabel, distanseStackView],
            axis: .vertical,
            spacing: 14)
        
        distanseStackView.translatesAutoresizingMaskIntoConstraints = false
        informationStackView.translatesAutoresizingMaskIntoConstraints = false
        informationStackView.alignment = .leading
        
        avatarBackground.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(avatarBackground)
        contentView.addSubview(informationStackView)
        
        NSLayoutConstraint.activate([
            avatarBackground.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 3),
            avatarBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            avatarBackground.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 3 / 5 ),
            avatarBackground.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -3)
        ])
        
        NSLayoutConstraint.activate([
            informationStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -3),
            informationStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            informationStackView.leadingAnchor.constraint(equalTo: avatarBackground.trailingAnchor, constant: 3),
            informationStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            informationStackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 3)
        ])
    }
}
