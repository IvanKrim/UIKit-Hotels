//
//  HotelsListViewController.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 15.02.2022.
//

import UIKit

class HotelsListViewController: UIViewController {
  private let tableView = UITableView(frame: .zero, style: .plain)
  
  private var viewModel: HotelsListViewModelProtocol! {
    didSet {
      viewModel.fetchHotels {
        self.tableView.reloadData()
      }
    }
  }
  
  private lazy var sortButton: UIButton = {
    let button = UIButton(title: "Sort", titleColor: .secondaryTextSet, backgroundColor: .clear)
    button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    button.layer.borderWidth = 0.5
    button.layer.borderColor = UIColor.secondaryTextSet.cgColor
    
    return button
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = HotelsListViewModel()
    title = "Hotel App"
    view.backgroundColor = .backgroundSet
    
    networkMonitor()
  }
  
  private func networkMonitor() {
    viewModel.networkMonitor { status in
      switch status {
        
      case .connected:
        setupTableView()
        setupConstraints()
      case .disconnected:
        showAlert(
          with: "Network Error",
          and: "Please check your internet connection or try again later.")
      }
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
    let sortedVC = viewModel.buttonPressed() as? SortHotelViewController
    guard let sortedVC = sortedVC else { return }
    sortedVC.reloadDataDelegate = self
    
    present(sortedVC, animated: true)
  }
}

extension HotelsListViewController: SortHotelReloadDataProtocol {
  func dataDidSorted() {
    tableView.reloadData()
  }
}

// MARK: - UITableViewDataSource
extension HotelsListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.numberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? HotelViewCell  else {
      fatalError("Creating cell from HotelsListViewController failed")
    }
    cell.viewModel = viewModel.cellViewModel(at: indexPath)
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension HotelsListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let detailViewModel = viewModel.detailsViewModel(at: indexPath)
    
    let detailInformationVC = HotelDetailsViewController()
    detailInformationVC.viewModel = detailViewModel
    
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
