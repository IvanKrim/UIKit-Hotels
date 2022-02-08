//
//  HotelDetailsViewModel.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 08.02.2022.
//

import Foundation

// бизнес лоигка конкретного экрана
// Модель представлений ничего не должна знать про UI
protocol HotelDetailsViewModelProtocol {
  var hotelName: String { get }
  var hotelAddress: String { get }
  var suitesAvailability: String { get }
  //  var imageData: Data? { get }
  init(hotel: Hotel)
}

class HotelDetailsViewModel: HotelDetailsViewModelProtocol {
  
  var hotelName: String {
    hotel.name
  }
  
  var hotelAddress: String {
    hotel.address
  }
  
  var suitesAvailability: String {
    .suitesArrayConverter(array: hotel.suitesArray)
  }
  
  private let hotel: Hotel
  
  required init(hotel: Hotel) {
    self.hotel = hotel
  }
}
