//
//  SolarResourceModel.swift
//  NatureCollaboration
//
//  Created by Mariam Sreseli on 5/17/24.
//

import Foundation

struct SolarData: Decodable {
    let version: String?
    let warnings: [String]?
    let errors: [String]?
    let metadata: Metadata?
    let inputs: Inputs?
    let outputs: Outputs?
    
    struct Metadata: Decodable {
        let sources: [String]?
    }
    
    struct Inputs: Decodable {
        let address: String?
    }
    
    struct Outputs: Decodable {
        let avgDni: SolarValues?
        let avgGhi: SolarValues?
        let avgLatTilt: SolarValues?
        
        enum CodingKeys: String, CodingKey {
            case avgDni = "avg_dni"
            case avgGhi = "avg_ghi"
            case avgLatTilt = "avg_lat_tilt"
        }
    }
    
    struct SolarValues: Decodable {
        let annual: Double?
        let monthly: [String: Double]?
    }
}
