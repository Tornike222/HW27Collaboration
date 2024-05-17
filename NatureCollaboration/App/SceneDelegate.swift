//
//  SceneDelegate.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        let tabBarController = UITabBarController()

        tabBarController.viewControllers = [
        AirQualityViewController(viewModel: AirQualityViewModel()),
        WeatherViewController(viewModel: WeatherViewModel()),
        SpecieViewController(viewModel: SpecieViewModel()),
        SolarResourceViewController(viewModel: SolarResourceViewModel()),
        PopulationViewController(viewModel: PopulationViewModel())
        ]
        
        tabBarController.tabBar.items?[0].image = UIImage(systemName: "tornado")
        tabBarController.tabBar.items?[0].title = "Air Quality"
        tabBarController.tabBar.items?[1].image = UIImage(systemName: "thermometer.sun")
        tabBarController.tabBar.items?[1].title = "Weather"
        tabBarController.tabBar.items?[2].image = UIImage(systemName: "tree")
        tabBarController.tabBar.items?[2].title = "Specie"
        tabBarController.tabBar.items?[3].image = UIImage(systemName: "sun.max")
        tabBarController.tabBar.items?[3].title = "Solar"
        tabBarController.tabBar.items?[4].image = UIImage(systemName: "person.3")
        tabBarController.tabBar.items?[4].title = "Population"
        
        
        tabBarController.tabBar.unselectedItemTintColor = .darkGray

        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
}

