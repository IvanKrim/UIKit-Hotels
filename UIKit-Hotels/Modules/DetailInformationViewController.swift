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
    
    private let hotelNameLabel = UILabel(text: "Best Western President Hotel at Times Square", style: .titleText(), numberOfLines: 0)
    private let hotelStarsLabel = UILabel(text: "⭐️⭐️⭐️")
    private let hotelAddres = UILabel(text: "250 West 77th Street, Manhattan", textColor: .textGray())
    private let suites = UILabel(text: "Available rooms:", style: .subheadingText())
    
    private let suitesAvailability = UILabel(text: "1, 44, 21, 87, 99, 34", textColor: .textGreen())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Best Western President Hotel at Times Square"
//        title = "Best Western President Hotel at Times Square"
        
        view.backgroundColor = .white
        
        setupConstraints()
    }
}

// MARK: - Setup Constraints
extension DetailInformationViewController {
    
    private func setupConstraints() {
        let availableRoomsStackView = UIStackView(
            arrangedSubviews: [suites, suitesAvailability],
            axis: .vertical,
            spacing: 6)
        
        let stackView = UIStackView(
            arrangedSubviews: [hotelNameLabel, hotelStarsLabel, hotelAddres, availableRoomsStackView],
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
