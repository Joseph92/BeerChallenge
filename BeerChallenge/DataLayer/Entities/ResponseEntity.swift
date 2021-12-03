//
//  ResponseEntity.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import Foundation


/*
 Si se estandariza la respuesta del Response del API, se podria tener una sola enstructura base con genericos para mapear los json
*/

struct ResponseEntity<T: Decodable>: Decodable {
    let status: String
    let results: T
    
    enum CodingKeys: String, CodingKey {
        case response
        case status
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        status = try response.decode(String.self, forKey: .status)
        results = try response.decode(T.self, forKey: .results)
    }
}

struct ResponseContentEntity<T: Decodable>: Decodable {
    let status: String
    let content: T
    
    enum CodingKeys: String, CodingKey {
        case response
        case status
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        status = try response.decode(String.self, forKey: .status)
        content = try response.decode(T.self, forKey: .content)
    }
}
