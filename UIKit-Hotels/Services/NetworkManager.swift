//
//  NetworkManager.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 10.01.2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchHotels(from url: String, completion: @escaping(Result<Hotels, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description error")
                return
            }
            
            do {
                let hotels = try JSONDecoder().decode(Hotels.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(hotels))
                }
            } catch let error {
                completion(.failure(error))
            }
        } .resume()
    }
    
    func fetchHotel(from url: String, completion: @escaping(Result<Hotel, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description error")
                return
            }
            
            do {
                let hotel = try JSONDecoder().decode(Hotel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(hotel))
                }
            } catch let error {
                completion(.failure(error))
            }
        } .resume()
    }
    
//    func fetchImageData(from jpg: String) {
//        let imageLink = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/\(jpg)"
//        
//        guard let url = URL(string: imageLink) else { return }
//        
//        URLSession.shared.
//        
//    }
}
