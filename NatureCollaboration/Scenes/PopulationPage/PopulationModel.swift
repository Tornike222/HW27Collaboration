//
//  PopulationPageModel.swift
//  NatureCollaboration
//
//  Created by Sandro Gelashvili on 18.05.24.
//

import Foundation

struct PopulationModel: Decodable {
    let totalPopulation: [TotalPopulation]
    
    enum CodingKeys: String, CodingKey {
        case totalPopulation = "total_population"
    }
}

struct TotalPopulation: Decodable {
    let date: String?
    let population: Int?
}
