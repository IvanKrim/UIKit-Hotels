//
//  NetworkManager.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 10.01.2022.
//

import Foundation


protocol NetworkServiceSingleHotelProtocol {
    func getHotelInformation(from path: Endpoint, completion: @escaping (Result<Hotel, Error>) -> Void)
}

class NetworkManager: NetworkServiceSingleHotelProtocol {
    func getHotelInformation(from path: Endpoint, completion: @escaping (Result<Hotel, Error>) -> Void) {
        let urlString = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json"
        request(from: urlString) { completion($0)}
    }
    
    public func getHotelsInformation(completion: @escaping (Result<Hotels, Error>) -> Void) {
        let urlString = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json"
        
        request(from: urlString) { (result: Result<Hotels, Error>) in
            switch result {
                
            case .success(let hotels):
                completion(.success(hotels))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func request <T:Decodable>(from url: String, completion: @escaping(Result<T, Error>)-> Void) {
        
        
        
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.serverError(error: error)))
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noConnectionError))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch let error {
                completion(.failure(error))
            }
        } .resume()
    }
    
//    func fetchHotels(from puth: Endpoint, completion: @escaping(Result<Hotels, Error>) -> Void) {
//        guard let url = puth.linkGenerator(path: puth) else { return }
//        
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "No description error")
//                return
//            }
//            
//            do {
//                let hotels = try JSONDecoder().decode(Hotels.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(hotels))
//                }
//            } catch let error {
//                completion(.failure(error))
//            }
//        } .resume()
//    }
}

