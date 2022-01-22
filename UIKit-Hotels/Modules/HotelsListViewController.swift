//
//  HotelsListViewController.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 06.01.2022.
//

import UIKit

class HotelsListViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var activityIndicator = UIActivityIndicatorView() // Сделать
    
    private let button = UIButton(
        title: "Sort", titleColor: .white,
        backgroundColor: .systemGray,
        isShadow: false
    )
    
    private let networkService: NetworkServiceSingleHotelProtocol = NetworkService()
    var hotels: Hotels = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Test App"
        view.backgroundColor = .white
        
        setupTableView()
        setupConstraints()
        fetchData()
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
        detailInformationVC.hotel = hotel
        
        navigationController?.pushViewController(detailInformationVC, animated: true)
    }
}

// MARK: - Setup Constraints
extension HotelsListViewController {
    private func setupConstraints() {
        let buttonStackView = UIStackView(
            arrangedSubviews: [button],
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

// MARK: - SwiftUI previews
import SwiftUI

struct HotelVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = HotelsListViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
