//
//  HotelsListViewModel.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 08.02.2022.
//

import Foundation

protocol HotelListViewModelProtocol {
  var hotels: Hotels { get }
  var networkService: NetworkServiceSingleHotelProtocol { get }
  func fetchHotels(completion: @escaping() -> Void)
  func numberOfRows() -> Int
  
  func cellViewModel(at indexPath: IndexPath) -> HotelCellViewModelProtocol
  func detailsViewModel(at indexPath: IndexPath) -> HotelDetailsViewModelProtocol
}

class HotelListViewModel: HotelListViewModelProtocol {
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
  
  func cellViewModel(at indexPath: IndexPath) -> HotelCellViewModelProtocol {
    let hotel = hotels[indexPath.row]
    return HotelCellViewModel(hotel: hotel)
  }
  
  func detailsViewModel(at indexPath: IndexPath) -> HotelDetailsViewModelProtocol {
    let hotel = hotels[indexPath.row]
    return HotelDetailsViewModel(hotel: hotel)
  }
}
