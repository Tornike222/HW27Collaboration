import Foundation

struct WeatherForecast: Decodable {
    let list: [WeatherData]
}

struct WeatherData: Decodable, Identifiable {
    var id: TimeInterval {
        return dt
    }
    let dt: TimeInterval
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double?
}

struct Weather: Decodable {
    let description: String?
}

struct Coordinates: Decodable {
    let lon: Double?
    let lat: Double?
}

