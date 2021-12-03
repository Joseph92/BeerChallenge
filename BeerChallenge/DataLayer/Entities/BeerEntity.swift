//
//  BeerEntity.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import Foundation

struct BeerEntity: Decodable {
    let id: Int
    let name: String?
    let tagline: String?
    let firstBrewedDate: String?
    let image: String?
    let description: String?
    let foodPairing: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline
        case firstBrewedDate = "first_brewed"
        case description
        case image = "image_url"
        case foodPairing = "food_pairing"
    }
}
