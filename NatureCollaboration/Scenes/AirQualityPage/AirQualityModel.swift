//
//  AirQualityModel.swift
//  NatureCollaboration
//
//  Created by Sandro Gelashvili on 17.05.24.
//

import Foundation

struct AirQualityModel: Decodable {
    struct Data: Decodable {
        struct Current: Decodable {
            struct Pollution: Decodable {
                let ts: String
                let aqius: Int
                let mainus: String
                let aqicn: Int
                let maincn: String
            }
            let pollution: Pollution
        }
        let city: String
        let state: String
        let country: String
        let current: Current
    }
    let data: Data
}

