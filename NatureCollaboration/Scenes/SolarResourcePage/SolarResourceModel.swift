//
//  SolarResourceModel.swift
//  NatureCollaboration
//
//  Created by Mariam Sreseli on 5/17/24.
//

import Foundation

struct SolarData: Decodable {
    let outputs: Outputs?
    
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
    }
}
