//
//  GetBeerListUseCase.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import Foundation

protocol GetBeerListUseCaseProtocol {
    var provider: BeerProviderProtocol { get }
    
    func run(query: String?, completion: @escaping (Result<[BeerModel], Error>) -> ())
}

final class GetBeerListUseCase: GetBeerListUseCaseProtocol {
    var provider: BeerProviderProtocol
    private var mapper: BeerMapperProtocol
    
    init(provider: BeerProviderProtocol,
         mapper: BeerMapperProtocol) {
        self.provider = provider
        self.mapper = mapper
    }
    
    func run(query: String?, completion: @escaping (Result<[BeerModel], Error>) -> ()) {
        provider.getBeerList(query: query) { result in
            switch result {
            case let .success(response):
                let model = response.compactMap { [weak self] entity -> BeerModel? in
                    guard let self = self else { return nil }
                    return self.mapper.map(entity: entity)
                }
                completion(.success(model))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
