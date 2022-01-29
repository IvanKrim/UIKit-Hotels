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
        image.contentMode   = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    private let hotelNameLabel      = UILabel(style: .titleText(), numberOfLines: 0)
    private let hotelStarsLabel     = UILabel()
    private let hotelAddres         = UILabel(textColor: .textGray())
    private let suites              = UILabel(style: .subheadingText())
    private let suitesAvailability  = UILabel(textColor: .textGreen())
    
    private let mapButton: CustomButton = {
        let button = CustomButton(title: "Watch On Map", backgroundColor: .textGreen())
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private var hotel: Hotel?
    var hotelID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .white
        
        fetchData(with: hotelID)
    }
    
    private func setupContent(whith hotel: Hotel) {
        setupConstraints(with: hotel.stars)
        
        navigationItem.title = hotel.name
        hotelNameLabel.text = hotel.name
        hotelAddres.text = hotel.address
        suitesAvailability.text = hotel.suitesAvailability
    }
    
    @objc private func buttonTapped() {
        let mapScreenVC = MapScreenViewController()
        mapScreenVC.hotel = hotel
        
        navigationController?.pushViewController(mapScreenVC, animated: true)
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

// MARK: - Setup Stars Array
extension DetailInformationViewController {
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
            arrangedSubviews: [hotelNameLabel, starsStackView, hotelAddres, availableRoomsStackView, mapButton],
            axis: .vertical,
            spacing: 14)
        
        hotelImageView.translatesAutoresizingMaskIntoConstraints    = false
        stackView.translatesAutoresizingMaskIntoConstraints         = false
        mapButton.translatesAutoresizingMaskIntoConstraints         = false
        
        view.addSubview(hotelImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            mapButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)
        ])
        
        NSLayoutConstraint.activate([
            hotelImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hotelImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            hotelImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            hotelImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3 / 4)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: hotelImageView.bottomAnchor, constant: 20),
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
