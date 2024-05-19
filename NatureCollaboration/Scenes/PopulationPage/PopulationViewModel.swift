//
//  PopulationViewModel.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import Foundation
import NetworkPackage

//MARK: - Delegates protocol
protocol PopulationViewModelDelegate: AnyObject {
    func updatePopulation(with totalPopulation: [TotalPopulation])
    func startLoading()
    func stopLoading()
}

class PopulationViewModel {
    //MARK: - Properties
    var networkService = NetworkService()
    var populationData: PopulationPageModel?
    weak var delegate: PopulationViewModelDelegate?
    //MARK: - Init
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    //MARK: - Fetch Function
    func fetchPopulationData(country: String?) {
        guard let country = country, !country.isEmpty else { return }
        delegate?.startLoading()

        let baseUrl = "https://d6wn6bmjj722w.population.io:443"
        let urlString = baseUrl + "/1.0/population/\(country)/today-and-tomorrow/?format=json"
        networkService.getData(urlString: urlString) {(result: PopulationPageModel?, error: Error?) in
            guard let result = result else {
                self.delegate!.stopLoading()
                return
            }
            
            self.populationData = result
            self.delegate!.stopLoading()
            self.delegate?.updatePopulation(with: self.populationData!.totalPopulation)
        }
    }
    
}
