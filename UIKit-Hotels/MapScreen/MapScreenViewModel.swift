//
//  MapScreenViewModel.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 08.02.2022.
//

import Foundation

protocol MapScreenViewModelProtocol {
  init(hotel: Hotel)
}

class MapScreenViewModel: MapScreenViewModelProtocol {
  private let hotel: Hotel
  
  
  required init(hotel: Hotel) {
    self.hotel = hotel
  }
}
