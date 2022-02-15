//
//  HotelDetailsViewModel.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 08.02.2022.
//

import Foundation

protocol HotelDetailsViewModelProtocol {
  var hotelName: String { get }
  var hotelAddress: String { get }
  var suitesAvailability: String { get }
  var stars: Double { get }
  var networkService: NetworkServiceSingleHotelProtocol { get }
  func fetchHotel(completion: @escaping() -> Void)
  //  var imageData: Data? { get }
  init(hotel: Hotel)
}

class HotelDetailsViewModel: HotelDetailsViewModelProtocol {
  var networkService: NetworkServiceSingleHotelProtocol = NetworkService()
  
  var hotelName: String {
    hotel.name
  }
  
  var hotelAddress: String {
    hotel.address
  }
  
  var suitesAvailability: String {
    .suitesArrayConverter(array: hotel.suitesArray)
  }
  
  var stars: Double {
    hotel.stars
  }
  
  private var hotel: Hotel
  
  required init(hotel: Hotel) {
    self.hotel = hotel
  }
  
  func fetchHotel(completion: @escaping () -> Void) {
    networkService.getHotelInformation(with: hotel.id) { result in
      switch result {
        
      case .success(let data):
        self.hotel = data
        completion()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
