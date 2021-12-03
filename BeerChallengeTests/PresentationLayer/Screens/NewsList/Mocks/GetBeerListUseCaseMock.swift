//
//  GetBeerListUseCaseMock.swift
//  BeerChallengeTests
//
//  Created by Josseph Colonia on 2/12/21.
//

import Foundation
@testable import BeerChallenge

final class GetBeerListUseCaseMock: GetBeerListUseCaseProtocol {
    var provider: BeerProviderProtocol = BeerProvider()
    var result: Result<[BeerModel], Error>?
    
    func run(query: String?, completion: @escaping (Result<[BeerModel], Error>) -> ()) {
        if let result = result {
            completion(result)
        } else {
            completion(.failure(NSError()))
        }
    }
}
