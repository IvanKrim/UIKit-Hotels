//
//  SceneDelegate.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 06.01.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let firstViewController = HotelsListViewController()
        
        let navigationController = UINavigationController(rootViewController: firstViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = .generalTextSet()
        navigationController.navigationBar.topItem?.backButtonTitle = "Back"
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    
}

