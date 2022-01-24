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
    
    private let mapButton: CustomButton = {
        let button = CustomButton(title: "Watch On Map", backgroundColor: .textGreen())
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let avatarBackground: UIImageView = {
        var image = UIImageView()
        image.contentMode   = .scaleAspectFill
        image.clipsToBounds = true
        return image
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

        setupContent(whith: hotel)
    }
    
    private func setupContent(whith hotel: Hotel) {
        navigationItem.title = hotel.name
        hotelNameLabel.text = hotel.name
        hotelAddres.text = hotel.address
        suitesAvailability.text = hotel.suitesAvailability
        
        setupConstraints(with: hotel.stars)
        fetchImage(with: hotel.id)
    }
    
    @objc private func buttonTapped(longitude: Double, latitude: Double) {
        let mapScreenVC = MapScreenViewController()
    
        mapScreenVC.longitude = longitude
        mapScreenVC.latitude = latitude
        navigationController?.pushViewController(mapScreenVC, animated: true)
    }
}

// MARK: - Setup Stars Array
extension DetailInformationViewController {
    private func starIcon(image: UIImage) -> UIImageView {
        let icon = UIImageView(image: image, tintColor: .starsYellow())
        icon.translatesAutoresizingMaskIntoConstraints = false
//        icon.contentMode = .scaleToFill
    
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
extension DetailInformationViewController {
    private func setupImage(with imageURL: Endpoint) {
        self.avatarBackground.kf.indicatorType = .activity
        
        guard let downloadURL = imageURL.linkGenerator(path: imageURL) else { return }
        let resource    = ImageResource(downloadURL: downloadURL)
        let placeholder = UIImage(systemName: "house")
        let processor   = RoundCornerImageProcessor(cornerRadius: 5)

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
        
        avatarBackground.translatesAutoresizingMaskIntoConstraints  = false
        stackView.translatesAutoresizingMaskIntoConstraints         = false
        mapButton.translatesAutoresizingMaskIntoConstraints         = false
        
        view.addSubview(avatarBackground)
        view.addSubview(stackView)
//        view.addSubview(mapButton)
        
        NSLayoutConstraint.activate([
            mapButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)
        ])
        
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
