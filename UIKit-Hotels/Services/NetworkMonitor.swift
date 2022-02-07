//
//  NetworkMonitor.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 06.02.2022.
//

import Foundation
import Network

final class NetworkMonitor {
  
  static let shared = NetworkMonitor()
  
  private let queue = DispatchQueue.global()
  private let monitor: NWPathMonitor
  
  public private(set) var isConnected: Bool = false
  
  private init() {
    monitor = NWPathMonitor()
  }
  
  public func startMonitoring() {
    monitor.start(queue: queue)
    monitor.pathUpdateHandler = { [weak self] path in
      self?.isConnected = path.status == .satisfied
    }
  }
  
  public func stopMonitoring() {
    monitor.cancel()
  }
}
