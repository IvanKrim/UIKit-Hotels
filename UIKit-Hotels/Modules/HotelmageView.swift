//
//  HotelmageView.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 18.01.2022.
//

import UIKit

//class HotelImageView: UIImageView {
//    func fetchImage(from url: String) {
//        guard let imageURL = URL(string: url) else {
//            image = UIImage(systemName: "xmark.octagon.fill")
//            return
//        }
//
//        // Используем изображение из кэша, если оно там есть
//        if let cachedImage = getCachedImage(from: imageURL) {
//            image = cachedImage
//            return
//        }
//
//        // Если изображения нет, то грузим из сети
//        ImageManager.shared.fetchImage(from: imageURL) { data, response in
//            self.image = UIImage(data: data)
//
//            // Сохраняем изображение в кэш
//            self.saveDataToCache(with: data, and: response)
//        }
//    }
//
//    private func saveDataToCache(with data: Data, and response: URLResponse) {
//        guard let url = response.url else { return }
//        let request = URLRequest(url: url)
//        let cachedResponse = CachedURLResponse(response: response, data: data)
//        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
//    }
//
//    private func getCachedImage(from url: URL) -> UIImage? {
//        let request = URLRequest(url: url)
//        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
//            return UIImage(data: cachedResponse.data)
//        }
//        return nil
//    }
//}
