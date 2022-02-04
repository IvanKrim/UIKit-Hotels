//
//  HotelsListViewController.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 06.01.2022.
//

import UIKit

class HotelsListViewController: UIViewController {
  
  // MARK: - Properties
  //    private var activityIndicator = UIActivityIndicatorView() // Сделать
  
  private let sortButton: UIButton = {
    let button = UIButton(title: "Sort", titleColor: .secondaryTextSet(), backgroundColor: .clear)
    button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    button.layer.borderWidth = 0.5
    button.layer.borderColor = UIColor.secondaryTextSet().cgColor
    
    return button
  }()
  
  private let networkService: NetworkServiceSingleHotelProtocol = NetworkService()
  private var dataSorted = false
  let tableView = UITableView(frame: .zero, style: .plain)
  var hotels: Hotels = []
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Hotel App"
    view.backgroundColor = .backgroundSet()
    
    setupTableView()
    setupConstraints()
    updateContent()
  }
  
  private func updateContent() {
    if !dataSorted {
      fetchData()
      dataSorted.toggle()
    }
  }
  
  private func setupTableView() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.register(HotelViewCell.self, forCellReuseIdentifier: "CellID")
    tableView.separatorStyle = .none
    tableView.rowHeight = view.frame.height / 3
    tableView.backgroundColor = .clear
  }
  
  @objc private func sortButtonTapped() {
    let sortedVC = SortHotelViewController()
    
    present(sortedVC, animated: true)
    sortedVC.hotelListViewController = self
  }
}

// MARK: - Networking
extension HotelsListViewController {
  
  private func fetchData() {
    networkService.getHotelsInformation { result in
      
      switch result {
      case .success(let data):
        self.hotels = data
        self.dataSorted = true
        self.tableView.reloadData()
      case .failure(let error):
        self.showAlert(
          title: "Error",
          message: "\(error.localizedDescription). \n Please contact support")
      }
    }
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
      return  UITableViewCell()
      // MARK: - ПОФИКСИТЬ!!!
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
      buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 1),
      buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -1)
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
