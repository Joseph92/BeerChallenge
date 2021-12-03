//
//  BeerProvider.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import Foundation
import Alamofire

protocol BeerProviderProtocol {
    typealias getBeerListResult = Result<[BeerEntity], Error>
    
    func getBeerList(query: String?, completion: @escaping (getBeerListResult) -> ())
}

final class BeerProvider: BeerProviderProtocol {
    enum BeerService: String {
        case newsList = "https://api.punkapi.com/v2/beers"
    }
    
    func getBeerList(query: String?, completion: @escaping (getBeerListResult) -> ()) {
        let url = BeerService.newsList.rawValue + (query != nil ? "?beer_name=\(query ?? "")" : "")
        AF.request(url) { request in
            request.timeoutInterval = 2
        }.responseData { response in
            switch response.result {
            case let .success(data):
                do {
                    let entity = try JSONDecoder().decode([BeerEntity].self, from: data)
                    completion(.success(entity))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
