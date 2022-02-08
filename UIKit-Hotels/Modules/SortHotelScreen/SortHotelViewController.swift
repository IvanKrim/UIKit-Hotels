//
//  SortHotelViewController.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 25.01.2022.
//

import UIKit

class SortHotelViewController: UIViewController {
  
  private lazy var dismissButton: UIButton = {
    let button = UIButton(title: "", titleColor: .clear, backgroundColor: .clear)
    button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
    
    return button
  }()
  
  private lazy var sortedRoomsButton: UIButton = {
    let button = UIButton(title: "Number of empty rooms", titleColor: .white, backgroundColor: .buttonColorSet())
    button.addTarget(self, action: #selector(sortedRoomsButtonTapped), for: .touchUpInside)
    
    return button
  }()
  
  private lazy var sortedDistanceButton: UIButton = {
    let button = UIButton(title: "Distance from city centre", titleColor: .white, backgroundColor: .buttonColorSet())
    button.addTarget(self, action: #selector(sortedDistanceButtonTapped), for: .touchUpInside)
    
    return button
  }()
  
  private let sortedTitle = UILabel(text: "Sorted by:", style: .largeTitleText(), textColor: .textSet())
  
  weak var hotelListViewController: HotelsListViewController!
  var hotels: Hotels = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupConstraints()
  }
  
  // MARK: - Private Methods
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
  
  @objc private func dismissButtonTapped() {
    dismiss(animated: true)
  }
}

// MARK: - Setup Constraints
extension SortHotelViewController {
  
  private func setupConstraints() {
    let sheetPresentationView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .secondaryBackgroundSet()
      view.layer.cornerRadius = 20
      
      return view
    }()
    
    let generalStackView = UIStackView(
      arrangedSubviews: [dismissButton, sheetPresentationView],
      axis: .vertical,
      spacing: 0)
    
    let contentStackView = UIStackView(
      arrangedSubviews: [sortedTitle, sortedRoomsButton, sortedDistanceButton],
      axis: .vertical,
      spacing: 6)
    
    generalStackView.distribution = .fillEqually
    contentStackView.distribution = .fillEqually
    
    generalStackView.translatesAutoresizingMaskIntoConstraints = false
    contentStackView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(generalStackView)
    sheetPresentationView.addSubview(contentStackView)
    
    NSLayoutConstraint.activate([
      generalStackView.topAnchor.constraint(equalTo: view.topAnchor),
      generalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      generalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      generalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    ])
    
    NSLayoutConstraint.activate([
      contentStackView.topAnchor.constraint(equalTo: sheetPresentationView.topAnchor, constant: 50),
      contentStackView.leadingAnchor.constraint(equalTo: sheetPresentationView.leadingAnchor, constant: 5),
      contentStackView.trailingAnchor.constraint(equalTo: sheetPresentationView.trailingAnchor, constant: -5),
      contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: sheetPresentationView.bottomAnchor, constant: 10)
    ])
    
    NSLayoutConstraint.activate([
      sortedRoomsButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15)
    ])
  }
}
