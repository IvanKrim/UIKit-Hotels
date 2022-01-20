//
//  NetworkError.swift
//  Pods
//
//  Created by Kalabishka Ivan on 20.01.2022.
//


import Foundation

enum NetworkError: Error {
    case incorrectDataError
    case noConnectionError
    case serverError(error: Error)
}

extension NetworkError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .incorrectDataError:
            return "Incorrect data received from the server"
        case .noConnectionError:
            return "No connection to the server"
        case .serverError(let error):
            return "Server error - \(error.localizedDescription)"
        }
    }
}
