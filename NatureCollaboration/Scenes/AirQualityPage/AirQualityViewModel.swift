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
    func showAllert()
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
    func unwrapData(city: String?, state: String?, country: String?) {
        guard let country = country, !country.isEmpty,
              let state = state, !state.isEmpty,
              let city = city, !city.isEmpty else {
            delegate?.showAllert()
            return
        }
       fetchAirQualityData(city: city, state: state, country: country)
    }
    
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
            let date = self.convertTimestampToDate(pollution.ts)
            let dateString = date != nil ? DateFormatter.localizedString(from: date!, dateStyle: .medium, timeStyle: .medium) : "Invalid date"
            self.airQualityInfo = [
                (title: "Time:", value: dateString),
                (title: "Aqius:", value: String(pollution.aqius)),
                (title: "Mainus:", value: pollution.mainus),
                (title: "Aqicn:", value: String(pollution.aqicn)),
                (title: "Maincn:", value: pollution.maincn)
            ]
        }
    }
    
    func convertTimestampToDate(_ timestamp: String) -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return isoFormatter.date(from: timestamp)
    }
}
