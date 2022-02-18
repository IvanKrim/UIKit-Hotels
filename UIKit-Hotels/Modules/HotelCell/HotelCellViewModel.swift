//
//  HotelCellViewModel.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 08.02.2022.
//

import Foundation

protocol HotelCellViewModelProtocol {
  var hotelName: String { get }
  var distanceToCenter: String { get }
  var availableSuites: String { get }
  var stars: Double { get }
  var networkService: NetworkServiceSingleHotelProtocol { get }
  func fetchImage(completion: @escaping(String) -> Void)
  
  init(hotel: Hotel)
}

class HotelCellViewModel: HotelCellViewModelProtocol {
  var networkService: NetworkServiceSingleHotelProtocol = NetworkService()
  
  var hotelName: String {
    hotel.name
  }
  
  var distanceToCenter: String {
    "\(hotel.distance) meters to the center"
  }
  
  var availableSuites: String {
    "Available rooms: \(hotel.suitesArray.count)"
  }
  
  var stars: Double {
    hotel.stars
  }
  
  func fetchImage(completion: @escaping (String) -> Void) {
    networkService.getHotelInformation(with: hotel.id) { result in
      switch result {
        
      case .success(let data):
        guard let imageURL = data.imageHandler else { return }
        DispatchQueue.main.async {
          completion(imageURL)
        }
        
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  private let hotel: Hotel
  
  required init(hotel: Hotel) {
    self.hotel = hotel
  }
}
