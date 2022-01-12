//
//  HotelsListViewController.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 06.01.2022.
//

import Foundation

import UIKit

class HotelsListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green

    }
    
}


// MARK: - SwiftUI previews
import SwiftUI

struct HotelVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = HotelsListViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
