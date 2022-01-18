//
//  LinkGenerator.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 18.01.2022.
//

import Foundation

class ApiManager {
    static let shared = ApiManager()
    
    private init() {}
    
    func linkGenerator(link: String) -> String {
        "https://raw.githubusercontent.com/iMofas/ios-android-test/master/\(link).json"
    }
    
    func defaultLink() -> String {
        "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json"
    }
}
