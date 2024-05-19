//
//  PopulationViewModel.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import Foundation
import NetworkPackage

protocol PopulationViewModelDelegate: AnyObject {
    func updatePopulation(with totalPopulation: [TotalPopulation])
}

class PopulationViewModel {
    var networkService = NetworkService()
    var populationData: PopulationModel?
    weak var delegate: PopulationViewModelDelegate?
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchPopulationData(country: String?) {
        guard let country = country, !country.isEmpty else { return }
        
        let baseUrl = "https://d6wn6bmjj722w.population.io:443"
        
        let urlString = baseUrl + "/1.0/population/\(country)/today-and-tomorrow/?format=json"
        networkService.getData(urlString: urlString) { [self] (result: PopulationModel?, error: Error?) in
            if error != nil {
                return
            }
            guard let result = result else {
                return
            }
            
            self.populationData = result
            delegate?.updatePopulation(with: self.populationData!.totalPopulation)
        }
    }
    
}
