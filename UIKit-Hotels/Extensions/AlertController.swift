//
//  AlertController.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 06.02.2022.
//

import UIKit

extension UIViewController {
  func showAlert(with title: String, and message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default)
    alertController.addAction(action)
    present(alertController, animated: true, completion: nil)
  }
}
