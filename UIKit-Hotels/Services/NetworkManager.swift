//
//  NetworkManager.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 10.01.2022.
//

import Foundation

protocol NetworkServiceSingleHotelProtocol {
  func getHotelsInformation(completion: @escaping (Result<Hotels, Error>) -> Void)
  
  func getHotelInformation(with id: Int, completion: @escaping (Result<Hotel, Error>) -> Void)
}

class NetworkService: NetworkServiceSingleHotelProtocol {
  func getHotelsInformation(completion: @escaping (Result<Hotels, Error>) -> Void) {
    request(path: .baseURL) { (result: Result<Hotels, Error>) in
      switch result {
      case .success(let data):
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func getHotelInformation(with id: Int, completion: @escaping (Result<Hotel, Error>) -> Void) {
    request(path: .id(id)) { (result: Result<Hotel, Error>) in
      switch result {
      case .success(let data):
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  private func request <T: Decodable>(
    path url: Endpoint,
    completion: @escaping(Result<T, Error>) -> Void) {
      
      guard let url = url.linkManager(path: url) else { return }
      
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
        } catch {
          DispatchQueue.main.async {
            completion(.failure(NetworkError.incorrectDataError))
          }
        }
      }.resume()
    }
}
