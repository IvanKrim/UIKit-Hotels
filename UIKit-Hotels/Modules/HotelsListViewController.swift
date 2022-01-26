//
//  HotelsListViewController.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 06.01.2022.
//

import UIKit

class HotelsListViewController: UIViewController {
    
    let simpHotels: Hotels = [
        
        Hotel(id: 13100, name: "Best Western President Hotel at Times Square", address: "234 West 48th Street", stars: 3.0, distance: 13.1, image: nil, suitesAvailability: "1", lat: nil, lon: nil),
        Hotel(id: 13370, name: "Midtown Lodging", address: "250 East 50th Street", stars: 2.0, distance: 13.1, image: nil, suitesAvailability: "1:", lat: nil, lon: nil),
        Hotel(id: 80899, name: "Americana Inn", address: "69 West 38th Street", stars: 2.0, distance: 99.9, image: nil, suitesAvailability: "5:8:32:54", lat: nil, lon: nil),
        Hotel(id: 40611, name: "Belleclaire Hotel", address: "250 West 77th Street, Manhattan", stars: 3.0, distance: 100.0, image: nil, suitesAvailability: "1:44:21:87:99:34", lat: nil, lon: nil),
        Hotel(id: 85862, name: "Dream", address: "210 W. 55 STREET, NEW YORK NY 10019, UNITED STATES", stars: 4.0, distance: 554.4, image: nil, suitesAvailability: "42:33:22", lat: nil, lon: nil),
        Hotel(id: 313499, name: "Dream Downtown", address: "355 West 16th Street", stars: 0.0, distance: 716.06, image: nil, suitesAvailability: "2:87:24:65:26:119:202:6", lat: nil, lon: nil),
        Hotel(id: 22470, name: "Days Hotel Broadway at 94th Street", address: "215 West 94th Street", stars: 1.0, distance: 999.9, image: nil, suitesAvailability: "15:48:115:72:81", lat: nil, lon: nil)
    ]
    
    var sortedData = false
    
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var activityIndicator = UIActivityIndicatorView() // Сделать
    
    private let sortButton: UIButton = {
        let button = UIButton(title: "Sort", titleColor: .white,
                              backgroundColor: .systemGray,
                              isShadow: false)
        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let networkService: NetworkServiceSingleHotelProtocol = NetworkService()
    
    var hotels: Hotels = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Test App"
        view.backgroundColor = .white
        //        fetchData()
        
        setupTableView()
        setupConstraints()
    }
    
    @objc private func sortButtonTapped() {
        let sortedVC = SortHotelViewController()
        present(sortedVC, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateContent()
    }
    
    // MARK: - UPDATE CONTENT AFTER SORT
    private func updateContent() {
        if !sortedData {
            //            hotels = hottels
            //            tableView.reloadData()
            fetchData()
            print("Блок false сработал")
        } else {
            hotels = simpHotels
            tableView.reloadData()
            print("Блок true сработал")
        }
    }
    
    private func fetchData() {
        networkService.getHotelsInformation(completion: { result in
            switch result {
            case .success(let data):
                self.hotels = data
                self.tableView.reloadData()
            case .failure(let error):
                self
                    .showAlert(
                        title: "Error",
                        message: "\(error.localizedDescription). \n Please contact support"
                    )
            }
        })
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(HotelViewCell.self, forCellReuseIdentifier: "CellID")
        
        tableView.rowHeight = view.frame.height / 4
    }
}

// MARK: - UITableViewDataSource
extension HotelsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? HotelViewCell {
            cell.setupContent(with: hotels[indexPath.row])
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension HotelsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let hotel = hotels[indexPath.row]
        
        let detailInformationVC = DetailInformationViewController()
        detailInformationVC.hotelID = hotel.id
        navigationController?.pushViewController(detailInformationVC, animated: true)
    }
}

// MARK: - Setup Constraints
extension HotelsListViewController {
    
    private func setupConstraints() {
        let buttonStackView = UIStackView(
            arrangedSubviews: [sortButton],
            axis: .horizontal,
            spacing: 0)
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buttonStackView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Alert Controller
extension HotelsListViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Activity Indicator
extension HotelsListViewController {
    func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}

//// MARK: - SwiftUI previews
//import SwiftUI
//
//struct HotelVCProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//    
//    struct ContainerView: UIViewControllerRepresentable {
//        let viewController = HotelsListViewController()
//        
//        func makeUIViewController(context: Context) -> some UIViewController {
//            return viewController
//        }
//        
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        }
//    }
//}
