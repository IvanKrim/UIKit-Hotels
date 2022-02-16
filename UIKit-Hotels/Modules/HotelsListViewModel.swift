//
//  HotelsListViewModel.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 08.02.2022.
//

import Foundation

protocol HotelsListViewModelProtocol {
  var hotels: Hotels { get }
  var networkService: NetworkServiceSingleHotelProtocol { get }
  func fetchHotels(completion: @escaping() -> Void)
  func numberOfRows() -> Int
  
  var viewModelDidChange: ((HotelsListViewModelProtocol) -> Void)? { get set }
  
  func buttonPressed()
  
  func sortedByEmptyRooms()
  func sortedByDistance()
  func cellViewModel(at indexPath: IndexPath) -> HotelCellViewModelProtocol
  func detailsViewModel(at indexPath: IndexPath) -> HotelDetailsViewModelProtocol
}

class HotelsListViewModel: HotelsListViewModelProtocol {
  var networkService: NetworkServiceSingleHotelProtocol = NetworkService()
  
  var hotels: Hotels = []
  
  func fetchHotels(completion: @escaping () -> Void) {
    networkService.getHotelsInformation { result in
      switch result {
        
      case .success(let data):
        self.hotels = data
        completion()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  func numberOfRows() -> Int {
    hotels.count
  }
  
  var viewModelDidChange: ((HotelsListViewModelProtocol) -> Void)?
  
  func buttonPressed() {
    sortedByDistance()
    print("это отсортированные данные \n \(hotels)")
  }
  
  func sortedByEmptyRooms() {
    hotels.sort {
      $1.suitesArray.count < $0.suitesArray.count
    }
  }
  
  func sortedByDistance() {
    hotels.sort {
      $0.distance < $1.distance
    }
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

enum SortedBy {
  case emptyRooms
  case byDistance
}
