//
//  MapScreenViewController.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 24.01.2022.
//

import Foundation
import UIKit
import MapKit

class MapScreenViewController: UIViewController {
    
    private let mapView = MKMapView()
    
    var latitude: Double = 0
    var longitude: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        setupConstraints()
        monitorGeofences()
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 40.7826, longitude: -73.9813)
  
        mapView.addAnnotation(annotation)
        
        mapView.delegate = self
    }
    
    func monitorGeofences() {
        
     
//        locationManager.location?.coordinate.latitude = 40.78260000000000
//        locationManager.location?.coordinate.longitude = -73.98130000000000
    }
    
    private func setupContent(whith hotel: Hotel) {
        
        
    }
    
    private func setupConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension MapScreenViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // If you're showing the user's location on the map, don't set any view
        if annotation is MKUserLocation { return nil }

        let id = MKMapViewDefaultAnnotationViewReuseIdentifier

        // Balloon Shape Pin (iOS 11 and above)
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKMarkerAnnotationView {
            view.titleVisibility = .visible // Set Title to be always visible
            view.subtitleVisibility = .visible // Set Subtitle to be always visible
            view.markerTintColor = .yellow // Background color of the balloon shape pin
            view.glyphImage = UIImage(systemName: "plus.viewfinder") // Change the image displayed on the pin (40x40 that will be sized down to 20x20 when is not tapped)
            // view.glyphText = "!" // Text instead of image
            view.glyphTintColor = .black // T
        }
        return nil
    }
    
}

// MARK: - SwiftUI
import SwiftUI

struct MapScreenVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let mapScreenVCProvider = MapScreenViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return mapScreenVCProvider
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
