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
    func showAllert(message: String)
    func showViewForStack()
    func textFieldsHighlighted()
}

final class AirQualityViewModel {
    // MARK: - Properties
    private var networkService = NetworkService()
    var airQualityData: AirQualityModel?
    weak var delegate: AirQualityViewModelDelegate?
    
    private(set) var airQualityInfo: [(title: String, value: String)] = [] {
        didSet {
            delegate?.updateAirQualityInfo()
            delegate?.showViewForStack()
        }
    }
    
    // MARK: Lifecycle
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: Methods
    func checkAndFetchAirQuality(city: String?, state: String?, country: String?) {
        guard let country = country, !country.isEmpty,
              let state = state, !state.isEmpty,
              let city = city, !city.isEmpty else {
            delegate?.showAllert(message: "Please fill in all fields")
            delegate?.textFieldsHighlighted()
            return
        }
        fetchAirQualityData(city: city, state: state, country: country)
    }
    
    private func fetchAirQualityData(city: String, state: String, country: String) {
        let urlString = "https://api.airvisual.com/v2/city?city=\(city)&state=\(state)&country=\(country)&key=daa8e5fe-96fa-4e8a-aa71-3ed1ec511490"
        networkService.getData(urlString: urlString) { (result: AirQualityModel?, error: Error?) in
            if error != nil {
                return
            }
            guard let result = result else {
                return
            }
            let pollution = result.data.current.pollution
            let date = self.convertTimestampToDate(pollution.ts ?? "")
            let dateString = date != nil ? self.formatDateToHoursAndMinutes(date: date!) : "Invalid date"
            self.airQualityInfo = [
                (title: "Time:", value: dateString),
                (title: "Aqius:", value: String(pollution.aqius ?? 0)),
                (title: "Mainus:", value: pollution.mainus ?? "N/A"),
                (title: "Aqicn:", value: String(pollution.aqicn ?? 0)),
                (title: "Maincn:", value: pollution.maincn ?? "N/A")
            ]
        }
    }
    
    private func convertTimestampToDate(_ timestamp: String) -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return isoFormatter.date(from: timestamp)
    }
    
    private func formatDateToHoursAndMinutes(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
