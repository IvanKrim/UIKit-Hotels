//
//  SortHotelViewController.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 25.01.2022.
//

import UIKit

class SortHotelViewController: UIViewController {
    
    private let networkService: NetworkServiceSingleHotelProtocol = NetworkService()
    
    let sortedRoomsButton: UIButton = {
        let button = UIButton(title: "Number of empty rooms ", titleColor: .white, backgroundColor: .gray)
        button.addTarget(self, action: #selector(sortedRoomsButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let sortedDistanceButton: UIButton = {
        let button = UIButton(title: "Distance from city centre", titleColor: .white, backgroundColor: .gray)
        
        button.addTarget(self, action: #selector(sortedDistanceButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupConstraints()
    }
    
    @objc func sortedRoomsButtonTapped() {
        dismiss(animated: true) {
            let hotelListController = HotelsListViewController()
            self.networkService.getHotelsInformation(completion: { result in
                switch result {
                    
                case .success(var data):
                    data.sort {
                        $1.suitesArray.count < $0.suitesArray.count
                    }
                    hotelListController.hotels = data
                    hotelListController.viewWillAppear(true)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
    
    @objc func sortedDistanceButtonTapped() {
        dismiss(animated: true) {
            let hotelListController = HotelsListViewController()
            self.networkService.getHotelsInformation(completion: { result in
                switch result {
                    
                case .success(var data):
                    data.sort {
                        $0.distance < $1.distance
                    }
                    hotelListController.hotels = data
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
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
