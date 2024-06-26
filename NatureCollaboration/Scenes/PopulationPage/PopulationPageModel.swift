//
//  PopulationPageModel.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 19.05.24.
//

import Foundation

//MARK: - Population Model 
struct PopulationPageModel: Decodable {
    let totalPopulation: [TotalPopulation]
    
    enum CodingKeys: String, CodingKey {
        case totalPopulation = "total_population"
    }
}
 
struct TotalPopulation: Decodable {
    let date: String?
    let population: Int?
}
