//
//  Hotel.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 06.01.2022.
//

import Foundation

struct Hotel: Decodable {
  let id: Int
  let name: String
  let address: String
  let stars: Double
  let distance: Double
  private let image: String?
  let suitesAvailability: String
  let lat: Double?
  let lon: Double?
  
  var imageHandler: String? {
    image == nil ? "" : image
  }
  
  var suitesArray: [String] {
    suitesAvailability.components(separatedBy: ":")
  }
  
  enum CodingKeys: String, CodingKey {
    case id, name, address, stars, distance, image
    case suitesAvailability = "suites_availability"
    case lat, lon
  }
}

typealias Hotels = [Hotel]


