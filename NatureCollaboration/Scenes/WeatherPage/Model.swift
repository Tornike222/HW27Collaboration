//
//  Model.swift
//  NatureCollaboration
//
//  Created by Nini Bardavelidze on 18.05.24.
//

import Foundation

struct WeatherForecast: Codable {
    let list: [WeatherData]
}

struct WeatherData: Codable, Identifiable {
    let id = UUID()
    let dt: TimeInterval
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}
