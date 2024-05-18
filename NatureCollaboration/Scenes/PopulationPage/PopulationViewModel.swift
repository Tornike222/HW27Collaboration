//
//  PopulationViewModel.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import Foundation
import NetworkPackage

protocol PopulationViewModelDelegate: AnyObject {
    func updatePopulation(today: Int, tomorrow: Int)
}

class PopulationViewModel {
    var networkService = NetworkService()
    var populationData: PopulationPageModel?
    weak var delegate: PopulationViewModelDelegate?
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func checkAndFetchPopulation(country: String) {
        guard let country = countryNametextField.text, !country.isEmpty else {
            print("Error: please, enter country name")
            return
        }
        fetchPopulationData(country: country)
        
    }
    
    func fetchPopulationData(country: String) {
        let urlString = "https://d6wn6bmjj722w.population.io:443/1.0/population/\(country)/today-and-tomorrow/"
        networkService.getData(urlString: urlString) { (result: PopulationPageModel?, error: Error?) in
            if error != nil {
                print("Error1")
                return
            }
            guard let result = result else {
                print("Error2")
                return
            }
        }
    }
    
}
