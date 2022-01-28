//
//  SortHotelViewController.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 25.01.2022.
//

import UIKit

class SortHotelViewController: UIViewController {
    
    
    private let sortedRoomsButton: UIButton = {
        let button = UIButton()
//        self.init(type: .system)
        button.setTitle("Number of empty rooms ", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .gray
        button .setImage(UIImage(systemName: "circle"), for: .normal)
        button.addTarget(self, action: #selector(sortedRoomsButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let sortedDistanceButton: UIButton = {
        let button = UIButton(title: "Distance from city centre", titleColor: .white, backgroundColor: .gray)
        button.addTarget(self, action: #selector(sortedDistanceButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    weak var hotelListViewController: HotelsListViewController!

    var hotels: Hotels = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Sorted by"

        setupConstraints()
    }
    
    @objc private func sortedRoomsButtonTapped() {
        hotelListViewController.hotels.sort {
            $1.suitesArray.count < $0.suitesArray.count
        }
        hotelListViewController.tableView.reloadData()
        dismiss(animated: true)
    }
    
    @objc private func sortedDistanceButtonTapped() {
        hotelListViewController.hotels.sort {
            $0.distance < $1.distance
        }
        hotelListViewController.tableView.reloadData()
        dismiss(animated: true)
    }
}

extension SortHotelViewController {
    private func setupConstraints() {
        
        let stackView = UIStackView(
            arrangedSubviews: [sortedRoomsButton,sortedDistanceButton],
            axis: .vertical,
            spacing: 6)
        stackView.distribution = .fillProportionally
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            sortedRoomsButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15)
        ])
    }
}

//// MARK: - SwiftUI
//import SwiftUI
//
//struct SortHotelVCProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//    
//    struct ContainerView: UIViewControllerRepresentable {
//        let sortHotelVCProvider = SortHotelViewController()
//        
//        func makeUIViewController(context: Context) -> some UIViewController {
//            return sortHotelVCProvider
//        }
//        
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        }
//    }
//}