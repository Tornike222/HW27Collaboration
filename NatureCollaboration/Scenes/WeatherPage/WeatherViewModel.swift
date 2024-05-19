import Foundation
import NetworkPackage

protocol WeatherViewModelDelegate: AnyObject {
    func updateWeatherInfo()
    func showAlert(with message: String)
}

struct WeatherDataFormatted {
    let date: String
    let description: String
    let temperature: String
}

final class WeatherViewModel {
    // MARK: - Properties
    private var networkService = NetworkService()
    var weatherData: WeatherForecast?
    weak var delegate: WeatherViewModelDelegate?
    
    private(set) var weatherInfo: [WeatherDataFormatted] = [] {
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
    func unwrapAndFetchWeatherData(latitude: String?, longitude: String?) {
        guard let latitude = Double(latitude ?? ""),
              let longitude = Double(longitude ?? ""),
              (-90...90).contains(latitude),
              (-180..<180).contains(longitude) else {
            delegate?.showAlert(with: "Invalid input data. Latitude must be between -90 and 90. Longitude must be between -180 and 180.")
            return
        }
        fetchWeatherData(latitude: String(latitude), longitude: String(longitude))
    }
    
    func fetchWeatherData(latitude: String, longitude: String) {
        let apiKey = "cf556296fa9582e3d8f86a3a0ac1fdc4"
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        networkService.getData(urlString: urlString) { [weak self] (result: WeatherForecast?, error: Error?) in
            
            guard let result = result else {
                self?.delegate?.showAlert(with: "No data received")
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
            return WeatherDataFormatted(
                date: dateString,
                description: weatherData.weather.first?.description ?? "N/A",
                temperature: "\(weatherData.main.temp!)°C"
            )
        }
    }
}

