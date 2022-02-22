//
//  HotelsListViewModel.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 08.02.2022.
//

import Foundation
import UIKit

protocol HotelsListViewModelProtocol {
  var hotels: Hotels { get }
  var networkService: NetworkServiceSingleHotelProtocol { get }
  var errorDescription: String? { get }
  func networkMonitor(completion: (NetworkStatus) -> Void)
  func fetchHotels(completion: @escaping() -> Void)
  func numberOfRows() -> Int
  func buttonPressed() -> UIViewController
  
  func cellViewModel(at indexPath: IndexPath) -> HotelCellViewModelProtocol
  func detailsViewModel(at indexPath: IndexPath) -> HotelDetailsViewModelProtocol
}

class HotelsListViewModel: HotelsListViewModelProtocol {
  var networkService: NetworkServiceSingleHotelProtocol = NetworkService()
  var errorDescription: String?
  var hotels: Hotels = []

  func networkMonitor(completion: (NetworkStatus) -> Void) {
    if NetworkMonitor.shared.isConnected {
      completion(.connected)
    } else {
      completion(.disconnected)
    }
  }
  
  func fetchHotels(completion: @escaping () -> Void) {
    networkService.getHotelsInformation { result in
      switch result {
        
      case .success(let data):
        self.hotels = data
        completion()
      case .failure(let error):
        self.errorDescription = error.localizedDescription
        completion()
      }
    }
  }
  
  func numberOfRows() -> Int {
    hotels.count
  }
  
  func buttonPressed() -> UIViewController {
    let sortedVC = SortHotelViewController()
    sortedVC.sortDataDelegate = self
    
    return sortedVC
  }
  
  func cellViewModel(at indexPath: IndexPath) -> HotelCellViewModelProtocol {
    let hotel = hotels[indexPath.row]
    return HotelCellViewModel(hotel: hotel)
  }
  
  func detailsViewModel(at indexPath: IndexPath) -> HotelDetailsViewModelProtocol {
    let hotel = hotels[indexPath.row]
    return HotelDetailsViewModel(hotel: hotel)
  }
}

// MARK: - Data sorting methods
extension HotelsListViewModel: SortHotelDataProtocol {
  func sortedByEmptyRooms() {
    hotels.sort { $1.suitesArray.count < $0.suitesArray.count }
  }
  
  func sortedByDistance() {
    hotels.sort { $0.distance < $1.distance }
  }
}
