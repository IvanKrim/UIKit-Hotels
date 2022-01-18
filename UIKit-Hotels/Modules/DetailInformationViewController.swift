//
//  DetailInformationViewController.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 10.01.2022.
//

import UIKit

class DetailInformationViewController: UIViewController {
    
    private let avatarBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let hotelNameLabel = UILabel(style: .titleText(), numberOfLines: 0)
    private let hotelStarsLabel = UILabel()
    private let hotelAddres = UILabel(textColor: .textGray())
    private let suites = UILabel(style: .subheadingText())
    
    private let suitesAvailability = UILabel(textColor: .textGreen())
    
    var hotel: Hotel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .white

        setupContent(whit: hotel)
    }
    
    private func setupContent(whit hotel: Hotel) {
        navigationItem.title = hotel.name
        hotelNameLabel.text = hotel.name
        hotelAddres.text = hotel.address
        suitesAvailability.text = hotel.suitesAvailability
        
        setupConstraints(with: hotel.stars)
    }
}

// MARK: - Setup Stars Array UIImageView
extension DetailInformationViewController {
    private func starIcon(image: UIImage) -> UIImageView {
        let icon = UIImageView(image: image, tintColor: .starsYellow())

        return icon
    }
    
    private func starsConverter(input: Double) -> [UIImageView] {
        let starsMaximum = 5
        let emptyView = UIImageView()
        emptyView.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .horizontal)
       
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

// MARK: - Setup Constraints
extension DetailInformationViewController {
    
    private func setupConstraints(with stars: Double) {
        let starsArray = starsConverter(input: stars)
        
        let starsStackView = UIStackView(
            arrangedSubviews: starsArray,
            axis: .horizontal,
            spacing: 0)
 
        let availableRoomsStackView = UIStackView(
            arrangedSubviews: [suites, suitesAvailability],
            axis: .vertical,
            spacing: 6)
        
        let stackView = UIStackView(
            arrangedSubviews: [hotelNameLabel, starsStackView, hotelAddres, availableRoomsStackView],
            axis: .vertical,
            spacing: 14)
        
        avatarBackground.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(avatarBackground)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            avatarBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            avatarBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            avatarBackground.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3 / 4)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: avatarBackground.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct DetailInformationVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let detailInformationVCrProvider = DetailInformationViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return detailInformationVCrProvider
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
