//
//  BeerMapper.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import Foundation

protocol BeerMapperProtocol {
    func map(entity: BeerEntity) -> BeerModel
}

// Adapter Pattern
final class BeerMapper: BeerMapperProtocol {
    func map(entity: BeerEntity) -> BeerModel {
        let imageURL = URL(string: entity.image ?? "")
        
        return .init(id: entity.id,
                     name: entity.name ?? "",
                     tagline: entity.tagline ?? "",
                     firstBrewedDate: entity.firstBrewedDate ?? "",
                     image: imageURL,
                     description: entity.description ?? "",
                     foodPairing: entity.foodPairing ?? [])
    }
}
