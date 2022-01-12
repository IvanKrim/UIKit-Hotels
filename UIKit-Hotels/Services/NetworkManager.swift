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
    
    func fetchData(from url: String, completion: @escaping(Result<Hotels, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description error")
                return
            }
            
            do {
                let hotel = try JSONDecoder().decode(Hotels.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(hotel))
                }
            } catch let error {
                completion(.failure(error))
            }
        } .resume()
    }
}
