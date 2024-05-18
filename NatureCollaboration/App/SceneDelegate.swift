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
        
        setTitleAndImage(image: "tornado", title: "Air Quality", index: 0)
        setTitleAndImage(image: "thermometer.sun", title: "Weather", index: 1)
        setTitleAndImage(image: "tree", title: "Specie", index: 2)
        setTitleAndImage(image: "sun.max", title: "Solar", index: 3)
        setTitleAndImage(image: "person.3", title: "Population", index: 4)
        
        tabBarController.tabBar.unselectedItemTintColor = .white
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        func setTitleAndImage(image: String, title: String, index: Int) {
            tabBarController.tabBar.items?[index].image = UIImage(systemName: image)
            tabBarController.tabBar.items?[index].title = title
        }
    }
    

    
}

