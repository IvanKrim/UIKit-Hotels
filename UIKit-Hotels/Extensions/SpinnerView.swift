//
//  CustomActivityIndicator.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 21.02.2022.
//

import UIKit

class SpinnerView: UIView {
  
  private var activityIndicator = UIActivityIndicatorView()
  
  private let backgroundView: UIVisualEffectView = {
    let view = UIVisualEffectView()
    let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
    view.effect = blurEffect
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    showSpinnerView(in: self)
  }
  
  func spinnerViewStopAnimating() {
    activityIndicator.stopAnimating()
  }
  
  private func showSpinnerView(in view: UIView) {
    activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = UIColor.textSet
    activityIndicator.startAnimating()
    activityIndicator.hidesWhenStopped = true
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(backgroundView)
    backgroundView.contentView.addSubview(activityIndicator)
    
    NSLayoutConstraint.activate([
      backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
      backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
