//
//  SolarResourceModel.swift
//  NatureCollaboration
//
//  Created by Mariam Sreseli on 5/17/24.
//

import Foundation

import Foundation

// MARK: - SolarResourceResponse
struct SolarResourceResponse: Codable {
    let version: String
    let warnings: [String]
    let errors: [String]
    let metadata: Metadata
    let inputs: Inputs
    let outputs: Outputs?
}

struct Metadata: Codable {
    let sources: [String]
}

struct Inputs: Codable {
    let address: String
}

struct Outputs: Codable {
    let avgDni: Double?
    let avgGhi: Double?
    let avgLatTilt: Double?

    enum CodingKeys: String, CodingKey {
        case avgDni = "avg_dni"
        case avgGhi = "avg_ghi"
        case avgLatTilt = "avg_lat_tilt"
    }
}
