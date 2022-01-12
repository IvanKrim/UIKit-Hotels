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
    let suitesAvailability: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, address, stars, distance
        case suitesAvailability = "suites_availability"
    }
}

typealias Hotels = [Hotel]

enum ApiLinks: String {
    case generalApi = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json"
}

