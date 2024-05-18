//
//  WeatherViewModel.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import Foundation
import NetworkPackage

protocol WeatherViewModelDelegate: AnyObject {
    func updateWeatherInfo()
    func showAlert()
}

class WeatherViewModel {
    // MARK: - Properties
    private var networkService = NetworkService()
    var weatherData: WeatherForecast?
    weak var delegate: WeatherViewModelDelegate?
    
    private(set) var weatherInfo: [(title: String, value: String)] = [] {
        didSet {
            delegate?.updateWeatherInfo()
        }
    }
    var errorMessage: String? {
        didSet {
            self.showError?()
        }
    }
    
    var showError: (() -> Void)?
    
    // MARK: - Lifecycle
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Methods
    func unwrapData(latitude: String?, longitude: String?) {
        guard let latitude = Double(latitude ?? ""),
              let longitude = Double(longitude ?? "") else {
            delegate?.showAlert()
            return
        }
        fetchWeatherData(latitude: String(latitude), longitude: String(longitude))    
    }
    
    func fetchWeatherData(latitude: String, longitude: String) {
        let apiKey = "cf556296fa9582e3d8f86a3a0ac1fdc4"
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        networkService.getData(urlString: urlString) { [weak self] (result: WeatherForecast?, error: Error?) in
           
            guard let result = result else {
                self?.errorMessage = "No data received"
                
                return
            }
            self?.processWeatherData(result)
        }
    }
    
    private func processWeatherData(_ result: WeatherForecast) {
        let weatherList = result.list
        self.weatherInfo = weatherList.map { weatherData in
            let date = Date(timeIntervalSince1970: TimeInterval(weatherData.dt))
            let dateString = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .medium)
            return [
                (title: "Date:", value: dateString),
                (title: "Temperature:", value: "\(weatherData.main.temp)°C"),
                (title: "Description:", value: weatherData.weather.first?.description ?? "N/A")
            ]
        }.flatMap { $0 }
    }
}

