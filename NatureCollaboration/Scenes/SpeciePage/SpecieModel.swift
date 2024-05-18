//
//  CitiesModel.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import Foundation

struct CitiesModel: Decodable {
    let results: [Cities]
}

struct Cities: Decodable {
    let id: Int?
}

struct SpeciesModel: Decodable, Hashable {
    let results: [Species]
}

struct Species: Decodable, Hashable {
    let taxon: TaxonDetails
}

struct TaxonDetails: Decodable, Hashable {
    let name: String?
    let default_photo: PhotoDetails
    let wikipedia_url: String?
    let preferred_common_name: String?
}

struct PhotoDetails: Decodable, Hashable {
    let medium_url: String?
    let attribution: String?
}

