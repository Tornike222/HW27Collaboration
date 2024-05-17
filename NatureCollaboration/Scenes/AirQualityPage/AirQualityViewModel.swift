//
//  AirQualityViewModel.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import Foundation
import NetworkPackage

protocol AirQualityViewModelDelegate: AnyObject {
    func updateAirQualityInfo()
}

class AirQualityViewModel {
    // MARK: - Properties
    private var networkService = NetworkService()
    var airQualityData: AirQualityModel?
    weak var delegate: AirQualityViewModelDelegate?
    
    private(set) var airQualityInfo: [(title: String, value: String)] = [] {
        didSet {
            delegate?.updateAirQualityInfo()
        }
    }
    var errorMessage: String? {
        didSet {
            self.showError?()
        }
    }
    
    var showError: (() -> Void)?
    
    // MARK: Lifecycle
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: Methods
    func fetchAirQualityData(city: String, state: String, country: String) {
        let urlString = "https://api.airvisual.com/v2/city?city=\(city)&state=\(state)&country=\(country)&key=daa8e5fe-96fa-4e8a-aa71-3ed1ec511490"
        networkService.getData(urlString: urlString) { (result: AirQualityModel?, error: Error?) in
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            guard let result = result else {
                self.errorMessage = "No data received"
                return
            }
            let pollution = result.data.current.pollution
            self.airQualityInfo = [
                (title: "Time:", value: pollution.ts),
                (title: "Aqius:", value: String(pollution.aqius)),
                (title: "Mainus:", value: pollution.mainus),
                (title: "Aqicn:", value: String(pollution.aqicn)),
                (title: "Maincn:", value: pollution.maincn)
            ]
        }
    }
}
