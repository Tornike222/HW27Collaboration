//
//  CitiesModel.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import Foundation

//MARK: - CitiesModel
struct CitiesModel: Decodable {
    let results: [Cities]
}

struct Cities: Decodable {
    let id: Int?
}

//MARK: - SpeciesModel
struct SpeciesModel: Decodable, Hashable {
    let results: [Species]
}

struct Species: Decodable, Hashable {
    let taxon: TaxonDetails
}

struct TaxonDetails: Decodable, Hashable {
    let name: String?
    let defaultPhoto: PhotoDetails
    let wikipediaUrl: String?
    let preferredCommonName: String?

    enum CodingKeys: String, CodingKey {
        case name
        case defaultPhoto = "default_photo"
        case wikipediaUrl = "wikipedia_url"
        case preferredCommonName = "preferred_common_name"
    }
}

struct PhotoDetails: Decodable, Hashable {
    let mediumUrl: String?
    let attribution: String?

    enum CodingKeys: String, CodingKey {
        case mediumUrl = "medium_url"
        case attribution
    }
}
