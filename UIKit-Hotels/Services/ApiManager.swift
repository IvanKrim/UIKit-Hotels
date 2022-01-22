//
//  LinkGenerator.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 18.01.2022.
//

import Foundation


enum Endpoint {
    case baseURL
    case image (String)
    case id (Int)
    
    private var baseURL: URL{ URL(string: "https://raw.githubusercontent.com/iMofas/ios-android-test/master/")!}
    
    private func path() -> String {
        switch self {
        case .baseURL:
            return "0777.json"
        case let .image(imageID):
            return "\(imageID)"
        case let .id(id):
            return "\(id).json"
        }
    }
    
    func linkGenerator(path: Self) -> URL? {
        let link = baseURL.appendingPathComponent(self.path())
   
        return link
    }
}
