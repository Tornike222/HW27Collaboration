//
//  SpecieViewModel.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import Foundation
import NetworkPackage

//MARK: - SpecieViewModelDelegate protocol
protocol SpecieViewModelDelegate: AnyObject{
    func reloadCollectionViewData()
    func startAnimation()
    func showErrorAlert()
}

final class SpecieViewModel {
    //MARK: - Properties
    private var cityModel: CitiesModel?
    var specieModel: SpeciesModel?
    weak var delegate: SpecieViewModelDelegate?
    
    //MARK: - Api Fetcher Function fetchCityData
    func fetchCityData(city: String?) {
        guard let city = city,!city.isEmpty else {
            delegate?.showErrorAlert()
            return
        }
        delegate?.startAnimation()
        let baseUrl = "https://api.inaturalist.org"
        let cityUrlString = baseUrl + "/v1/places/autocomplete?q=\(city)&fbclid=IwAR3nm4STU-6VppZFtvIbosK0MNna1RVUWx-bZyiQsOUrRCpolMq_vX_oSL0#"

        NetworkService().getData(urlString: cityUrlString) { (result: CitiesModel?, Error) in
            self.cityModel = result ?? self.cityModel
            if let placeId = self.cityModel?.results.first?.id! {
                let specieUrlString = baseUrl + "/v1/observations/species_counts?place_id=\(placeId)&fbclid=IwAR06JC3zndw5-AaDGxslLz4jUVqOS23FjnZSjI-C1no9DZg3L4uRq3P1Xcg"
                NetworkService().getData(urlString: specieUrlString) { (resultOfSpecie: SpeciesModel?, Error) in
                    self.specieModel = resultOfSpecie ?? self.specieModel
                    self.delegate?.reloadCollectionViewData()
                }
            }
        }
    }
    //MARK: - Author Name Extractor function extractName
    func extractName(from string: String?) -> String? {
        let components = string?.split(separator: ",")
        if let firstComponent = components?.first, !firstComponent.isEmpty {
            let name = firstComponent.replacingOccurrences(of: "(c) ", with: "").trimmingCharacters(in: .whitespaces)
            return name
        }
        return nil
    }
}
